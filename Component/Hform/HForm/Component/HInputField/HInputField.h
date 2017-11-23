//
//  QHInputField.h
//  QHJF
//
//  Created by 方立立 on 16/7/12.
//  Copyright © 2016年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HValueViewInput <NSObject>

- (NSString*)value;
- (void)setValue:(NSString*)value;

@optional
- (void)setPlaceholder:(NSString*)placeholder;
- (void)setDelegate:(id)delegate;
- (NSUInteger)length;
- (void)setKeyboardType:(NSInteger)type;
//- (void)setAllowedCharacterSet:(QHCharcterSet)set;
- (void)setMaxLength:(NSUInteger)length;
- (void)inputViewWillAppear;
- (void)setAttributedPlaceholder:(NSString *)placeholder StrColor:(UIColor *)strColor FontSize:(CGFloat)fontSize;
- (void)setPlaceholderColor:(UIColor *)placeholderColor;
- (void)setTextColor:(UIColor *)textColor;

@end

@protocol HValueViewDelegate <NSObject>

@optional
- (BOOL)textFieldShouldBeginEditing:(UIView<HValueViewInput> *)textField;
- (void)textFieldDidBeginEditing:(UIView<HValueViewInput> *)textField;
- (BOOL)textFieldShouldEndEditing:(UIView<HValueViewInput> *)textField;
- (void)textFieldDidEndEditing:(UIView<HValueViewInput> *)textField;
- (BOOL)textFieldShouldClear:(UIView<HValueViewInput> *)textField;
- (BOOL)textFieldShouldReturn:(UIView<HValueViewInput> *)textField;
- (void)textFieldDidChanged:(UIView<HValueViewInput> *)textField;

// 带按钮
- (void)buttonDidPressed:(UIView<HValueViewInput> *)textField;

@end

@interface HInputField : UIView
    
@property (nonatomic, assign) NSString* title;
@property (nonatomic, assign) NSString* placeholder;
@property (nonatomic, strong, readonly) UIView<HValueViewInput>* valueView;
@property (nonatomic, strong) UIImageView* bottomLine;
@property (nonatomic, assign) BOOL hiddenTitle;
@property (nonatomic, assign) BOOL hiddenErrorLB;

- (instancetype)initWithValueView:(UIView<HValueViewInput>*)view;
- (void)addGestureRecognizerToValueView:(UIGestureRecognizer *)gestureRecognizer;
- (void)setDelegateToValueView:(id)delegate;
- (NSString*)value;
- (NSUInteger)length;
- (void)setValue:(NSString*)value;
- (void)setKeyboardType:(NSInteger)type;
//- (void)setAllowedCharacterSet:(QHCharcterSet)set;
- (void)setInputMaxLength:(NSUInteger)length;
- (void)showError:(NSString*)errorMsg;
- (void)setAttributedPlaceholder:(NSString *)placeholder StrColor:(UIColor *)strColor FontSize:(CGFloat)fontSize;
- (void)setPlaceholderColor:(UIColor *)placeholderColor;
- (void)setTextColor:(UIColor *)textColor;
- (void)setTitleColor:(UIColor *)titleColor;

@end
