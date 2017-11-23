//
//  HSelectTextField.h
//  HJF
//
//  Created by 方立立 on 16/8/7.
//  Copyright © 2016年 HJF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HInputField.h"

@interface HSelectTextField : UIView <HValueViewInput>

@property (nonatomic, weak) id<HValueViewDelegate> delegate;

- (void)setSelectImage:(UIImage *)image;

@end
