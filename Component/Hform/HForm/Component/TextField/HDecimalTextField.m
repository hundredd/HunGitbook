//
//  PABankCardTextField.m
//  PACFB
//
//  Created by Keldon on 15/3/16.
//  Copyright (c) 2015年 Keldon. All rights reserved.
//

#import "HDecimalTextField.h"

@implementation HDecimalKeyboard
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //键盘主视图
        self.backgroundColor = UIColorFromHexValue(0xe9ecf1);
        
        CGFloat rowPadding = 3;
        CGFloat colPadding = 3;
        UIImage *btnImg0 = [UIImage bundleImgWithName:@"key_num_nor"];//[UIImageManager bundleImgWithName:@"keyboard_key_num_nor"];
        UIImage *btnImg1 = [UIImage bundleImgWithName:@"key_num_hig"];//[UIImageManager bundleImgWithName:@"keyboard_key_num_hig"];
        int btnWidth = (kScreenWidth-4*colPadding)/3;
        int btnHeight = (frame.size.height-5*rowPadding)/4;

        float x = 0;
        float y = 0;
        //0..9数字
        for (int i = 0; i < 10; i++) {
            UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            tmpBtn.titleLabel.font = FONT(keyboardNumFontSize);
            [tmpBtn setBackgroundImage:btnImg0 forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:btnImg1 forState:UIControlStateHighlighted];
            [tmpBtn setTitleColor:kLinkedColor forState:UIControlStateNormal];
            [tmpBtn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            x = ((i-1)%3)*(btnWidth+colPadding) + colPadding;
            y = ((i-1)/3)*(btnHeight+rowPadding) + rowPadding;
            if (i==0) {
                //0 单独在第4行
                tmpBtn.frame = CGRectMake(1*(btnWidth+colPadding)+colPadding, 3*(btnHeight+rowPadding)+rowPadding, btnWidth, btnHeight);
            }else{
                tmpBtn.frame = CGRectMake(x, y, btnWidth, btnHeight);
            }
            tmpBtn.accessibilityValue = tmpBtn.titleLabel.text;
            [tmpBtn addTarget:_delegate action:@selector(keyboardDidPress:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:tmpBtn];
        }
        //删除按钮
        UIImage *delImg0 = [UIImage bundleImgWithName:@"key_num_del_nor"];//[UIImageManager bundleImgWithName:@"keyboard_key_num_del_nor"];
        UIImage *delImg1 =[UIImage bundleImgWithName:@"key_num_del_hig"];// [UIImageManager bundleImgWithName:@"keyboard_key_num_del_hig"];
        UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [delBtn setBackgroundImage:delImg0 forState:UIControlStateNormal];
        [delBtn setBackgroundImage:delImg1 forState:UIControlStateHighlighted];
        [delBtn addTarget:_delegate action:@selector(keyboardDidDelete) forControlEvents:UIControlEventTouchDown];
        delBtn.frame = CGRectMake(colPadding , 3*(btnHeight+rowPadding)+rowPadding, btnWidth, btnHeight);
        [self addSubview:delBtn];
        

        //确定按钮按钮
        UIImage *abcImg = [UIImage bundleImgWithName:@"key_num_bottom"];// [UIImageManager bundleImgWithName:@"keyboard_key_num_bottom"];
        UIImage *dotImg0 = [UIImage bundleImgWithName:@"key_dot_hig"];//[UIImageManager bundleImgWithName:@"keyboard_key_dot_hig"];
        UIButton *abcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        abcBtn.titleLabel.font = FONT(titleFontSize);
        [abcBtn setBackgroundImage:abcImg forState:UIControlStateNormal];
        [abcBtn setBackgroundImage:dotImg0 forState:UIControlStateHighlighted];
        [abcBtn setTitleColor:kLinkedColor forState:UIControlStateNormal];
        [abcBtn setTitle:@"确定" forState:UIControlStateNormal];
        [abcBtn addTarget:_delegate  action:@selector(keyboardDidReturn) forControlEvents:UIControlEventTouchUpInside];
        abcBtn.frame = CGRectMake(colPadding+2*(btnWidth+colPadding), 3*(btnHeight+rowPadding)+rowPadding, btnWidth, btnHeight);
        [self addSubview:abcBtn];
    }
    return self;
}
@end

@implementation HDecimalTextField

//@synthesize delegate = _delegate;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self lazyLoadKeyboard];
        });
    });
}

-(void)lazyLoadKeyboard
{
    int keyboardHeight = 0;
    if (IS_SCREEN_35_INCH || IS_SCREEN_4_INCH) {
        keyboardHeight = 216;
    }else{
        keyboardHeight = 236;
    }
    
    HDecimalKeyboard* keyboard = [[HDecimalKeyboard alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, keyboardHeight)];
    self.inputView = keyboard;
    
    keyboard.delegate = self;
}

-(void)keyboardDidPress:(UIButton*)sender
{
    NSString *string = sender.accessibilityValue;
    
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    NSRange range = NSMakeRange(location, length);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        if ([self.delegate textField:self shouldChangeCharactersInRange:range replacementString:string]) {
            self.text = [self.text stringByReplacingCharactersInRange:range withString:string];
        }
    } else {
        self.text = [self.text stringByReplacingCharactersInRange:range withString:string];
    }
    
    UITextPosition* start = [self positionFromPosition:selectedRange.start inDirection:UITextLayoutDirectionRight offset:1];
    if (start)
    {
        [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:start]];
    }
    
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

-(void)keyboardDidReturn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        [self.delegate textFieldShouldReturn:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:UITextFieldTextDidEndEditingNotification object:nil];
}

-(void)keyboardDidDelete
{
    if ([self.text isEqualToString:@""]) {
        return;
    }
    
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    //UITextPosition* selectionEnd = selectedRange.end;
    NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart]-1;
    location = (location < 0) ? 0 : location;
    //const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    NSRange range = NSMakeRange(location, 1);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        if ([self.delegate textField:self shouldChangeCharactersInRange:range replacementString:@""]) {
            self.text = [self.text stringByReplacingCharactersInRange:range withString:@""];
        }
    } else {
        self.text = [self.text stringByReplacingCharactersInRange:range withString:@""];
    }
    
    UITextPosition* start = [self positionFromPosition:selectedRange.start inDirection:UITextLayoutDirectionLeft offset:1];
    if (start)
    {
        [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:start]];
    }
    
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:)) {
        return NO;
    }
    if (action == @selector(cut:)) {
        return NO;
    }
    if (action == @selector(copy:)) {
        return NO;
    }
    if (action == @selector(selectAll:)) {
        return NO;
    }
    if (action == @selector(select:)) {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

@end
