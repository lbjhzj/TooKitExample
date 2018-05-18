//
//  ViewController.m
//  TooKitExample
//
//  Created by 郝治鉴 on 16/6/2.
//  Copyright © 2016年 Hao.zj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (weak, nonatomic) IBOutlet UILabel *origionDateLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (IBAction)btn1Avtion:(UIButton *)sender
{
    self.outputLabel.text =[NSDate returnTheFormatterYouWantWithDateStr:self.outputLabel.text HaveZero:YES];
    self.origionDateLabel.text = [NSDate returnTheFormatterYouWantWithDateStr:self.origionDateLabel.text HaveZero:YES];
}

- (IBAction)btn2Avtion:(UIButton *)sender
{
    self.outputLabel.text = [NSDate translateDateStr:self.outputLabel.text withWantedType:DateWithHorizontalLine];
}

- (IBAction)btn3Avtion:(UIButton *)sender
{
    self.outputLabel.text =[NSDate translateDateStr:self.outputLabel.text withWantedType:DateWithSlashLine];
}

- (IBAction)btn4Avtion:(UIButton *)sender
{
    NSArray *arr =[NSDate saveTheYearMonthDayFromDateStr:self.outputLabel.text];
    self.outputLabel.text = [NSString stringWithFormat:@"%@ %@ %@",arr[0],arr[1],arr[2]];
}

- (IBAction)btn5Avtion:(id)sender
{
//    if ([NSDate checkOutDateIsAvailable:self.outputLabel.text])
//    {
//        self.outputLabel.text = [NSDate translateDateStr:self.outputLabel.text withWantedType:DateWithChinese];
//        self.outputLabel.text = [NSDate returnTheFormatterYouWantWithDateStr:self.outputLabel.text HaveZero:NO];
//    }
//    else
//    {
//        self.outputLabel.text = @"2016年6月1日";
//    }
    
    
    self.origionDateLabel.text = @"6/1/2016hah33ha";
}

- (IBAction)btn6Avtion:(UIButton *)sender
{
    
    self.origionDateLabel.text = [NSDate saveYourDateStrFromALongString:self.origionDateLabel.text];
}

- (IBAction)btn7Action:(UIButton *)sender
{
    self.outputLabel.text = [NSDate translateDateStr:self.outputLabel.text withWantedType:DateWithHorizontalLine];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
