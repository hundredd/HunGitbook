//
//  HFormEditUnit.m
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormPickerUnit.h"

#import "HDatePicker.h"
#import "HDateAlertview.h"
#import "HPickerView.h"
#import "HInputField.h"
#import "HInputFieldFactory.h"
#import "WXZPickTimeView.h"

@interface HFormPickerUnit ()<HValueViewDelegate,HDateAlertDelegete,HPickerDelegate,PickTimeViewDelegate>
@property(nonatomic,strong)HInputField *textField;
@property(nonatomic,strong)HDatePicker *datePicker;
@property(nonatomic,strong)HPickerView *pickerView;
@property(nonatomic,copy)NSString    *textFieldValue;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UILabel *singleLB;
@end


@implementation HFormPickerUnit
//需要修改和获取textfield的内容
@synthesize value = _value;


#pragma mark - setter/getter
-(NSString *)value
{
    return _textFieldValue;
}


-(BOOL)isDate
{
    if (!_isDate) {
        //默认为no;默认弹出数据源pickView
        _isDate = NO;
    }
    return _isDate;
}

#pragma mark - public

-(void)setFirstResponder
{
    [_textField becomeFirstResponder];
}

-(void)setSingle:(NSString *)single
{
    _single = single;
    self.singleLB.text = single;
    WEAK_SELF;
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.top.bottom.equalTo(weakSelf);
        make.width.equalTo(weakSelf).multipliedBy(0.85);
    }];
    
    [self.singleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_textField.mas_right);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.height.mas_equalTo(HMiddleImgHW);
        make.width.equalTo(_imgV.mas_height);
    }];
}

-(void)setRightTitle:(NSString *)rightTitle
{
    _rightTitle = rightTitle;
    [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
    
    WEAK_SELF;
    [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.top.bottom.equalTo(weakSelf);
        //        make.width.lessThanOrEqualTo(weakSelf).multipliedBy(0.7);
    }];
    
    [_rightBtn mas_remakeConstraints: ^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(_textField.mas_right).with.priorityHigh();
        make.height.equalTo(_textField.mas_height);
        make.width.lessThanOrEqualTo(@80);
        //        make.width.lessThanOrEqualTo(weakSelf).multipliedBy(0.3);
    }];
    
    //由于有冲突!这个设计还是不太合理
    [_imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    
    [_btn mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    
}

-(void)setImageHidden:(BOOL)hidden
{
    _imgV.hidden = hidden;
    WEAK_SELF;
    if (hidden) {
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf);
            make.centerY.equalTo(weakSelf);
            make.top.bottom.equalTo(weakSelf);
        }];
        [self.imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
    }else
    {
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf);
            make.centerY.equalTo(weakSelf);
            make.top.bottom.equalTo(weakSelf);
        }];
        
        [self.imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf);
            make.centerY.equalTo(weakSelf);
            make.left.equalTo(_textField.mas_right);
            make.height.mas_equalTo(HSmallImgHW);
            make.width.equalTo(_imgV.mas_height);
        }];
    }
}

-(void)setIsButtonHide:(BOOL)isButtonHide
{
    _isButtonHide = isButtonHide;
    //让按钮回来
    self.btn.hidden = isButtonHide;
    self.imgV.hidden = isButtonHide;
}
-(void)setIsErrorHide:(BOOL)isErrorHide
{
    _isErrorHide = isErrorHide;
}

-(void)setValue:(NSString *)value
{
    _value = value;
    if (self.textField) {
        self.textField.value =value;
    }
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    if (self.textField) {
        self.textField.placeholder =placeholder;
    }
    
}

-(void)setIsRightStyle:(BOOL)isRightStyle
{
    _isRightStyle = isRightStyle;
    if (isRightStyle) {
        self.imgV.image =[UIImage imageNamed:@"arrow_right"];//  [UIImageManager imageNamed:@"special_arrow_right"];
    }
}

-(void)btnAction
{
    //    NSLog(@"点击按钮事件!~~~");
    
    //点击事件
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addEditUnitOnClick)]) {
        [self.delegate addEditUnitOnClick];
    }
    
    //点击事件传自己的view出去
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addEditUnitOnClickWithView:)]) {
        [self.delegate addEditUnitOnClickWithView:self];
    }
    
    //这里实现是否弹出时间框
    if (self.isDate)
    {
        [self showDate];
    }
    
    if (self.isTime)
    {
        [self showTime];
    }
}

#pragma mark - 显示时间时分选择器
-(void)showTime
{
    WXZPickTimeView *pickerArea = [[WXZPickTimeView alloc]init];
    
    [pickerArea setDelegate:self];
    
    [pickerArea setDefaultHour:14 defaultMinute:20];
    
    [pickerArea show];
}

-(void)pickerTimeView:(WXZPickTimeView *)pickerTimeView selectHour:(NSInteger)hour selectMinute:(NSInteger)minute{
    NSLog(@"选择的时间：%ld %ld",hour,minute);
    NSString *time =  [NSString stringWithFormat:@"%ld:%ld",hour,minute];
    if (hour<10&minute<10) {
        time = [NSString stringWithFormat:@"0%ld:0%ld",hour,minute];
    }else if (hour<10){
        time = [NSString stringWithFormat:@"0%ld:%ld",hour,minute];
    }else if (minute<10){
        time = [NSString stringWithFormat:@"%ld:0%ld",hour,minute];
    }else{
        time = [NSString stringWithFormat:@"%ld:%ld",hour,minute];
    }
    self.value = time;
    
    
}
#pragma mark - 日期

-(void)showDate
{
    HDateAlertview *alert = [[HDateAlertview alloc] initWithFrame:CGRectMake(10, (kScreenHeight-260)/2, kScreenWidth-20, 260)];
    //alert.image = [UIImage imageNamed:@"dikuang"];
    alert.delegate = self;
#pragma mark - 设置中间时间键
    if (self.isPickShowCenter) {
        [alert initwithtitle:@"请选择日期" andmessage:@"" andcancelbtn:@"取消" andotherbtn:@"确定" andCenterBtn:YES];
    }else
        [alert initwithtitle:@"请选择日期" andmessage:@"" andcancelbtn:@"取消" andotherbtn:@"确定"];
    
    
    //我把Dpicker添加到一个弹出框上展现出来 当然大家还是可以以任何其他动画形式展现
    [alert addSubview:self.datePicker];
    [alert show];
}

#pragma mark DateAlert
-(void)btnindex:(int)index :(int) tag
{
    if (index == 2) {
        //由于展现的时候和现在的格式不一致,所以得改改
        
        _textField.value = [NSString stringWithFormat:@"%d-%0*d-%0*d",self.datePicker.year,2,self.datePicker.month,2,self.datePicker.day];
    }else if(index == 3)//中间长期
    {
        _textField.value = @"长期有效";
    }
}

- (void)textFieldDidChanged:(UIView<HValueViewInput> *)textField
{
    //由于获取不到值,采用这个方法获取,先不分析内部原因
    _textFieldValue = textField.value;
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addEditUnitTextFieldDidChangedWithValue:)]) {
        [self.delegate addEditUnitTextFieldDidChangedWithValue:textField.value];
    }
    //这个方法可以用于外部有多个unit的时候作为辨别!
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addEditUnitTextFieldDidChangedWithView:andValue:)]) {
        [self.delegate addEditUnitTextFieldDidChangedWithView:self andValue:textField.value];
    }
}



- (void)textFieldDidBeginEditing:(UIView<HValueViewInput> *)textField
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addEditUnitTextFieldDidBegin)]) {
        [self.delegate addEditUnitTextFieldDidBegin];
    }
}

#pragma mark - private


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI
{
    WEAK_SELF;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.top.bottom.equalTo(weakSelf);
    }];
    
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(_textField.mas_right);
        make.height.mas_equalTo(HMiddleImgHW);
        make.width.equalTo(_imgV.mas_height);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.left.equalTo(_textField);
        make.right.equalTo(_imgV);
    }];
}

#pragma mark - getter

-(HInputField *)textField
{
    //设置框架内的 QHInputFieldFactory
    if (!_textField) {
        HInputField *textField = [HInputFieldFactory getHInputFieldWithType:QHInputFieldType_Text1];
        [textField setDelegateToValueView:self];
        textField.hiddenTitle = YES;
        textField.title = @"";
        textField.value = @"";
        textField.placeholder = @"";
        [textField setTextColor:HFieldValueColor];
        [textField setTitleColor:hDefaultDetailFontColor];
        [textField setPlaceholderColor:HFieldPlaceHoldColor];
        
        textField.backgroundColor = [UIColor clearColor];
        [self addSubview:textField];
        _textField = textField;
    }
    return _textField;
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        UIImageView *imgV = [UIImageView new];
        imgV.image = [UIImage imageNamed:@"arrow_down"];//[UIImageManager imageNamed:@"special_arrow_down"];
        imgV.hidden = YES;
        [self addSubview:imgV];
        _imgV = imgV;
    }
    return _imgV;
}

-(UIButton *)btn
{
    if(!_btn){
        UIButton *view = [UIButton new];
        [view addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        view.hidden = YES;//默认按钮隐藏
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        _btn = view;
    }
    return _btn;
}

-(UILabel *)singleLB
{
    if (!_singleLB) {
        UILabel *titlelabel = [UILabel labelWithText:@""
                                                font:hNomalTitleFont
                                           textColor:HFieldPlaceHoldColor
                                     backgroundColor:hClearColor isSizeToFit:YES];
        [self addSubview:titlelabel];
        _singleLB = titlelabel;
    }
    return _singleLB;
}

-(UIButton *)rightBtn
{
    if (!_rightBtn) {
        UIButton *topBtn = [UIButton new];
        
        topBtn.titleLabel.font = HTitleFontSize;
        [topBtn setTitleColor:hBlueTextColor forState:UIControlStateNormal];
        topBtn.layer.borderWidth = 1;
        topBtn.layer.borderColor = hBlueBtnColor.CGColor;
        topBtn.layer.cornerRadius = 5;
        topBtn.backgroundColor = [UIColor clearColor];
        [topBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:topBtn];
        _rightBtn = topBtn;
    }
    return _rightBtn;
}

-(HPickerView *)pickerView
{
    if (!_pickerView) {
        HPickerView *pickerView = [[HPickerView alloc]init];
        pickerView.delegate = self;
        _pickerView = pickerView;
    }
    return _pickerView;
}
-(HDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[HDatePicker alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth-20, 200)];
        
    }
    return _datePicker;
}


@end
