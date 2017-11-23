//
//  HTools.m
//  Demo
//
//  Created by hun on 2017/11/23.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "HTools.h"

@implementation HTools
//这里是比较特殊的时间处理方式
/**从199102030830 => 1991-02-23 (可以作为时间传值)*/
+(NSString *)showTimeDateWithMinReq:(NSString *)reqTime
{
    if (!reqTime||reqTime==nil) {
        return @"";
    }
    if ([reqTime containsString:@"长期"])
    {
        return @"长期有效";
    }
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMddHHmm"];
    //这里是创建date
    NSDate *inputDate = [inputFormatter dateFromString:reqTime];
    
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    return [outputFormatter stringFromDate:inputDate];
}

/**从199102030830 => 8:30 (可以作为时间传值)*/
+(NSString *)showTimeMinuteWithMinReq:(NSString *)reqTime
{
    if (!reqTime||reqTime==nil) {
        return @"";
    }
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMddHHmm"];
    //这里是创建date
    NSDate *inputDate = [inputFormatter dateFromString:reqTime];
    
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"HH:mm"];
    return [outputFormatter stringFromDate:inputDate];
}


/**从1991-02-23 8:30 => 199102030830  (可以作为时间传值)*/
+(NSString *)reqTimeWithShow:(NSString *)showTime andMin:(NSString *)min
{
    if (!showTime) {
        return @"";
    }
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    //这里是创建date
    NSDate *inputDate = [inputFormatter dateFromString:showTime];
    
    NSDateFormatter *inputMinFormatter= [[NSDateFormatter alloc] init];
    [inputMinFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputMinFormatter setDateFormat:@"HH:mm"];
    //这里是创建date
    NSDate *inputMin = [inputMinFormatter dateFromString:min];
    
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyyMMdd"];
    
    NSDateFormatter *outputMinFormatter= [[NSDateFormatter alloc] init];
    [outputMinFormatter setLocale:[NSLocale currentLocale]];
    [outputMinFormatter setDateFormat:@"HHmm"];
    return [NSString stringWithFormat:@"%@%@",[outputFormatter stringFromDate:inputDate],[outputMinFormatter stringFromDate:inputMin]];
}


+(NSString *)dateNow
{
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [NSDate date];
    return [outputFormatter stringFromDate:datenow];
}
//判断字符串空或nil
+ (BOOL)strNilOrEmpty:(NSString *)string
{
    if ([string isKindOfClass:[NSString class]]) {
        if (string.length > 0) {
            return NO;
        }
        else {
            return YES;
        }
    }
    else {
        return YES;
    }
}

+(id)CheckNotNull:(id)object
{
    //如果是空的就传空字符串,主要用在数据解析过程
    if (!object) {
        return @"";
    }
    if ([object isKindOfClass:[NSString class]]) {
        //去除左右的空格!不去除中间的
        object = [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    return object;
}

@end
