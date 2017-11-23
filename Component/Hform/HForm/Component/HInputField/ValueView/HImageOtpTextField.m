//
//  HImageOtpTextField.m
//  HJF
//
//  Created by 方立立 on 16/7/14.
//  Copyright © 2016年 HJF. All rights reserved.
//

#import "HImageOtpTextField.h"
#import "View+MASAdditions.h"

@interface HImageOtpTextField() <UITextFieldDelegate>

@property (nonatomic, strong) UIButton* sendImageButton;
@property (nonatomic, strong) UITextField* inputField;

@end

@implementation HImageOtpTextField

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
    [self addSubview:self.sendImageButton];
    [self layout];
}

- (void)layout {
    [self.sendImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(30);
    }];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.sendImageButton.mas_left).offset(-5);
        make.top.and.bottom.equalTo(self);
    }];
}

- (BOOL)becomeFirstResponder
{
    return [self.inputField becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    if ([self.inputField canResignFirstResponder]) {
        return [self.inputField resignFirstResponder];
    }
    return NO;
}

#pragma mark - HValueViewInput
- (NSString*)value
{
    return self.inputField.text;
}

- (NSUInteger)length {
    return self.inputField.text.length;
}

- (void)setValue:(NSString*)value {
    [self.inputField setText:value];
    [self textFieldDidChanged:self.inputField];
}

- (void)setPlaceholder:(NSString*)placeholder {
    [self.inputField setPlaceholder:placeholder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
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
    
    NSCharacterSet* cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString* filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![string isEqualToString:filtered]) {
        [APP_KEYWINDOW makeToast:@"输入字符非法，请重新输入" position:CSToastPositionTop];
        return NO;
    }
    
    NSUInteger length = textField.text.length - range.length + string.length;
    if (length > kImageOTPMaxInputLength) {
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

- (void)buttonClick: (UIButton *)button {
    [self setValue:@""];
    [self.inputField becomeFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonDidPressed:)]) {
        [self.delegate buttonDidPressed:self];
    }
}

#pragma mark - public method
- (void)setButtonImage:(UIImage*)image {
    [self.sendImageButton setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)setTitle:(NSString*)title {
    [self.sendImageButton setTitle:title forState:UIControlStateNormal];
}

- (void)setEnabled:(BOOL)enabled {
    self.sendImageButton.enabled = enabled;
}

#pragma mark - getter and setter
- (UITextField*)inputField {
    if (_inputField == nil) {
        _inputField = [[UITextField alloc] init];
        _inputField.font = [UIFont systemFontOfSize:textFontSize];
        [_inputField setTextColor:kNormalTextColor];
        _inputField.backgroundColor = [UIColor clearColor];
        _inputField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _inputField.autocorrectionType = UITextAutocorrectionTypeNo;
        _inputField.delegate = self;
        _inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputField.returnKeyType = UIReturnKeyDone;
        _inputField.keyboardType = UIKeyboardTypeAlphabet;
        [_inputField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputField;
}

- (UIButton*)sendImageButton {
    if (_sendImageButton == nil) {
        _sendImageButton = [[UIButton alloc] init];
        _sendImageButton.backgroundColor = [UIColor clearColor];
        [_sendImageButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        _sendImageButton.titleLabel.font = FONT(15);
        [_sendImageButton setTitleColor:kThemeColor forState:UIControlStateNormal];
        [_sendImageButton setTitle:@"获取图形码" forState:UIControlStateNormal];
        [_sendImageButton setTitleColor:kAssistColor forState:UIControlStateDisabled];
        [_sendImageButton setTitle:@"获取中" forState:UIControlStateDisabled];
        _sendImageButton.enabled = NO;
        [_sendImageButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendImageButton;
}

@end
