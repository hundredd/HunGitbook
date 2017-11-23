//
//  HText.m
//  HJF
//
//  Created by 方立立 on 16/7/12.
//  Copyright © 2016年 HJF. All rights reserved.
//

#import "HTextField.h"
#import "HTextFieldFormat.h"

@interface HTextField() <UITextFieldDelegate>

@property (nonatomic, copy) NSString* charctersAllowed;
@property (nonatomic, assign) NSUInteger inputMaxLength;
@property (nonatomic, strong) id<HTextFieldFormat> format;

@end

@implementation HTextField

- (id)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        
        _inputMaxLength = 0;
        _charctersAllowed = nil;
        _formatType = kHTextFieldFormatType_NONE;
        _format = nil;
        [self initView];
    }
    
    return self;
}

- (void)initView
{
    [self addSubview:self.inputField];
    [self layout];
}

- (void)layout
{
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (BOOL)becomeFirstResponder
{
    return [self.inputField becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    if([self.inputField canResignFirstResponder]){
       return [self.inputField resignFirstResponder];
    }
    return NO;
}

#pragma mark - HValueViewInput
- (NSString*)value
{
    if (self.formatType != kHTextFieldFormatType_NONE) {
        return self.inputField.text;
    } else {
        return self.inputField.text;
    }
}

- (NSUInteger)length
{
    if (self.formatType != kHTextFieldFormatType_NONE) {
        return self.inputField.text.length;
    } else {
        return self.inputField.text.length;
    }
}

- (void)setValue:(NSString*)value
{
    [self.inputField setText:value];
    [self textFieldDidChanged:self.inputField];
}

- (void)setPlaceholder:(NSString*)placeholder
{
    [self.inputField setPlaceholder:placeholder];
}

- (void)setAttributedPlaceholder:(NSString *)placeholder StrColor:(UIColor *)strColor FontSize:(CGFloat)fontSize
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

- (void)setAllowedCharacterSet:(QHCharcterSet)set
{
    switch (set) {
        case kQHCharcterSet_NUM:
            _charctersAllowed = NUM;
            break;
        case kQHCharcterSet_ALPHA:
            _charctersAllowed = ALPHA;
            break;
        case kQHCharcterSet_ALPHANUM:
            _charctersAllowed = ALPHANUM;
            break;
        case kQHCharcterSet_OTHER:
            _charctersAllowed = OTHER;
            break;
        case kCharcterSet_EMAIL:
            _charctersAllowed = EMAIL;
            break;
            
        default:
            _charctersAllowed = nil;
            break;
    }
}

- (void)setKeyboardType:(NSInteger)type
{
    self.inputField.keyboardType = type;
}

- (void)setMaxLength:(NSUInteger)length
{
    self.inputMaxLength = length;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.delegate textFieldShouldBeginEditing:self];
    } else {
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.delegate textFieldShouldEndEditing:self];
    } else {
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:self];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.delegate textFieldShouldClear:self];
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.delegate textFieldShouldReturn:self];
    } else {
        return YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    if(string.length >0) {
        //限制输入字符个数
        if (self.inputMaxLength > 0 && !textField.markedTextRange) {
            if ((textField.text.length + string.length - range.length) > self.inputMaxLength) {
                [APP_KEYWINDOW makeToast:@"输入字符串超过最大长度" position:CSToastPositionTop];
                return NO;
            }
        }
        if (self.charctersAllowed != nil) {
            NSCharacterSet* cs = [[NSCharacterSet characterSetWithCharactersInString:self.charctersAllowed] invertedSet];
            NSString* filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            if (![string isEqualToString:filtered]) {
                [APP_KEYWINDOW makeToast:@"输入字符非法，请重新输入" position:CSToastPositionTop];
                return NO;
            }
        }
    }

    return YES;
}

#pragma mark - private method
- (void)setText:(NSString*)string
{
    self.inputField.text = string;
}

- (void)setCursor:(UITextPosition*)position {
    [self.inputField setSelectedTextRange:[self.inputField textRangeFromPosition:position toPosition:position]];
}

- (void)textFieldDidChanged:(UITextField*)textField
{
    UITextRange *selectedRange = [textField markedTextRange];
    if (self.inputMaxLength > 0 && !selectedRange && textField.text.length > self.inputMaxLength) {
        textField.text = [textField.text substringToIndex:self.inputMaxLength];
        [APP_KEYWINDOW makeToast:@"输入字符串超过最大长度" position:CSToastPositionTop];
    }
    
    if (self.format && !selectedRange) {
        self.inputField.attributedText = [self.format textFormat:self.inputField.text];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidChanged:)]) {
        [self.delegate textFieldDidChanged:self];
    }
}

#pragma mark - getter and setter
- (UITextField*)inputField
{
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
        [_inputField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputField;
}

-(void)setFormatType:(kHTextFieldFormatType)formatType
{
    _formatType = formatType;
    switch (formatType) {
        case kHTextFieldFormatType_PHONE:
            _format = [[HTextFieldPhoneFormat alloc] init];
            break;
        case kHTextFieldFormatType_ID:
            _format = [[HTextFieldIDFormat alloc] init];
            break;
        case kHTextFieldFormatType_BANKNO:
            _format = [[HTextFieldBankNoFormat alloc] init];
            break;
        case kHTextFieldFormatType_NONE:
            _format = nil;
            break;

        default:
            break;
    }
}


- (void)setTextColor:(UIColor *)textColor
{
    [_inputField setTextColor:textColor];
}

//- (void)setTextColor:(UIColor *)textColor
//{
//    [_inputField setTextColor:textColor];
//}
@end
