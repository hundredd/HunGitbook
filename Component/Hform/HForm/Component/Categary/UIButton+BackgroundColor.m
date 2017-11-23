//
//  UIButton+BackgroundColor.m
//  Foundation
//
//  Created by Keldon on 15/4/1.
//  Copyright (c) 2015年 Keldon. All rights reserved.
//

#import "UIButton+BackgroundColor.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIButton (BackgroundColor)

-(void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:image forState:state];
}

@end
