//
//  BaseInfoView.m
//  QHZC
//
//  Created by Vincent on 2017/4/19.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "BaseInfoView.h"
@interface BaseInfoView ()

@property(nonatomic,strong)UILabel *warningLB ;//
@property(nonatomic,strong)UIButton *clearBtn ;//隐藏按钮

@end

@implementation BaseInfoView
{
    UILabel *titleLbl;

}

-(UILabel *)warningLB
{
    if (!_warningLB) {
        NSString *warnStr = @"期限定制/收益率定制/手续费减免，请发起邮件审批，全部完成后通知运营";
        _warningLB = [UILabel labelWithText:warnStr font:hNomalFont textColor:[UIColor redColor] backgroundColor:[UIColor clearColor] isSizeToFit:YES];
        _warningLB.numberOfLines = 0;
    }
    return _warningLB;
}

#pragma mark - public

-(void)showWarning
{
    return;
    [self.headView addSubview:self.warningLB];
    WEAK_SELF;
    [self.warningLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headView).offset(HCommonHorizontalMagin);
        make.left.equalTo(self.headView).offset(15);
        make.right.equalTo(self.headView).offset(-15);
        
    }];
    
    [titleLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.warningLB.mas_bottom).offset(HCommonHorizontalMagin);
        make.left.equalTo(self.headView).offset(15);
        make.bottom.equalTo(weakSelf.headView).offset(-HCommonHorizontalMagin);
        
    }];
    
    
}

- (void)editBtnAction
{
    //点击事件传自己的view出去
    if (self.delegate&&[self.delegate respondsToSelector:@selector(baseInfoViewClick:)]) {
        [self.delegate baseInfoViewClick:self];
    }
    
    
}


- (void)setTitleName:(NSString *)titleName
{
    [titleLbl setText:titleName];
    if (titleName.length>16) {
        titleLbl.numberOfLines = 0;
        WEAK_SELF;
        [titleLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
            //        make.centerY.equalTo(self.headView);
            make.top.equalTo(weakSelf.headView).offset(HCommonHorizontalMagin);
            make.left.equalTo(self.headView).offset(15);
            make.right.equalTo(self.headView).offset(-70);
            make.bottom.equalTo(weakSelf.headView).offset(-HCommonHorizontalMagin);
            
        }];
    }
    
}


-(void)hideTitleView
{
    _headView.hidden = YES;
    [_headView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.detailView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.headView.mas_bottom);
        make.top.left.right.equalTo(self);
        make.left.right.bottom.equalTo(self);
    }];
    
    
}

-(void)setbtnTitle:(NSString *)btnTitle
{
    //设置为空
    [_editBtn setImage:nil forState:(UIControlStateNormal)];
    [_editBtn setTitle:btnTitle forState:UIControlStateNormal];
}
//修改按钮的图片名称
-(void)setbtnImg:(NSString *)btnImg
{
    [_editBtn setImage:[UIImage imageNamed:btnImg] forState:(UIControlStateNormal)];
    //设置为空
    [_editBtn setTitle:nil forState:UIControlStateNormal];
}

-(void)setBtnHideStatus:(BOOL)isHidden
{
    self.editBtn.hidden = isHidden;
    self.clearBtn.hidden = isHidden;
}


#pragma mark - private

- (instancetype)initWithBtnTitle:(NSString *)btnTitle
{
    self = [super init];
    if (self) {
        [self setUI];
        //设置为空
        [_editBtn setImage:nil forState:(UIControlStateNormal)];
        [_editBtn setTitle:btnTitle forState:UIControlStateNormal];
        
        [self setupCell];
        [self setupDetailView];
    }
    return self;
}

- (instancetype)initWithHideBtn:(BOOL)hideBtn
{
    if (self = [super init])
    {
        [self setUI];
        
        if (hideBtn)
        {
            self.editBtn.hidden = YES;
            self.clearBtn.hidden = YES;
        }
        
        [self setupCell];
        [self setupDetailView];
        
    }
    
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
        //默认按钮是隐藏的所以这里初始化的时候可以实现!
        self.editBtn.hidden = YES;
        self.clearBtn.hidden = YES;
        [self setupCell];
        [self setupDetailView];
    }
    return self;
}

//可以重写该方法,不写就算了
-(void)setupCell
{
    
}

-(void)setupDetailView
{
    
}

- (void)setUI
{
    WEAK_SELF;
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);

    }];
    
    titleLbl = [UILabel labelWithText:@"加载中"
                                 font:assistFontSize
                            textColor:hDetailFontColor
                      backgroundColor:kBackgroundColor
                          isSizeToFit:YES];
    titleLbl.numberOfLines = 0;
    [self.headView addSubview:titleLbl];
    
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.headView);
        make.top.equalTo(weakSelf.headView).offset(HCommonHorizontalMagin);
        make.left.equalTo(self.headView).offset(15);
        make.bottom.equalTo(weakSelf.headView).offset(-HCommonHorizontalMagin);
        
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headView).offset(-15);
        make.centerY.equalTo(self.headView);
    }];
    
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headView);
        make.top.bottom.equalTo(self.headView);
        make.width.equalTo(self.headView).multipliedBy(1/5.0);
    }];
    
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];

}

-(UIView *)headView
{
    if (_headView == nil)
    {
        _headView = [UIView new];
        _headView.backgroundColor = kBackgroundColor;
        [self addSubview:_headView];
    }
    
    return _headView;
}

- (UIButton *)editBtn
{
    if (_editBtn == nil)
    {
        UIButton *btn = [UIButton new];
        // hHighLightTextColor
        [btn setTitleColor:kButtonNormalColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:hNomalFont];
        [btn addTarget:self action:@selector(editBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [btn setImage:[UIImage bundleImgWithName:@"icon_edit"] forState:(UIControlStateNormal)];
        [self.headView addSubview:btn];
        _editBtn = btn;
    }
    
    return _editBtn;
}

-(UIButton *)clearBtn
{
    if (_clearBtn == nil)
    {
        UIButton *btn = [UIButton new];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(editBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.headView addSubview:btn];
        _clearBtn = btn;
    }
    return _clearBtn;
}

- (UIView *)detailView
{
    if (_detailView == nil)
    {
        _detailView = [UIView new];
        [self addSubview:_detailView];
    }
    return _detailView;
}
@end

