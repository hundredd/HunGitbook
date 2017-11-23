//
//  HSelectTextField.m
//  HJF
//
//  Created by 方立立 on 16/8/7.
//  Copyright © 2016年 HJF. All rights reserved.
//

#import "HSelectTextField.h"
//#import "UIImageManager.h"

@interface HSelectTextField ()

@property (nonatomic, strong) UITextField *inputField;
@property (nonatomic, strong) UIImageView *selectView;

@end

@implementation HSelectTextField

#pragma mark - Init method
- (instancetype)init {
    self = [super init];
    if (self) {
    	// Do any init action
    	
        [self initView];
    }
    return self;
}

// Draw your custom view here
- (void)initView {
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTap:)];
    [self addGestureRecognizer:recognizer];
    
    // Recommended: only add subviews to view
    [self addSubview:self.inputField];
    [self addSubview:self.selectView];

    // layout subviews, only add constraints
	[self layout];
}

// Add constraints to subviews
- (void)layout {
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.and.bottom.equalTo(self);
        make.width.mas_equalTo(30);
    }];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.and.bottom.equalTo(self);
        make.right.equalTo(self.selectView.mas_left);
    }];
}

#pragma mark - Protocol Method
// If any delegate or protocol is implemented, write here
- (NSString*)value {
    return self.inputField.text;
}

- (void)setValue:(NSString*)value {
    [self.inputField setText:value];
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidChanged:)]) {
        [self.delegate textFieldDidChanged:self];
    }
}

- (void)setPlaceholder:(NSString*)placeholder {
    [self.inputField setPlaceholder:placeholder];
}

#pragma mark - Event response
// Response to any view event
- (void)viewDidTap: (UITapGestureRecognizer *)recognizer {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonDidPressed:)]) {
        [self.delegate buttonDidPressed:self];
    }
}

#pragma mark - public method
// Public access methods
- (void)setSelectImage:(UIImage *)image
{
    self.selectView.image = image;
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

#pragma mark - private method
// Not recommended to implement private method in view. Write here if it has to.

#pragma mark - getter and setter
// Recommended: Lazy init subviews in getter method
- (UITextField *)inputField {
    if (_inputField == nil) {
        _inputField = [[UITextField alloc] init];
        _inputField.font = [UIFont systemFontOfSize:textFontSize];
        [_inputField setTextColor:kNormalTextColor];
        _inputField.backgroundColor = [UIColor clearColor];
        _inputField.enabled = NO;
    }
    
    
    
    return _inputField;
}

- (UIImageView *)selectView {
    if (_selectView == nil) {
        _selectView = [[UIImageView alloc] init];
        _selectView.image = [UIImage imageNamed:@"arrow_down"];//[UIImageManager imageNamed:@"common_arrow_down"];
    }
    return _selectView;
}

@end
