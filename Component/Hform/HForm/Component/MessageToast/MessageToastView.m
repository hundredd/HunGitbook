//
//  MessageToastView.m
//  PACFB
//
//  Created by lili on 15/6/17.
//  Copyright (c) 2015年 Keldon. All rights reserved.
//

#define kLeftMargin 15
#import "MessageToastView.h"

@interface MessageToastView() {
    NSString* _message;
    UILabel* _messageLabel;
}

@end

@implementation MessageToastView

- (id)initWithMessage:(NSString*)message {
    self = [self init];
    if (self) {
        _message = message;
        
        [self initView];
    }
    return self;
}

- (void)initView
{
    NSDictionary* fontAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize labelSize = [_message boundingRectWithSize:CGSizeMake(kScreenWidth-2*kLeftMargin, MAXFLOAT)
                                              options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:fontAttribute context:nil].size;
    CGRect rect = CGRectMake(0, 0, kScreenWidth, labelSize.height+15);
    _messageLabel = [[UILabel alloc] initWithFrame:rect];
    _messageLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.font = [UIFont systemFontOfSize:14];
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _messageLabel.numberOfLines = 0;
    _messageLabel.text = _message;
    [self addSubview:_messageLabel];
    self.frame = rect;
}

@end
