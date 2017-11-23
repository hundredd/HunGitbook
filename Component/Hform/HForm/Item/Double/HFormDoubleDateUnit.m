//
//  HFormDoubleDateUnit.m
//  QHZC
//
//  Created by hun on 2017/10/31.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormDoubleDateUnit.h"
#import "HFormEditUnit.h"
#import "HTools.h"
@interface HFormDoubleDateUnit()<HFormEditUnitDelegate>

@property(nonatomic,strong)HFormEditUnit *leftItem;
@property(nonatomic,strong)HFormEditUnit *rightItem;
@property(nonatomic,strong)UILabel *middleLB;

@end

@implementation HFormDoubleDateUnit
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
    _leftValue = leftValue;
    _leftItem.value = leftValue;
}

-(void)setRightValue:(NSString *)rightValue
{
    _rightValue = rightValue;
    _rightItem.value = rightValue;
}

-(void)setIsRightLongTerm:(BOOL)isRightLongTerm
{
    _isRightLongTerm = isRightLongTerm;
    _rightItem.isPickShowCenter = _isRightLongTerm;
}

#pragma mark delegate
-(void)addEditUnitOnClickWithView:(HFormEditUnit *)targetView
{
    //    NSLog(@"点击事件的tag:%d",targetView.tag);
    if (_timeSelectAction) {
        _timeSelectAction();
    }
}

//获取左右的值!
- (void)addEditUnitTextFieldDidChangedWithView:(HFormEditUnit *)targetView andValue:(NSString *)value
{
    if (targetView==_leftItem) {
        if (self.finishSelected)
        {
            self.finishSelected(value, nil);
        }
    }else if (targetView==_rightItem) {
        if (self.finishSelected)
        {
            self.finishSelected(nil, value);
        }
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
        //        view.isPickShowCenter = YES;左边是不需要设置长期的
        view.isButtonHide = NO;
        view.isDate = YES;
        view.value=[HTools dateNow];
        view.delegate = self;
        view.placeholder = @"请选起始时间";
        view.tag = 1;
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
        //        view.isPickShowCenter = YES;左边是不需要设置长期的
        view.isButtonHide = NO;
        view.isDate = YES;
        view.placeholder = @"请选到期时间";
        view.value=[HTools dateNow];
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
