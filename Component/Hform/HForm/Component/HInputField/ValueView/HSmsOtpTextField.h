//
//  HOtpTextField.h
//  HJF
//
//  Created by 方立立 on 16/7/13.
//  Copyright © 2016年 HJF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HInputField.h"

@interface HSmsOtpTextField : UIView<HValueViewInput>

@property (nonatomic, weak) id<HValueViewDelegate> delegate;

- (void)startTimer;
- (void)terminateSmsTextTimer;


@end
