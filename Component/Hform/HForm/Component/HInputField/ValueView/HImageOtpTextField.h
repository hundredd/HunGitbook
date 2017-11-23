//
//  HImageOtpTextField.h
//  HJF
//
//  Created by 方立立 on 16/7/14.
//  Copyright © 2016年 HJF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HInputField.h"
@interface HImageOtpTextField : UIView <HValueViewInput>

@property (nonatomic, weak) id<HValueViewDelegate> delegate;

- (void)setButtonImage:(UIImage*)image;
- (void)setTitle:(NSString*)title;
- (void)setEnabled:(BOOL)enabled;

@end
