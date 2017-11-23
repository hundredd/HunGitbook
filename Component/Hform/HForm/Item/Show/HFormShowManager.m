//
//  HFormShowManager.m
//  QHZC
//
//  Created by hun on 2017/10/13.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormShowManager.h"

@interface HFormShowManager()

@property(nonatomic,strong)UILabel *detailLB;

@property(nonatomic,strong)UILabel *detail2LB;

@property(nonatomic,strong)UIView *containV ;//底部容器

@property(nonatomic,assign)BOOL isAutoShow ;//是否自动换行,只显示detail
@end

@implementation HFormShowManager

-(instancetype)initWithShowAuto:(BOOL)isShowAuto
{
    if (self = [super init])
    {
        self.isAutoShow = isShowAuto;
        
    }
    return self;
}

-(void)setValue:(NSString *)value
{
    [super setValue:value];
    //不一定大于0,可以为空!
    self.detailLB.text =  value;
}

//渲染并创建
-(void)setOriginModel:(HFormOriginModel *)originModel
{
    [super setOriginModel:originModel];
    
    if (originModel.value.length>0)
     {
        self.detailLB.text =  originModel.value;
    }
    if (originModel.isHighLight) {
        self.detailLB.textColor = hBlueTextColor;
    }
}


-(void)setModel:(HFormModel *)model
{
    [super setModel:model];
    
    if (model.detail.length>0) {
        self.detailLB.text = model.detail;
    }
    
    if (model.detail2.length>0)
    {
        self.detail2LB.text = model.detail2;
    }
    
    if (model.detail2Attr.length>0)
    {
        [self.detail2LB setAttributedText:model.detail2Attr];
    }
}


//创建对应的UI
-(void)setStyle:(HFormStyle)style
{
    [super setStyle:style];
    
    [self.containV addSubview:self.detailLB];
    WEAK_SELF;
    self.RightV = self.detailLB;
    [self.detailLB mas_makeConstraints:^(MASConstraintMaker *make)
    {
        if (self.isAutoShow)//如果是自动显示的默认不理右边的单位detial!,添加右边约束
        {
            make.right.equalTo(weakSelf.containV);
            self.detailLB.numberOfLines = 0;
        }
        make.left.right.equalTo(weakSelf.containV);
        make.top.bottom.equalTo(weakSelf.containV);
    }];
    
}


#pragma mark - getter
-(UILabel *)detailLB
{
    if (!_detailLB) {
        _detailLB = [UILabel labelWithText:@""
                                      font:hNomalTitleFont
                                 textColor:hBlackFontColor
                           backgroundColor:hClearColor
                               isSizeToFit:YES];
    }
    return _detailLB;
}

-(UILabel *)detail2LB
{
    if (!_detail2LB) {
        _detail2LB = [UILabel labelWithText:@""
                                       font:hNomalTitleFont
                                  textColor:hBlackFontColor
                            backgroundColor:hClearColor
                                isSizeToFit:YES];
        [self.containV addSubview:_detail2LB];
        
        WEAK_SELF;
        
        [self.detailLB mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(_detailLB.mas_left).offset(-HSmallVerticalMagin);
            make.left.equalTo(weakSelf.containV);
            make.top.bottom.equalTo(weakSelf.containV);
        }];
        
        [_detail2LB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.titleV);
            make.right.equalTo(weakSelf.containV);
        }];
        
        
    }
    return _detail2LB;
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
            make.right.equalTo(weakSelf).offset(-HModuleTitleLeft);
            make.bottom.equalTo(weakSelf).with.priorityHigh();
        }];
    }
    return _containV;
}


@end
