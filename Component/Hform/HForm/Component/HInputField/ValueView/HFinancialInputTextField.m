//
//  HFinancialInputTextField.m
//  HJF
//
//  Created by Keldon on 16/9/7.
//  Copyright © 2016年 HJF. All rights reserved.
//

#import "HFinancialTextField.h"
#import "HFinancialInputTextField.h"

@interface HFinancialInputTextField() <UITextFieldDelegate>

@end

@implementation HFinancialInputTextField

@synthesize inputField = _inputField;

#pragma mark - getter and setter

- (UITextField*)inputField {
    if (_inputField == nil) {
        _inputField = [[HFinancialTextField alloc] init];
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

@end
