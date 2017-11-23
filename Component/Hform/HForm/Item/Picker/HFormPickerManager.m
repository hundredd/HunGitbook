//
//  HFormPickerManager.m
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormPickerManager.h"
#import "HFormPickerUnit.h"
#import "HPickerView.h"
#import "HCityChooseView.h"
#import "HTools.h"
@interface HFormPickerManager()<HFormPickerUnitDelegate,HPickerDelegate>

@property(nonatomic,strong)HFormPickerUnit *pickerItem;     //编辑的
@property(nonatomic,strong)HFormPickerUnit *rightPickerItem;//如果是两项的话!右边项
@property(nonatomic,strong)UIView *containV ;//底部容器

@end

@implementation HFormPickerManager

//渲染并创建
-(void)setOriginModel:(HFormOriginModel *)originModel
{
    [super setOriginModel:originModel];
    
    //初始化数据!
    if (originModel.value) {
        _pickerItem.value = originModel.value;
    }
    if (originModel.placeHolder) {
        _pickerItem.placeholder = originModel.placeHolder;
    }
    if (originModel.pickerArr) {
        _pickerItem.pickerData = originModel.pickerArr;
    }
    if (originModel.pickerTitle) {
        _pickerItem.pickerTitle = originModel.pickerTitle;
    }
    if (originModel.delegate) {
        self.delegate = originModel.delegate;
    }
    if (originModel.rightBtnTitle) {
        _pickerItem.rightTitle = originModel.rightBtnTitle;
    }
    
    
    
    
}


-(void)setModel:(HFormModel *)model
{
    [super setModel:model];
    //填充数据!
    
    if (model.pickData) {
        _pickerItem.pickerData = model.pickData;
    }
    
    if (self.style == DateMinHFormStyle)
    {
        _pickerItem.value = [HTools showTimeDateWithMinReq:model.detail];
        _rightPickerItem.value = [HTools showTimeMinuteWithMinReq:model.detail];
    }else
    {
        _pickerItem.value = model.detail;
    }
}


//创建对应的UI
-(void)setStyle:(HFormStyle)style
{
    [super setStyle:style];
    
    //这里进行区分
    WEAK_SELF;
    //这里要做区分,
    if (self.style == PickerHFormStyle)
    {
        [self addSubview:self.pickerItem];
        //因为布局的内容一致,就用一个就可以了
        self.RightV = self.pickerItem;
        [self.pickerItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleV.mas_right);
            make.centerY.height.equalTo(self.titleV);
            make.right.equalTo(weakSelf).offset(-HModuleTitleLeft);
        }];
    }else if (self.style == DateHFormStyle)
    {
        [self addSubview:self.pickerItem];
        self.pickerItem.isDate = YES;
        //因为布局的内容一致,就用一个就可以了
        self.RightV = self.pickerItem;
        [self.pickerItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleV.mas_right);
            make.centerY.height.equalTo(self.titleV);
            make.right.equalTo(weakSelf).offset(-HModuleTitleLeft);
        }];
    }else if(self.style == DateMinHFormStyle)//日期和时间都有!
    {
        self.pickerItem.isDate = YES;
        self.rightPickerItem.isTime = YES;
        self.pickerItem.value = [HTools dateNow];
        self.rightPickerItem.value = @"8:00";
        //设置右边的按键
        [self.containV addSubview:self.pickerItem];
        [self.containV addSubview:self.rightPickerItem];
        NSNumber *rateNum = self.originModel.leftRightRate?self.originModel.leftRightRate:@(0.5);
        CGFloat rate = rateNum.floatValue;
        //因为布局的内容一致,就用一个就可以了
        self.RightV = self.containV;
        [self.pickerItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.containV);
            make.top.bottom.equalTo(weakSelf.containV);
        }];
        [self.rightPickerItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.pickerItem.mas_right).offset(HSmallVerticalMagin);
            make.width.equalTo(weakSelf.containV).multipliedBy(rate-0.1);
            make.top.bottom.equalTo(weakSelf.pickerItem);
            make.right.equalTo(weakSelf.containV);
        }];
    }
    
}

#pragma mark 代理

- (void)addEditUnitTextFieldDidChangedWithValue:(NSString *)value
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(editTextDidChangeWithView:andValue:)]) {
        [self.delegate editTextDidChangeWithView:self andValue:value];
    }
}

- (void)addEditUnitTextFieldDidBegin
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(editTextBeginWithView:)]) {
        [self.delegate editTextBeginWithView:self];
    }
}



/**
 按钮事件传输出去 ,
 */
#pragma mark picker选择器
-(void)addEditUnitOnClick
{
    //点击事件传自己的view出去
    HFormOriginModel *model = self.originModel;
    //如果是选择器的话,或者地址选择器
    if (model.style == PickerHFormStyle) {
        if (model.isDateBtn == NO) {
            HPickerView *pickerView = [[HPickerView alloc]init];
            pickerView.delegate = self;
            pickerView.selectLb.text = model.pickerTitle;
            //判断刷新的数据源
            if (self.model.pickData&&self.model.pickData.count>0)
            {
                pickerView.customArr = self.model.pickData;
            }else
                pickerView.customArr = model.pickerArr;
            
            [[UIApplication sharedApplication].keyWindow addSubview:pickerView];
        }
    }
    if (model.style == AddressHFormStyle) {
        WEAK_SELF;
        HCityChooseView * view = [[HCityChooseView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        view.selectedBlock = ^(NSString * province, NSString * city, NSString * area){
            self.value = [NSString stringWithFormat:@"%@%@%@",province,city,area];
            if (weakSelf.delegate&&[weakSelf.delegate respondsToSelector:@selector(selectedCityWithProvince:andCity:andArea:)]) {
                [weakSelf.delegate selectedCityWithProvince:province andCity:city andArea:area];
            }
            
        };
        [[UIApplication sharedApplication].keyWindow addSubview:view];;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addEditItemOnClickWithView:)]) {
        [self.delegate addEditItemOnClickWithView:self];
    }
}

- (void)PickerSelectorIndixString:(NSString *)str
{
    self.value = str;
}


-(NSString *)value
{
    NSString *value = [super value];
    value =_pickerItem.value;
    return value;
}

-(void)setValue:(NSString *)value
{
    [super setValue:value];
    _pickerItem.value = value;
}

#pragma mark - overWrite
-(NSDictionary *)valueDic
{
    //按照数据回传
    if (self.style == DateMinHFormStyle) {
        if (_pickerItem&&
            _rightPickerItem&&
            self.originModel.rightKey.length>0&&
            self.originModel.leftKey.length>0)
        {
            return @{self.originModel.leftKey:_pickerItem.value,self.originModel.rightKey:_rightPickerItem.value};
        }
        if (self.originModel.key>0)
        {
            return @{self.originModel.key:[HTools reqTimeWithShow:_pickerItem.value andMin:_rightPickerItem.value]};
        }
    }else
    {
        if (_pickerItem) {
            return @{self.originModel.key:_pickerItem.value};
        }
    }
    return @{};
}

#pragma mark - getter
-(HFormPickerUnit *)pickerItem
{
    if (!_pickerItem) {
        HFormPickerUnit *textField  = [HFormPickerUnit new];
        textField.isButtonHide = NO;
        textField.delegate = self;
        textField.backgroundColor = [UIColor clearColor];
        _pickerItem = textField;
    }
    return _pickerItem;
}

-(HFormPickerUnit *)rightPickerItem
{
    if (!_rightPickerItem) {
        HFormPickerUnit *textField  = [HFormPickerUnit new];
        textField.isButtonHide = NO;
        textField.delegate = self;
        textField.backgroundColor = [UIColor clearColor];
        _rightPickerItem = textField;
    }
    return _rightPickerItem;
}

-(UIView *)containV
{
    if (!_containV)
    {
        UIView *view = [UIView new];
        _containV = view;
        [self addSubview:view];
        WEAK_SELF;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleV.mas_right);
            make.top.bottom.equalTo(self.titleV);
//            make.right.equalTo(weakSelf);
            make.right.equalTo(weakSelf).offset(-HModuleTitleLeft);
        }];
    }
    return _containV;
}

@end

