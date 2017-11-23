//
//  HFormEditManager.m
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormEditManager.h"
#import "HFormEditUnit.h"
@interface HFormEditManager()<HFormEditUnitDelegate>

@property(nonatomic,strong)HFormEditUnit *textFieldItem;//编辑的


@end

@implementation HFormEditManager

//渲染并创建
-(void)setOriginModel:(HFormOriginModel *)originModel
{
    [super setOriginModel:originModel];
    
    //初始化数据!
    if (originModel.value) {
        _textFieldItem.value = originModel.value;
        
    }
    if (originModel.placeHolder) {
        _textFieldItem.placeholder = originModel.placeHolder;
    }
    if (originModel.pickerArr) {
        _textFieldItem.pickerData = originModel.pickerArr;
    }
    if (originModel.pickerTitle) {
        _textFieldItem.pickerTitle = originModel.pickerTitle;
    }
    if (originModel.delegate) {
        self.delegate = originModel.delegate;
    }
    if (originModel.single) {
        _textFieldItem.single = originModel.single;
    }
    //最大长度
    if (originModel.maxNum) {
        _textFieldItem.limitNum = originModel.maxNum;
    }
    
    if (originModel.rightBtnTitle) {
        _textFieldItem.rightTitle = originModel.rightBtnTitle;
    }
    
    _textFieldItem.isDate=originModel.isDateBtn;
    
    
    

}


-(void)setModel:(HFormModel *)model
{
    [super setModel:model];
    //填充数据!
    
    if (model.detail) {
        _textFieldItem.value = model.detail;
    }
    
    if (model.pickData) {
        _textFieldItem.pickerData = model.pickData;
    }
    

}


//创建对应的UI
-(void)setStyle:(HFormStyle)style
{
    [super setStyle:style];
    
    WEAK_SELF;
    HFormEditUnit *textField ;
    if (!_textFieldItem) {
        switch (style) {
            case NomalTextFieldHFormStyle:
                textField = [[HFormEditUnit alloc]initWithStyle:TextFieldNomalHFormEditUnitStyle];
                textField.isButtonHide = YES;
                break;
            case NumTextFieldHFormStyle:
                textField = [[HFormEditUnit alloc]initWithStyle:TextFieldNumHFormEditUnitStyle];
                textField.isButtonHide = YES;
                break;
            case NumTextFieldDocHFormStyle:
                textField = [[HFormEditUnit alloc]initWithStyle:TextFieldNumDocHFormEditUnitStyle];
                textField.isButtonHide = YES;
                break;
            case ButtonHFormStyle:
                textField = [[HFormEditUnit alloc]initWithStyle:TextFieldNomalHFormEditUnitStyle];
                textField.isRightStyle = self.originModel.isRightBtn;
                if (self.originModel.isHideRightBtn) {
                    [textField setImageHidden:YES];
                }
                textField.isButtonHide = NO;
                break;
            case PickerHFormStyle://选择器
                
                textField = [[HFormEditUnit alloc]initWithStyle:TextFieldNomalHFormEditUnitStyle];
                textField.isButtonHide = NO;
                break;
            case AddressHFormStyle:
                textField = [[HFormEditUnit alloc]initWithStyle:TextFieldNomalHFormEditUnitStyle];
                textField.isButtonHide = NO;
                break;
            default:
                break;
        }
        textField.delegate = self;
        
        textField.backgroundColor = [UIColor clearColor];
        [self addSubview:textField];
        _textFieldItem = textField;
    }
    
    //因为布局的内容一致,就用一个就可以了
    if (textField) {
        self.RightV = textField;
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleV.mas_right);
            make.centerY.height.equalTo(self.titleV);
            make.right.equalTo(weakSelf).offset(-HModuleTitleLeft);
            //            make.right.equalTo(weakSelf);
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
    value =_textFieldItem.value;
    return value;
}

-(void)setValue:(NSString *)value
{
    [super setValue:value];
    _textFieldItem.value = value;
}

#pragma mark - overWrite
-(NSDictionary *)valueDic
{
    if (_textFieldItem) {
        return @{self.originModel.key:_textFieldItem.value};
    }
    return @{};
}

@end
