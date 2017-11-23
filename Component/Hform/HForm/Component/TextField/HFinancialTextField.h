//
//  PADecimalTextField.h
//  PACFB
//
//  Created by Keldon on 15/3/14.
//  Copyright (c) 2015年 Keldon. All rights reserved.
//

#import <UIKit/UIKit.h>

// 金额按钮键盘
@protocol HFinancialKeyboardDelegate <NSObject>

-(void)keyboardDidPress:(UIButton*)sender;
-(void)keyboardDidReturn;
-(void)keyboardDidDelete;

@end

@interface HFinancialKeyboard : UIView

@property(nonatomic, weak) id<HFinancialKeyboardDelegate> delegate;

@end


@interface HFinancialTextField : UITextField<HFinancialKeyboardDelegate>

@property(nonatomic, weak) id delegate;

@end
