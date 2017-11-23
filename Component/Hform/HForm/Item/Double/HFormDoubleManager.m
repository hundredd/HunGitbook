//
//  HFormDoubleManager.m
//  QHZC
//
//  Created by hun on 2017/10/31.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormDoubleManager.h"
#import "HFormDoubleDateUnit.h"
@interface HFormDoubleManager ()
@property(nonatomic,strong)HFormDoubleDateUnit *dateItem;             //时间模块
@end
@implementation HFormDoubleManager

#pragma mark - method
-(void)addEditUnitOnClick
{
    //点击事件传自己的view出去
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addEditItemOnClickWithView:)]) {
        [self.delegate addEditItemOnClickWithView:self];
    }
}

//主要是进行左右填充的一种回调
-(void)addEditLeftValue:(NSString *)left andRightValue:(NSString *)right
{
    //点击事件传自己的view出去
    HFormOriginModel *model = self.originModel;
    if (model.style == DoubleDateHFormStyle)
    {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(addEditItemFinshSelectedWithView:andLeftValue:andRightValue:)]) {
            [self.delegate addEditItemFinshSelectedWithView:self andLeftValue:left andRightValue:right];
        }
    }
}

#pragma mark - override
//渲染并创建
-(void)setOriginModel:(HFormOriginModel *)originModel
{
    [super setOriginModel:originModel];
    if (originModel.style == DoubleDateHFormStyle){
        if (originModel.startTime) {
            _dateItem.leftValue = originModel.startTime;
        }
        if (originModel.endTime) {
            _dateItem.rightValue = originModel.endTime;
        }
        
        if (originModel.delegate) {
            self.delegate = originModel.delegate;
        }
        if (originModel.isRightLongTerm)
        {
            _dateItem.isRightLongTerm = originModel.isRightLongTerm;
        }
    }
    
}


-(void)setModel:(HFormModel *)model
{
    [super setModel:model];
    if (model.leftValue||model.rightValue) {
        if (_dateItem) {
            if (model.leftValue) {
                _dateItem.leftValue = model.leftValue;
            }
            if (model.rightValue) {
                _dateItem.rightValue = model.rightValue;
            }
        }
    }
}


//创建对应的UI
-(void)setStyle:(HFormStyle)style
{
    [super setStyle:style];
    WEAK_SELF;
    if (style == DoubleDateHFormStyle) {
        [self addSubview:self.dateItem];
        //因为布局的内容一致,就用一个就可以了
        self.RightV = self.dateItem;
        [self.dateItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleV.mas_right);
            make.centerY.height.equalTo(self.titleV);
            make.right.equalTo(weakSelf).offset(-HModuleTitleLeft);
        }];
    }
    
    
}

-(HFormDoubleDateUnit *)dateItem
{
    if (!_dateItem) {
        HFormDoubleDateUnit *selectedV = [HFormDoubleDateUnit new];
        selectedV.backgroundColor = [UIColor clearColor];
        
        _dateItem = selectedV;
        WEAK_SELF;
        _dateItem.timeSelectAction = ^(){
            [weakSelf addEditUnitOnClick];
        };
        //填充左右的值
        _dateItem.finishSelected=^(NSString *leftValue,NSString *rightValue)
        {
            [weakSelf addEditLeftValue:leftValue andRightValue:rightValue];
        };
        _dateItem = selectedV;
    }
    return _dateItem;
}

#pragma mark - overWrite
-(NSDictionary *)valueDic
{
    if (_dateItem) {
        return @{self.originModel.keyTime1:_dateItem.leftValue,self.originModel.keyTime2:_dateItem.rightValue};
    }
    return @{};
}

@end
