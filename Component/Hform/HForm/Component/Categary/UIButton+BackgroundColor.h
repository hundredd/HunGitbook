//
//  UIButton+BackgroundColor.h
//  Foundation
//
//  Created by Keldon on 15/4/1.
//  Copyright (c) 2015年 Keldon. All rights reserved.
//

// 利用颜色设置UIButton的颜色
#import <UIKit/UIKit.h>

@interface UIButton (BackgroundColor)

-(void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

@end
