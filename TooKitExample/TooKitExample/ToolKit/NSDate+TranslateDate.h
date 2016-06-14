//
//  NSDate+TranslateDate.h
//  Hygge
//
//  Created by it on 16/6/2.
//  Copyright © 2016年 com.foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>

//TEST
/**
 *  日期格式
 */
typedef NS_ENUM(NSInteger, dateType) {
  /**
   *  ex:2016-06-05
   */
  DateWithHorizontalLine = 0,
  /**
   *  ex:2016/06/05
   */
  DateWithSlashLine = 1,
  /**
   *  ex:2016年06月05日
   */
  DateWithChinese = 2,
};
@interface NSDate (TranslateDate)

/**
 *  将字符串日期转换为NSDate类型
 *
 *  @param date 传入要转换的NSDate类型
 *  @param dateType 要转换成的类型
 *
 *  @return 返回字符串类型的日期
 */

+ (NSString *)translateDateToString:(NSDate *)date option:(dateType)dateType;

/**
 *  将日期字符串转换为NSDate类型（只能带有日期信息，不然会返回空）
 *
 *  @param date 传入要转换的NSDate类型
 *  @param dateType 字符串信息是什么类型
 *
 *  @return 返回字符串类型的日期
 */

+ (NSDate *)translateDateStrToNSDate:(NSString *)dateStr;

/**
 *  将日期字符串转换为想要的日期格式（exp:将2016-06-01转换为2016/06/01）
 *
 *  @param dateStr  待转换的日期字符串---the String waited translate
 *  @param dateType 想要转为的日期格式---ideal formatter
 *
 *  @return 转换后的日期字符串---the formatter you want
 */
+ (NSString *)translateDateStr:(NSString *)dateStr
                  withWantedType:(dateType)idealType;

/**
 *
 检查传入的字符串的月份和日期小于10的时候是否有0，并将传入的字符串中日期的部分替换为你想要的形式后返回。
    注意：目前只支持从前向后检查日期格式，也就是要替换的日期在字符串最前面，并且年月日要连贯（exp:2016-06-01hahahah替换为2016-6-1hahahah），不支持要替换的日期在字符串中间或末尾（exp:hahaha2016-06-01或者hahaha2016-06-01hahaha）
 *
 *  @param dateStr 传入日期字符串
 *  @param datetype想要的日期格式
 *  @param flag    替换的月份和是否含0
 *
 *  @return 替换为你想要的形式的NSString类型后返回
 */
+ (NSString *)returnTheFormatterYouWantWithDateStr:(NSString *)dateStr HaveZero:(BOOL)flag;

/**
 *  将你的日期字符串从含有这个日期的长字符串中拯救出来。
    注意：目前只支持从前向后检查日期格式，也就是要截取的日期在字符串最前面，并且年月日要连贯（exp:2016-06-01hahahah替换为2016-6-1hahahah），不支持要截取的日期在字符串中间或末尾（exp:hahaha2016-06-01或者hahaha2016-06-01hahaha）
 *
 *  @param longString 待截取的长字符串
 *
 *  @return 只含有日期的字符串
 */
+ (NSString *)saveYourDateStrFromALongString:(NSString *)longString;

/**
 *  将年月日分别以NSNumber的形式装入NSArray从你的日期字符串取出
 *
 *  @param dateStr 待取出的字符串
 *  @param dateType 日期格式
 *
 *  @return 按年、月、日的顺序存储的数组
 */
+ (NSArray*)saveTheYearMonthDayFromDateStr:(NSString*)dateStr;

@end
