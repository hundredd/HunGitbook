//
//  HText.h
//  HJF
//
//  Created by 方立立 on 16/7/12.
//  Copyright © 2016年 HJF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HInputField.h"
typedef NS_ENUM(NSInteger, QHCharcterSet){
    kQHCharcterSet_NUM      = 0,
    kQHCharcterSet_ALPHA    = 1,
    kQHCharcterSet_ALPHANUM = 2,
    kQHCharcterSet_OTHER    = 3,
    kCharcterSet_DEFAULT  = 4,
    kCharcterSet_EMAIL    = 5
};


typedef NS_ENUM(NSUInteger, kHTextFieldFormatType) {
    kHTextFieldFormatType_PHONE,
    kHTextFieldFormatType_ID,
    kHTextFieldFormatType_BANKNO,
    kHTextFieldFormatType_NONE
};

@protocol HTextFieldFormat <NSObject>

- (NSAttributedString*)textFormat:(NSString*)string;

@end

@interface HTextField : UIView<HValueViewInput>

@property (nonatomic, weak) id<HValueViewDelegate> delegate;
@property (nonatomic, assign) kHTextFieldFormatType formatType;
@property (nonatomic, strong) UITextField* inputField;
@property (nonatomic, strong) UIColor *textColor;

@end
