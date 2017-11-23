//
//  HFormSolidUnit.m
//  QHZC
//
//  Created by hun on 2017/10/31.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormSolidUnit.h"

#import "HFormEditUnit.h"
@interface HFormSolidUnit()<HFormEditUnitDelegate>

@property(nonatomic,strong)HFormEditUnit *leftItem;
@property(nonatomic,strong)HFormEditUnit *rightItem;
@property(nonatomic,strong)UILabel *middleLB;

@end

@implementation HFormSolidUnit
@synthesize leftValue = _leftValue;
@synthesize rightValue = _rightValue;
#pragma mark - public

-(NSString *)leftValue
{
    return _leftItem.value;
}



-(NSString *)rightValue
{
    return _rightItem.value;
}

-(void)setLeftValue:(NSString *)leftValue
{
    _leftItem.value = leftValue;
}

-(void)setRightValue:(NSString *)rightValue
{
    _rightItem.value = rightValue;
}

#pragma mark delegate
//获取左右的值!
- (void)addEditUnitTextFieldDidChangedWithView:(HFormEditUnit *)targetView andValue:(NSString *)value
{
    if (targetView == _leftItem)
    {
        if (_leftItem.value.length>=4)
        {
            [_rightItem setFirstResponder];
        }
    }
    
}
- (void)addEditUnitTextFieldDidBegin
{
    if (_editAction) {
        _editAction();
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
    [self.leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.bottom.equalTo(weakSelf);
        
    }];
    [self.middleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftItem.mas_right).offset(HCommonVerticalMagin);
        make.centerY.equalTo(_leftItem);
    }];
    
    [self.rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_middleLB.mas_right).offset(HCommonVerticalMagin);
        //需要和左边那个相等!
        make.height.width.equalTo(_leftItem);
        make.centerY.equalTo(_leftItem);
        make.right.equalTo(weakSelf);
    }];
}

#pragma mark - getter

-(HFormEditUnit *)leftItem
{
    if (!_leftItem) {
        HFormEditUnit *view = [HFormEditUnit new];
        [view setImageHidden:YES];
        view.tag = 1;
        view.value=@"";
        view.placeholder = @"区号";
        view.delegate = self;
        view.limitNum = 4;
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        _leftItem = view;
    }
    return _leftItem;
}

-(HFormEditUnit *)rightItem
{
    if (!_rightItem) {
        HFormEditUnit *view = [HFormEditUnit new];
        view.placeholder = @"请输入号码";
        [view setImageHidden:YES];
        view.limitNum = 8;
        view.value=@"";
        view.delegate = self;
        view.tag = 2;
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        _rightItem = view;
    }
    return _rightItem;
}


-(UILabel *)middleLB
{
    if (!_middleLB) {
        UILabel *titlelabel = [UILabel labelWithText:@""
                                                font:hNomalTitleFont
                                           textColor:HFieldPlaceHoldColor
                                     backgroundColor:hClearColor isSizeToFit:YES];
        [self addSubview:titlelabel];
        _middleLB = titlelabel;
    }
    return _middleLB;
}


@end
