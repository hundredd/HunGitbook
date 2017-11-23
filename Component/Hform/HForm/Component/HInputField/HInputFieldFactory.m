//
//  QHInputFieldFactory.m
//  QHJF
//
//  Created by 方立立 on 16/7/12.
//  Copyright © 2016年 QHJF. All rights reserved.
//

#import "HInputFieldFactory.h"


//#import "QHSafeTextField.h"
#import "HSmsOtpTextField.h"
#import "HImageOtpTextField.h"
#import "HSelectTextField.h"
#import "HDecimalInputTextField.h"
#import "HFinancialInputTextField.h"

@implementation HInputFieldFactory

+ (HInputField*)getHInputFieldWithType:(HInputFieldType)type {
    UIView<HValueViewInput>* valueView;
//    NSLog(@"进来的类型:%d",type);
    
    switch (type) {
        case QHInputFieldType_Text1:
            valueView = [[HTextField alloc] init];
            break;
        case QHInputFieldType_Decimal2:
            valueView = [[HDecimalInputTextField alloc] init];
            break;
//        case QHInputFieldType_Pwd4:
//            valueView = [[QHSafeTextField alloc] init];
//            break;
        case QHInputFieldType_SmsOtp6:
            valueView = [[HSmsOtpTextField alloc] init];
            break;
        case QHInputFieldType_ImageOtp7:
            valueView = [[HImageOtpTextField alloc] init];
            break;
        case QHInputFieldType_Select3:
            valueView = [[HSelectTextField alloc] init];
            break;
        case QHInputFieldType_Cash5:
            valueView = [[HFinancialInputTextField alloc] init];
        default:
            break;
    }
    return [[HInputField alloc] initWithValueView:valueView];
}

@end
