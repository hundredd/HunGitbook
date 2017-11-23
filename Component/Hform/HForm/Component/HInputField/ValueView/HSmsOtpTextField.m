//
//  HOtpTextField.m
//  HJF
//
//  Created by 方立立 on 16/7/13.
//  Copyright © 2016年 HJF. All rights reserved.
//

#import "HSmsOtpTextField.h"
#import "View+MASAdditions.h"
//#import "QHTimerUtil.h"
#import "HDecimalTextField.h"
#import "QHTimerUtil.h"

@interface HSmsOtpTextField() <UITextFieldDelegate>

@property (nonatomic, strong) HDecimalTextField* inputField;
@property (nonatomic, strong) QHTimer* timer;
@property (nonatomic, strong) UIButton* sendSmsButton;

@end

@implementation HSmsOtpTextField

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;

        [self initView];
    }
    
    return self;
}

- (void)initView {
    [self addSubview:self.inputField];
    [self addSubview:self.sendSmsButton];
    [self layout];
}

- (void)layout {
    [self.sendSmsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
//        make.top.and.bottom.equalTo(self);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(KHeight(24));
    }];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.sendSmsButton.mas_left).offset(-5);
        make.top.and.bottom.equalTo(self);
    }];
}

- (BOOL)becomeFirstResponder {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.inputField becomeFirstResponder];
    });
    return YES;
}

- (BOOL)resignFirstResponder
{
    if ([self.inputField canResignFirstResponder]) {
        return [self.inputField resignFirstResponder];
    }
    return NO;
}

#pragma mark - HValueViewInput
- (NSString*)value {
    return self.inputField.text;
}

- (NSUInteger)length {
    return self.inputField.text.length;
}

- (void)setTextColor:(UIColor *)textColor
{
    [self.inputField setTextColor:textColor];
}

- (void)setValue:(NSString*)value {
    [self.inputField setText:value];
    [self textFieldDidChanged:self.inputField];
}

- (void)setPlaceholder:(NSString*)placeholder {
    [self.inputField setPlaceholder:placeholder];
}

- (void)setAttributedPlaceholder:(NSString *)placeholder StrColor:(UIColor *)strColor FontSize:(CGFloat)fontSize;
{
    NSDictionary *attribute = @{@"NSForegroundColorAttributeName" : strColor,
                                @"NSFontAttributeName"            : [UIFont systemFontOfSize:fontSize]};
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:placeholder attributes:attribute];
    
    [self.inputField setAttributedPlaceholder:attString];

}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    
    [self.inputField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.delegate textFieldShouldReturn:self];
    } else {
        return YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSCharacterSet* cs = [[NSCharacterSet characterSetWithCharactersInString:NUM] invertedSet];
    NSString* filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![string isEqualToString:filtered]) {
        [APP_KEYWINDOW makeToast:@"输入字符非法，请重新输入" position:CSToastPositionTop];
        return NO;
    }
    
    NSUInteger length = textField.text.length - range.length + string.length;
    if (length > kSmsOTPMaxInputLength) {
        [APP_KEYWINDOW makeToast:@"输入字符串超过最大长度" position:CSToastPositionTop];
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidChanged:(UITextField*)textfield {
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidChanged:)]) {
        [self.delegate textFieldDidChanged:self];
    }
}

- (void)buttonClick: (UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonDidPressed:)]) {
        [self.delegate buttonDidPressed:self];
    }
}

#pragma mark - public method
// 验证码计时
-(void)startTimer
{
    [self.timer start];
}

// 终止短信验证码计时
- (void)terminateSmsTextTimer
{
    [self.timer cancleTimer];
    
    [self.sendSmsButton setEnabled:YES];
}

#pragma mark - getter and setter
- (HDecimalTextField*)inputField {
    if (_inputField == nil) {
        _inputField = [[HDecimalTextField alloc] init];
        _inputField.font = [UIFont systemFontOfSize:textFontSize];
        [_inputField setTextColor:kNormalTextColor];
        _inputField.backgroundColor = [UIColor clearColor];
        _inputField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _inputField.autocorrectionType = UITextAutocorrectionTypeNo;
        _inputField.delegate = self;
        _inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputField.returnKeyType = UIReturnKeyDone;
        _inputField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [_inputField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputField;
}

- (UIButton*)sendSmsButton {
    if (_sendSmsButton == nil) {
        _sendSmsButton = [[UIButton alloc] init];
        _sendSmsButton.backgroundColor = kOrangeColor;
        //_sendSmsButton.layer.borderWidth = 0.5;
        //_sendSmsButton.layer.borderColor = kThemeColor.CGColor;
        _sendSmsButton.layer.cornerRadius = 4.0;
        [_sendSmsButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        _sendSmsButton.titleLabel.font = FONT(13);
        [_sendSmsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendSmsButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendSmsButton setTitleColor:kAssistColor forState:UIControlStateDisabled];
        [_sendSmsButton setBackgroundColor:klineColor forState:UIControlStateDisabled];
        [_sendSmsButton setTitle:[NSString stringWithFormat:@"%d秒后再次获取", smsTimeout] forState:UIControlStateDisabled];
        [_sendSmsButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendSmsButton;
}

- (QHTimer*)timer {
    if (_timer == nil) {
        _timer = [[QHTimer alloc] initWithTimeout:smsTimeout];
        WEAK_SELF
        _timer.timerEndingBlock = ^{
            STRONG_SELF
            //strongSelf.sendSmsButton.layer.borderWidth = 0.5;
            strongSelf.layer.cornerRadius = 4.0;
            [strongSelf.sendSmsButton setEnabled:YES];
        };
        _timer.countdownBlock = ^ (int time) {
            STRONG_SELF
            NSString *strTime = [NSString stringWithFormat:@"%.2d", time];
            ///iOS7.1 BUG 如果button enable设置为NO 修改title不起作用 所以先设置为YES
            [strongSelf.sendSmsButton setEnabled:YES];
            strongSelf.sendSmsButton.layer.borderWidth = 0.0;
            [strongSelf.sendSmsButton setTitle:[NSString stringWithFormat:@"%@秒后重试", strTime] forState:UIControlStateDisabled];
            //_sendButton.backgroundColor = UIColorFromHexValue(0xf6f6f6);
            [strongSelf.sendSmsButton setEnabled:NO];
        };
    }
    return _timer;
}

@end
