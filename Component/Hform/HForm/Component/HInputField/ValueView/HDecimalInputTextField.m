//
//  QHDecimalTextField.m
//  QHJF
//
//  Created by 方立立 on 16/7/17.
//  Copyright © 2016年 HJF. All rights reserved.
//

#import "HDecimalInputTextField.h"
#import "HDecimalTextField.h"

@interface HDecimalInputTextField() <UITextFieldDelegate>

@end

@implementation HDecimalInputTextField

@synthesize inputField = _inputField;

#pragma mark - getter and setter

- (UITextField*)inputField {
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
        [_inputField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputField;
}

-(BOOL)becomeFirstResponder
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.inputField becomeFirstResponder];
    });
    return YES;
}

-(BOOL)resignFirstResponder
{
    if ([self.inputField canResignFirstResponder]) {
        return [self.inputField resignFirstResponder];
    }
    return NO;
}

- (void)setTextColor:(UIColor *)textColor
{
    [self.inputField setTextColor:textColor];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    
    [self.inputField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

@end
