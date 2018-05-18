//
//  UpdateAlertView.m
//  SmartHome
//
//  Created by 郝治鉴 on 2018/5/10.
//  Copyright © 2018年 mysoul. All rights reserved.
//

#import "UpdateAlertView.h"

@interface UpdateAlertView ()

@property (nonatomic, copy) NSDictionary* updateInfo;

@end

@implementation UpdateAlertView

- (instancetype)initWithFrame:(CGRect)frame UpdateInfo:(NSDictionary*)updateInfo
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.updateInfo = updateInfo;
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    
    // 取更新日志信息
    NSString *changeStr = _updateInfo[@"releaseNotes"];
    // app store 最新版本号
    NSString *AppStoreVersion = _updateInfo[@"version"];

    
    UIButton * maskView = [UIButton buttonWithType:UIButtonTypeCustom];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [maskView addTarget:self action:@selector(maskViewClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIImageView *bgImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_update"]];
    bgImgView.userInteractionEnabled = YES;
    [self addSubview:bgImgView];
    
    [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(354.0/3);
        make.width.equalTo(@(894.0/3));
        make.height.equalTo(@(1075.0/3));
    }];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"以后提醒" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[NCColor colorFromHexCode:@"#9d9d9d"] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:46.0/3];
    [bgImgView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(bgImgView);
        make.width.equalTo(@(0.5*894.0/3));
        make.height.equalTo(@(132.0/3));  
    }];
    
    UIButton * updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [updateBtn addTarget:self action:@selector(updateBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [updateBtn setBackgroundColor:[NCColor colorFromHexCode:@"#e2c587"]];
    [updateBtn setTitle:@"立即升级" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[NCColor colorFromHexCode:@"#ffffff"] forState:UIControlStateNormal];
    updateBtn.titleLabel.font = [UIFont systemFontOfSize:46.0/3];
    [bgImgView addSubview:updateBtn];
    
    CGRect btnBounds = CGRectMake(0, 0, 0.5*894.0/3, 132.0/3);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btnBounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(24.0/3, 24.0/3)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = btnBounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    updateBtn.layer.mask = maskLayer;

    [updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(bgImgView);
        make.width.equalTo(@(0.5*894.0/3));
        make.height.equalTo(@(132.0/3));
    }];
    
    
    UILabel * titleLb = [[UILabel alloc] init];
    titleLb.text = [NSString stringWithFormat:@"%@V%@",@"发现新版本", AppStoreVersion];
    titleLb.textColor = [NCColor colorFromHexCode:@"#4a4a4a"];
    titleLb.font = [UIFont systemFontOfSize:54.0/3];
    [self addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImgView);
        make.top.equalTo(bgImgView).offset(272.0/3);
    }];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];;
    [bgImgView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLb.mas_bottom).offset(60.0/3);
        make.left.right.equalTo(bgImgView);
        make.bottom.equalTo(updateBtn.mas_top);
    }];
    
    UIView *containerView = [UIView new];
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView); // 需要设置宽度和scrollview宽度一样
    }];
    
    
    UILabel * updateContentLb = [[UILabel alloc] init];
    updateContentLb.text = [NSString stringWithFormat:@"%@:",@"更新内容"];
    updateContentLb.textColor = [NCColor colorFromHexCode:@"#4a4a4a"];
    updateContentLb.font = [UIFont systemFontOfSize:40.0/3];
    [containerView addSubview:updateContentLb];
    [updateContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView);
        make.left.equalTo(bgImgView.mas_left).offset(78.0/3);
    }];
    
    NSArray *contentArr = [changeStr componentsSeparatedByString:@"\n"];
    
    NSMutableArray *lbArr = [NSMutableArray arrayWithCapacity:5];

    [contentArr enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.length != 0)
        {
            UILabel * contentLb = [[UILabel alloc] init];
            contentLb.text = obj;
            contentLb.numberOfLines = 0;
            contentLb.textColor = [NCColor colorFromHexCode:@"#4a4a4a"];
            contentLb.font = [UIFont systemFontOfSize:40.0/3];
            [containerView addSubview:contentLb];
            
            UILabel *lastCotentLb = lbArr.lastObject?:updateContentLb;
            
            [lbArr addObject:contentLb];

            if (idx == contentArr.count-1)
            {
                [contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                    make.top.equalTo(lastCotentLb.mas_bottom).offset(38.0/3);

                    make.right.equalTo(bgImgView.mas_right);
                }];
                
                [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(contentLb.mas_bottom).offset(20);// 这里放最后一个view的底部
                }];
            }
            else
            {
                [contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
    
                    make.top.equalTo(lastCotentLb.mas_bottom).offset(38.0/3);

                    make.right.equalTo(bgImgView.mas_right);

                }];
            }
            
            UIView *circleView = [UIView new];
            circleView.layer.cornerRadius = 3.0f;
            [circleView.layer setMasksToBounds:YES];
            [circleView setBackgroundColor:[NCColor colorFromHexCode:@"#f4c869"]];
            [containerView addSubview:circleView];
            
            [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(contentLb);
                make.left.equalTo(updateContentLb);
                make.right.equalTo(contentLb.mas_left).offset(-10);
                make.width.height.equalTo(@6);
            }];

        }
        
    }];

}

- (void)updateBtnClicked
{
    // app store 更新链接
    NSString * trackViewUrl = _updateInfo[@"trackViewUrl"];
    
    NSURL *appStoreURL = [NSURL URLWithString:trackViewUrl];
    if ([[UIApplication sharedApplication]canOpenURL:appStoreURL])
    {
        [[UIApplication sharedApplication] openURL:appStoreURL];
    }
}

- (void)cancelBtnClicked
{
    [self removeFromSuperview];
}

- (void)maskViewClicked
{
    [self removeFromSuperview];
}



@end
