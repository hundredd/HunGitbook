//
//  HTools.h
//  Demo
//
//  Created by hun on 2017/11/23.
//  Copyright © 2017年 hun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTools : NSObject
/**从199102030830 => 1991-02-23 (可以作为时间传值)*/
+(NSString *)showTimeDateWithMinReq:(NSString *)reqTime;
/**从199102030830 => 8:30 (可以作为时间传值)*/
+(NSString *)showTimeMinuteWithMinReq:(NSString *)reqTime;
/**从1991-02-23 8:30 => 199102030830  (可以作为时间传值)*/
+(NSString *)reqTimeWithShow:(NSString *)showTime andMin:(NSString *)min;

+(NSString *)dateNow;

+ (BOOL)strNilOrEmpty:(NSString *)string;

//校验是否为空,非空传回去
+(id)CheckNotNull:(id)object;
@end
