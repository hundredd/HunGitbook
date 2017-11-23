//
//  HTextFieldFormat.m
//  HJF
//
//  Created by 方立立 on 16/7/31.
//  Copyright © 2016年 HJF. All rights reserved.
//

#import "HTextFieldFormat.h"
#import <CoreText/CoreText.h>

const long hseperatorWidth = 5.0f;

@implementation HTextFieldPhoneFormat

-(NSAttributedString *)textFormat:(NSString *)string {
    NSMutableAttributedString *mStr =[[NSMutableAttributedString alloc]initWithString:string];
    
    if (string.length > 3){
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&hseperatorWidth);
        [mStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(2,1)];
        CFRelease(num);
    }
    
    if (string.length > 7){
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&hseperatorWidth);
        [mStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(6,1)];
        CFRelease(num);
    }

    return  mStr;
}

@end

@implementation HTextFieldIDFormat

-(NSMutableAttributedString *)textFormat:(NSString *)string {
    NSMutableAttributedString *mStr =[[NSMutableAttributedString alloc]initWithString:string];
    
    if (string.length > 6){
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&hseperatorWidth);
        [mStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(5,1)];
        CFRelease(num);
    }
    
    if (string.length > 14){
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&hseperatorWidth);
        [mStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(13,1)];
        CFRelease(num);
    }
    
    return  mStr;
}

@end

@implementation HTextFieldBankNoFormat

-(NSMutableAttributedString *)textFormat:(NSString *)string {
    NSMutableAttributedString *mStr =[[NSMutableAttributedString alloc]initWithString:string];
    
    if (string.length > 4){
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&hseperatorWidth);
        [mStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(3,1)];
        CFRelease(num);
    }
    
    if (string.length > 8){
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&hseperatorWidth);
        [mStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(7,1)];
        CFRelease(num);
    }
    
    if (string.length > 12){
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&hseperatorWidth);
        [mStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(11,1)];
        CFRelease(num);
    }
    
    if (string.length > 16){
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&hseperatorWidth);
        [mStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(15,1)];
        CFRelease(num);
    }
    
    return  mStr;
}

@end
