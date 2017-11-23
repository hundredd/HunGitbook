//
//  HBankCardTextField.h
//  HJF
//
//  Created by Keldon on 15/3/16.
//  Copyright (c) 2015年 Keldon. All rights reserved.
//

#import <UIKit/UIKit.h>

// 银行卡按钮键盘
@protocol HDecimalKeyboardDelegate <NSObject>

-(void)keyboardDidPress:(UIButton*)sender;
-(void)keyboardDidReturn;
-(void)keyboardDidDelete;

@end

@interface HDecimalKeyboard : UIView

@property(nonatomic, weak) id<HDecimalKeyboardDelegate> delegate;

@end

@interface HDecimalTextField : UITextField<HDecimalKeyboardDelegate>

@end
