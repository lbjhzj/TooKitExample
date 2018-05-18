//
//  CustomTextView.m
//  Hygge
//
//  Created by Hao on 16/9/3.
//  Copyright © 2016年 com.foxconn. All rights reserved.
//

#import "CustomTextView.h"
//#import "IQKeyboardManager.h"
@interface CustomTextView ()
{
    UIMenuItem *copyMenuItem;
    
}
@property(nonatomic,strong)UIMenuController *menuController;
@property UIPasteboard *pBoard;


@end

@implementation CustomTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        

        return self;
    }
    return nil;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if (_menuController == nil) {
//        _menuController = [UIMenuController sharedMenuController];
//    }
//    if (copyMenuItem == nil) {
//        copyMenuItem = [[UIMenuItem alloc] initWithTitle:@"複製" action:@selector(copyAction:)];
//    }
//    UIMenuItem *pasteMenueItem = [[UIMenuItem alloc]initWithTitle:@"粘贴" action:@selector(pasteAction:)];
//    UIMenuItem *cutMenuItem = [[UIMenuItem alloc]initWithTitle:@"剪切" action:@selector(cutAction:)];

//    [_menuController setMenuItems:[NSArray arrayWithObjects:pasteMenueItem, nil]];
    
//    [_menuController setTargetRect:self.frame inView:self.superview];
//    
//    [_menuController setMenuVisible:YES animated: YES];

    self.returnNoFlight = NO;
    
    
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (_returnNoFlight) {
        return NO;
    }
    else
    {
        
        UIMenuController* menuController = [UIMenuController sharedMenuController];
        menuController.menuItems = nil;
        
        if ([super canPerformAction:action withSender:sender])
        {
            return YES;
        }else
        {
            return NO;
        }

        
    }
    
    
}
-(BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark 实现方法

- (void)copyAction:(id)sender {
    self.pBoard = [UIPasteboard generalPasteboard];
    self.pBoard.string = self.text;
    NSLog(@"粘贴的内容为%@", self.pBoard.string);
}

- (void)pasteAction:(id)sender {
    self.pBoard = [UIPasteboard generalPasteboard];
    self.text = [self.text stringByAppendingString:self.pBoard.string];
}

- (void)cutAction:(id)sender {
    self.pBoard = [UIPasteboard generalPasteboard];
    self.pBoard.string = self.text;
    self.text = nil;
}
@end
