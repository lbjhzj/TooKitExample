//
//  PanButton.m
//  SmartHome
//
//  Created by 郝治鉴 on 2018/4/27.
//  Copyright © 2018年 mysoul. All rights reserved.
//

#import "PanButton.h"
#import <CoreGraphics/CGGeometry.h>

@interface PanButton()

@end

@implementation PanButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.titleLabel.font = [UIFont systemFontOfSize:40.0/3.0];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.layer.borderColor = [NCColor colorFromHexCode:@"#ffffff"].CGColor;
        self.layer.borderWidth = 1.0;
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
        [panRecognizer setMinimumNumberOfTouches:1];
        [panRecognizer setMaximumNumberOfTouches:1];
        [self addGestureRecognizer:panRecognizer];
        
    }
    return self;
}


/**
 拖拽开始

 @param gestureRecognizer <#gestureRecognizer description#>
 */
- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    CGPoint translation = [gestureRecognizer translationInView:self];
    
    if (translation.x < -100)//手指拖拽时间过长会出现异常
    {
        
    }
    
    if (translation.y > 200)//手指拖拽时间过长会出现异常
    {
        
    }
    
    UIView *view = [gestureRecognizer view];
    
    CGPoint newCenter = CGPointMake(view.center.x + translation.x, view.center.y + translation.y);
    
    NSLog(@"%@",NSStringFromCGPoint(view.frame.origin));

//    横、竖屏左上角
    if (newCenter.x-self.frame.size.width*0.5 <= 0 && newCenter.y-self.frame.size.height*0.5 <= 0)
    {
        view.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
        [gestureRecognizer setTranslation:CGPointZero inView:self];
        
        self.getCurrentPoint(view.frame.origin);

        return;
    }
    
    if (self.orientationType == Portrait)
    {
        //    竖屏左下角
        if (newCenter.x-self.frame.size.width*0.5 <= 0 && newCenter.y+self.frame.size.height*0.5 >= [self superview].height)
        {
            view.center = CGPointMake(self.frame.size.width * 0.5, [self superview].height - self.frame.size.height * 0.5);
            [gestureRecognizer setTranslation:CGPointZero inView:self];
            
            self.getCurrentPoint(view.frame.origin);

            return;
        }
        
        //    竖屏右上角
        if (newCenter.x+self.frame.size.width*0.5 >= screenW && newCenter.y-self.frame.size.height*0.5 <= 0)
        {
            view.center = CGPointMake(screenW-self.frame.size.width*0.5, self.frame.size.height*0.5);
            [gestureRecognizer setTranslation:CGPointZero inView:self];
            
            self.getCurrentPoint(view.frame.origin);

            return;
        }
        
        //    竖屏右下角
        if (newCenter.x+self.frame.size.width*0.5 >= screenW && newCenter.y+self.frame.size.height*0.5 >= [self superview].height)
        {
            view.center = CGPointMake(screenW-self.frame.size.width*0.5, [self superview].height-self.frame.size.height*0.5);
            [gestureRecognizer setTranslation:CGPointZero inView:self];
            
            self.getCurrentPoint(view.frame.origin);

            return;
        }
    }
    else
    {
        //    横屏左下角
        if (newCenter.x-self.frame.size.width*0.5 <= 0 && newCenter.y+self.frame.size.height*0.5 >= screenW)
        {
            view.center = CGPointMake(self.frame.size.width*0.5, screenW-self.frame.size.height*0.5);
            [gestureRecognizer setTranslation:CGPointZero inView:self];
            
            self.getCurrentPoint(view.frame.origin);

            return;
        }
        
        //    横屏右上角
        if (newCenter.x+self.frame.size.width*0.5 >= screenH && newCenter.y-self.frame.size.height*0.5 <= 0)
        {
            view.center = CGPointMake(screenH-self.frame.size.width*0.5, self.frame.size.height*0.5);
            [gestureRecognizer setTranslation:CGPointZero inView:self];
            
            self.getCurrentPoint(view.frame.origin);

            return;
        }
        //    横屏右下角
        if (newCenter.x+self.frame.size.width*0.5 >= screenH && newCenter.y+self.frame.size.height*0.5 >= screenW)
        {
            view.center = CGPointMake(screenH-self.frame.size.width*0.5, screenW-self.frame.size.height*0.5);
            [gestureRecognizer setTranslation:CGPointZero inView:self];
            
            self.getCurrentPoint(view.frame.origin);

            return;
        }
    }
    
//    左边界
    if (newCenter.x-self.frame.size.width*0.5 < 0)
    {
        
        view.center = CGPointMake(self.frame.size.width*0.5, newCenter.y);
        [gestureRecognizer setTranslation:CGPointZero inView:self];
        
        self.getCurrentPoint(view.frame.origin);

        return;
    }
    
//    下边界
    if (newCenter.y-self.frame.size.height*0.5 < 0)
    {
        view.center = CGPointMake(newCenter.x, self.frame.size.height*0.5);
        [gestureRecognizer setTranslation:CGPointZero inView:self];
        
        self.getCurrentPoint(view.frame.origin);

        return;
    }
    
//    右边界
    if (self.orientationType == Portrait)
    {
        if (newCenter.x+self.frame.size.width*0.5 > screenW) {
            
            view.center = CGPointMake(screenW-self.frame.size.width*0.5, newCenter.y);
            [gestureRecognizer setTranslation:CGPointZero inView:self];
            
            self.getCurrentPoint(view.frame.origin);

            return;
        }
    }
    else
    {
        if (newCenter.x+self.frame.size.width * 0.5 > screenH) {
            
            view.center = CGPointMake(screenH-self.frame.size.width*0.5, newCenter.y);
            [gestureRecognizer setTranslation:CGPointZero inView:self];
            
            self.getCurrentPoint(view.frame.origin);

            return;
        }
    }
    
//    上边界
    if (self.orientationType == Portrait)
    {
        if (newCenter.y+self.frame.size.height*0.5 > [self superview].height) {
            
            view.center = CGPointMake(newCenter.x, [self superview].height-self.frame.size.height*0.5);
            [gestureRecognizer setTranslation:CGPointZero inView:self];
            
            self.getCurrentPoint(view.frame.origin);

            return;
            
        }
    }
    else
    {
        if (newCenter.y+self.frame.size.height*0.5 > screenW) {
            
            view.center = CGPointMake(newCenter.x, screenW-self.frame.size.height*0.5);
            [gestureRecognizer setTranslation:CGPointZero inView:self];
            
            self.getCurrentPoint(view.frame.origin);

            return;
            
        }
        
    }

    view.center = newCenter;
    
    [gestureRecognizer setTranslation:CGPointZero inView:self];
    
    self.getCurrentPoint(view.frame.origin);
    
}


@end
