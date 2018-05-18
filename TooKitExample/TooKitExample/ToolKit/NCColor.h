//
//  NCColor.h
//  MKIPC
//
//  Created by 迈科 on 2017/10/9.
//  Copyright © 2017年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NCColor : NSObject

+ (UIColor *) colorFromHexCode:(NSString *)hexString;


+ (UIImage*) createImageWithColor:(UIColor*)color;

@end
