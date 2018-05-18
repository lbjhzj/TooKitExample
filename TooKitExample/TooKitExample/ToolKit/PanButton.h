//
//  PanButton.h
//  SmartHome
//
//  Created by 郝治鉴 on 2018/4/27.
//  Copyright © 2018年 mysoul. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Portrait,
    LandscapeLeft,
    LandscapeRight,
} DeviceOrientationType;

typedef void(^currentPointBlock)(CGPoint currentPoint);

@interface PanButton : UIButton

@property (nonatomic, copy) currentPointBlock getCurrentPoint;

/**
 旋转方向
 */
@property(nonatomic , assign)DeviceOrientationType orientationType;

@end
