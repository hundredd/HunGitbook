//
//  UIImage+HForm.m
//  Demo
//
//  Created by hun on 2017/11/23.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "UIImage+HForm.h"

@implementation UIImage (HForm)

+(UIImage *)bundleImgWithName:(NSString *)name
{
    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: @ "infoShow" ofType :@ "Bundle"];
    NSString *imgPath= [bundlePath stringByAppendingPathComponent :[NSString stringWithFormat:@"%@@2x.png",name]];
    return [UIImage imageWithContentsOfFile:imgPath];
}

@end
