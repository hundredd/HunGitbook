//
//  QHInputFieldFactory.h
//  QHJF
//
//  Created by 方立立 on 16/7/12.
//  Copyright © 2016年 QHJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HInputField.h"

typedef enum : NSUInteger {
    QHInputFieldType_Text1 = 0,
    QHInputFieldType_Decimal2,
    QHInputFieldType_Select3,
    QHInputFieldType_Pwd4,
    QHInputFieldType_Cash5,
    QHInputFieldType_SmsOtp6,
    QHInputFieldType_ImageOtp7
} HInputFieldType;

@interface HInputFieldFactory : NSObject

/**
 创建QHTextField，入参包括：
 type:  输入的校验类型 ENUM类型 kInputType_NUM、kInputType_ALPHA、kInputType_ALPHANUM、kInputType_OTHER
 title: 左边label的描述
 length:输入的校验最大长度
 */

+ (HInputField*)getHInputFieldWithType:(HInputFieldType)type;

@end
