//
//  NSDate+TranslateDate.m
//  Hygge
//
//  Created by it on 16/6/2.
//  Copyright © 2016年 com.foxconn. All rights reserved.
//

#import "NSDate+TranslateDate.h"

@implementation NSDate (TranslateDate)

+ (NSString*)translateDateToString:(NSDate*)date option:(dateType)dateType
{
    NSString* dateStr = [[self checkOutTheDateType:dateType] stringFromDate:date];

    return dateStr;
}

+ (NSDate*)translateDateStrToNSDate:(NSString*)dateStr
{

    dateType dateType = [self checkOutDateTypeBy:dateStr];

    NSDate* date = [[self checkOutTheDateType:dateType] dateFromString:dateStr];

    return date;
}

+ (NSString*)translateDateStr:(NSString*)dateStr withWantedType:(dateType)idealType
{

    NSDateFormatter* formatter = [self checkOutTheDateType:idealType];

    NSDate* date = [self translateDateStrToNSDate:dateStr];

    return [formatter stringFromDate:date];
}

+ (NSString*)returnTheFormatterYouWantWithDateStr:(NSString*)dateStr HaveZero:(BOOL)flag
{

    NSString* tempDateStr = [self saveYourDateStrFromALongString:dateStr];

    dateType dateType = [self checkOutDateTypeBy:tempDateStr];

    NSDate* date = [self translateDateStrToNSDate:tempDateStr];

    NSArray* dateArry = [self saveTheYearMonthDayFromDateStr:dateStr];

    if (flag)
    {
        return [NSString
            stringWithFormat:@"%@%@",
            [NSDate translateDateToString:date option:dateType],
            [dateStr stringByReplacingOccurrencesOfString:tempDateStr
                                                           withString:@""]];
    }
    else
    {
        return [NSString
            stringWithFormat:@"%@年%@月%@日%@", dateArry[0], dateArry[1],
            dateArry[2], [dateStr stringByReplacingOccurrencesOfString:tempDateStr withString:@""]];
    }
}

+ (NSString*)saveYourDateStrFromALongString:(NSString*)longString
{

    NSDate* date = [NSDate translateDateStrToNSDate:longString];
    NSString* tempDateStr = longString;
    //    检查是否只含有日期信息
    if (!date)
    {
        for (NSUInteger i = 0; i < [longString length] + 1; i++)
        {

            if ((date = [NSDate translateDateStrToNSDate:[longString substringToIndex:i]]))
            {

                tempDateStr = [longString substringToIndex:i];

                NSString* prefixStr = [[longString
                    stringByReplacingOccurrencesOfString:tempDateStr
                                              withString:@""] substringToIndex:1];
                NSScanner* scan = [NSScanner scannerWithString:prefixStr];
                int val;
                /**
         *  判断是否还有日期被漏掉，如：10日的0被漏掉
         */
                if (![scan scanInt:&val] && ![scan isAtEnd])
                {
                    /**
           *  如果为年月日类型，需要将末尾的‘日’加上，不然会出现：'''2016年06月01日日‘’‘
           */
                    dateType dateType = [self checkOutDateTypeBy:tempDateStr];
                    if (dateType == DateWithChineseStyle)
                    {
                        tempDateStr = [longString substringToIndex:(i + 1)];
                        return tempDateStr;
                    }
                    break;
                }
            }
            if (i == [longString length])
            {

                return nil;
            }
        }
    }
    return tempDateStr;
}

+ (NSArray*)saveTheYearMonthDayFromDateStr:(NSString*)dateStr
{

    if (![self checkOutDateIsAvailable:dateStr])
    {
        return nil;
    }

    NSString* tempDateStr =
        [self saveYourDateStrFromALongString:dateStr];

    NSDate* date = [self translateDateStrToNSDate:tempDateStr];

    NSCalendar* calendar =
        [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateComponents* comps = [[NSDateComponents alloc] init];

    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    comps = [calendar components:unitFlags fromDate:date];

    return @[ @([comps year]), @([comps month]), @([comps day]) ];
}

/**
 *  检查日期是否合法
 *
 *  @param dateStr 待检查的日期字符串
 *
 *  @return 返回真或假
 */
+ (BOOL)checkOutDateIsAvailable:(NSString*)dateStr
{
    dateType dateType = [self checkOutDateTypeBy:dateStr];

    NSDateFormatter* formatter = [self checkOutTheDateType:dateType];

    return ([formatter dateFromString:dateStr] != nil) ? YES : NO;
}

/**
 *  通过日期字符串判断是什么日期格式
 *
 *  @param dateStr 待判断的日期字符串
 *
 *  @return 日期格式
 */
+ (dateType)checkOutDateTypeBy:(NSString*)dateStr
{
    if ([dateStr containsString:@"年"])
    {
        return DateWithChineseStyle;
    }
    else if ([dateStr containsString:@"-"])
    {
        return DateWithHorizontalLine;
    }
    else if ([dateStr containsString:@"/"])
    {
        NSDateFormatter* formatter = [self checkOutTheDateType:DateWithAmericanStyle];
        if ([formatter dateFromString:dateStr])
        {
            return DateWithAmericanStyle;
        }
        return DateWithSlashLine;
    }
    return 666;
}

/**
 *  通过日期格式返回相应的NSDateFormatter
 *
 *  @param dateType 日期格式
 *
 *  @return NSDateFormatter
 */
+ (NSDateFormatter*)checkOutTheDateType:(dateType)dateType
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    switch (dateType)
    {
    case DateWithSlashLine:
        [formatter setDateFormat:@"yyyy/MM/dd"];
        break;

    case DateWithHorizontalLine:
        [formatter setDateFormat:@"yyyy-MM-dd"];
        break;

    case DateWithChineseStyle:
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        break;

    case DateWithAmericanStyle:
        [formatter setDateFormat:@"MM/dd/yyyy"];
        break;

    default:
        return nil;
        break;
    }
    return formatter;
}

/**
 *  通过传入格式来自定义NSDateformatter
 *
 *  @param style exp:yyyy/MM/dd
 *
 *  @return 自定义的NSDateFormatter类型的formatter
 */
+ (NSDateFormatter*)makeFormatterWithStyle:(NSString*)style
{

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:style];

    return formatter;
}

@end
