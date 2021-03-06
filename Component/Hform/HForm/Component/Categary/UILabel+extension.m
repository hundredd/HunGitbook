//
//  UILabel+extension.m
//  QHZC
//
//  Created by Cash on 4/10/16.
//  Copyright © 2016年 QHJF. All rights reserved.
//

#import "UILabel+extension.h"

@implementation UILabel (extension)

+(instancetype)labelWithText:(NSString *)text font:(CGFloat)fontFloat textColor:(nullable UIColor *)textColor backgroundColor:(UIColor *)backgroundColor  isSizeToFit:(BOOL)isSizeToFit
{
    UILabel *label = [UILabel new];
    label.backgroundColor = backgroundColor;
    label.font = UIFontSizeWithDefault(fontFloat);
    label.text = text;
    label.textColor = textColor;
    if(isSizeToFit){
        [label sizeToFit];
    }
    return label;
}
@end
