//
//  HFormSolidManager.m
//  QHZC
//
//  Created by hun on 2017/10/13.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormSolidManager.h"
#import "HFormSolidUnit.h"
@interface HFormSolidManager ()
 @property(nonatomic,strong)HFormSolidUnit *solidItem;             //时间模块
@end
@implementation HFormSolidManager


#pragma mark - method
- (void)addEditUnitTextFieldDidBegin
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(editTextBeginWithView:)]) {
        [self.delegate editTextBeginWithView:self];
    }
}

#pragma mark - override
//渲染并创建
-(void)setOriginModel:(HFormOriginModel *)originModel
{
    [super setOriginModel:originModel];
    
    if (originModel.style == SolidTelHFormStyle){
        if (originModel.leftValue) {
            _solidItem.leftValue = originModel.leftValue;
        }
        if (originModel.rightValue) {
            _solidItem.rightValue = originModel.rightValue;
        }
        
        if (originModel.delegate) {
            self.delegate = originModel.delegate;
        }
    }
}


-(void)setModel:(HFormModel *)model
{
    [super setModel:model];
    if (model.leftValue||model.rightValue) {
        if (_solidItem) {
            if (model.leftValue) {
                _solidItem.leftValue = model.leftValue;
            }
            if (model.rightValue) {
                _solidItem.rightValue = model.rightValue;
            }
        }
    }
}


//创建对应的UI
-(void)setStyle:(HFormStyle)style
{
    [super setStyle:style];
    WEAK_SELF;
    if (style == SolidTelHFormStyle) {
        [self addSubview:self.solidItem];
        //因为布局的内容一致,就用一个就可以了
        self.RightV = self.solidItem;
        [self.solidItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleV.mas_right);
            make.centerY.height.equalTo(self.titleV);
            make.right.equalTo(weakSelf).offset(-HModuleTitleLeft);
        }];
    }
    
}


-(HFormSolidUnit *)solidItem
{
    if (!_solidItem) {
        HFormSolidUnit *solidTelV = [HFormSolidUnit new];
        solidTelV.backgroundColor = [UIColor clearColor];
        [self addSubview:solidTelV];
        _solidItem = solidTelV;
        WEAK_SELF;
        _solidItem.editAction = ^(){
            [weakSelf addEditUnitTextFieldDidBegin];
        };
    }
    return _solidItem;
}

#pragma mark - overWrite
-(NSDictionary *)valueDic
{
    if (_solidItem) {
        return @{self.originModel.keyTime1:_solidItem.leftValue,self.originModel.keyTime2:_solidItem.rightValue};
    }
    return @{};
}

@end
