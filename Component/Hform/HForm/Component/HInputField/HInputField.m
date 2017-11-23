//
//  QHInputField.m
//  QHJF
//
//  Created by 王衡杰 on 17/7/12.
//  Copyright © 2016年 QHJF. All rights reserved.
//

#import "HInputField.h"
#import "View+MASAdditions.h"
@interface HInputField()

@property (nonatomic, copy) NSString* value;
@property (nonatomic, strong) UILabel* descLabel;
@property (nonatomic, strong) UILabel* errorLabel;
//@property (nonatomic, strong) UIImageView* bottomLine;

@end

@implementation HInputField

- (instancetype)initWithValueView:(UIView<HValueViewInput>*)view {
    self = [super init];
    if (self) {
        _valueView = view;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.descLabel];
    [self addSubview:self.errorLabel];
    [self addSubview:self.valueView];
    [self addSubview:self.bottomLine];
    [self layout];
}

- (void)layout {
    //这句话固定死宽高,比较麻烦!所以不能用到自己的框架中
//    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(kScreenWidth);
//        make.height.mas_equalTo(KHeight(56));
//    }];
    

    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(65).with.priorityLow();
        //这里和label一起控制了约束高度,导致一直撑大,注意还有就是下划线!
//        make.left.equalTo(self).offset(twoSidesOffset);
//        make.top.equalTo(self).offset(15);
//        make.bottom.equalTo(self).offset(-15);
    }];
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descLabel);
        make.top.equalTo(self.descLabel.mas_bottom);
        make.right.equalTo(self);
//        make.right.equalTo(self).offset(-twoSidesOffset);
        make.bottom.equalTo(self);
    }];
    [self.valueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descLabel.mas_right).offset(6);
        make.right.equalTo(self).offset(-10);
        make.top.and.bottom.equalTo(self.descLabel);
    }];
    

    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descLabel);
        make.right.equalTo(self.valueView);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (BOOL)becomeFirstResponder
{
    return [self.valueView becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [self.valueView resignFirstResponder];
}

- (void)addGestureRecognizerToValueView:(UIGestureRecognizer *)gestureRecognizer {
    [self.valueView addGestureRecognizer:gestureRecognizer];
}

- (void)setDelegateToValueView:(id)delegate {
    if([self.valueView respondsToSelector:@selector(setDelegate:)]) {
        [self.valueView setDelegate:delegate];
    }
}

- (NSString*)value {
    return [self.valueView value];
}

- (void)setValue:(NSString*)value {
    [self.valueView setValue:value];
}

- (NSUInteger)length {
    if ([self.valueView respondsToSelector:@selector(length)]) {
        return [self.valueView length];
    } else {
        return 0;
    }
}

- (void)setKeyboardType:(NSInteger)type {
    if ([self.valueView respondsToSelector:@selector(setKeyboardType:)]) {
        [self.valueView setKeyboardType:type];
    }
}

//- (void)setAllowedCharacterSet:(QHCharcterSet)set {
//    if ([self.valueView respondsToSelector:@selector(setAllowedCharacterSet:)]) {
//        [self.valueView setAllowedCharacterSet:set];
//    }
//}

- (void)setInputMaxLength:(NSUInteger)length {
    if ([self.valueView respondsToSelector:@selector(setMaxLength:)]) {
        [self.valueView setMaxLength:length];
    }
}

- (void)showError:(NSString*)errorMsg {
    if (errorMsg) {
        self.errorLabel.hidden = NO;
        self.errorLabel.text = errorMsg;
        self.bottomLine.backgroundColor = kAlertColor;
    } else {
        self.errorLabel.hidden = YES;
        self.bottomLine.backgroundColor = kSingleLineColor;
    }
}

- (UILabel*)descLabel {
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.userInteractionEnabled = NO;
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.font = [UIFont systemFontOfSize:assistFontSize];
        [_descLabel setTextColor:kNormalTextColor];
    }
    return _descLabel;
}

- (UILabel*)errorLabel {
    if (_errorLabel == nil) {
        _errorLabel = [[UILabel alloc] init];
        _errorLabel.userInteractionEnabled = NO;
        _errorLabel.textAlignment = NSTextAlignmentLeft;
        _errorLabel.textColor = kAlertColor;
        _errorLabel.hidden = YES;
        _errorLabel.font = FONT(10);
    }
    return _errorLabel;
}

- (UIImageView*)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIImageView alloc] init];
        _bottomLine.backgroundColor = kSingleLineColor;
        _bottomLine.hidden = YES;
    }
    return _bottomLine;
}

- (void)setTitle:(NSString *)title {
    [self.descLabel setText:title];
}

- (void)setPlaceholder:(NSString *)placeholder {
    if([self.valueView respondsToSelector:@selector(setPlaceholder:)]) {
        [self.valueView setPlaceholder:placeholder];
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    if([self.valueView respondsToSelector:@selector(setPlaceholderColor:)]) {
        [self.valueView setPlaceholderColor:placeholderColor];
    }
}


-(void)setHiddenErrorLB:(BOOL)hiddenErrorLB
{
    if (hiddenErrorLB)
    {
        self.errorLabel.hidden = YES;
        [self.valueView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.right.equalTo(self);
            //            make.top.equalTo(self).offset(15);
            //            make.bottom.equalTo(self).offset(-15);
        }];
    }
}

- (void)setHiddenTitle:(BOOL)hiddenTitle
{
    if (hiddenTitle)
    {
        self.descLabel.hidden = YES;
        [self.valueView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.right.equalTo(self);
            
//make.left.equalTo(self).offset(twoSidesOffset);
//            make.right.equalTo(self).offset(-twoSidesOffset);
//            make.top.equalTo(self).offset(15);
//            make.bottom.equalTo(self).offset(-15);
        }];
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    if([self.valueView respondsToSelector:@selector(setTextColor:)]) {
        [self.valueView setTextColor:textColor];
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    [self.descLabel setTextColor:titleColor];
}

@end
