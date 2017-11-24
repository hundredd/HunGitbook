//
//  UILabel+extension.h
//  QHZC
//
//  Created by Cash on 4/10/16.
//  Copyright © 2016年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (extension)

+(instancetype)labelWithText:(NSString *)text font:(CGFloat)fontFloat textColor:(nullable UIColor *)textColor backgroundColor:(UIColor *)backgroundColor isSizeToFit:(BOOL)isSizeToFit;

@end
