//
//  HFormSelectUnit.m
//  QHZC
//
//  Created by hun on 2017/10/13.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormSelectUnit.h"

@interface HFormSelectUnit ()

@property(nonatomic,strong)UIImageView  *selectedImg;
@property(nonatomic,strong)UILabel      *titleLB;
@property(nonatomic,strong)UIButton     *btn;
@property(nonatomic,assign)BOOL isMuti ;//多项选择
@end

@implementation HFormSelectUnit


#pragma mark - public
-(void)btnAction
{
    if (self.addSelectUnitOnclick) {
        self.addSelectUnitOnclick(self);
    }
}

-(void)setIsHighLightTitle:(BOOL)isHighLightTitle
{
    _isHighLightTitle = isHighLightTitle;
    if (isHighLightTitle) {
        _titleLB.textColor = hBlueTextColor;
    }else
    {
        _titleLB.textColor = hBlackFontColor;
    }
    
}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    //设置btn的选中状态
    _btn.selected = isSelected;
    
    if (self.isMuti)
    {
        //多选项的活动管理
        if (isSelected) {
            
            _selectedImg.image =[UIImage bundleImgWithName:@"icon-_checkbox_selected"];// [UIImageManager bundleImgWithName:@"activity_icon-_checkbox_selected"];
        }else
        {
            _selectedImg.image =[UIImage bundleImgWithName:@"icon-_checkbox_unselected"];// [UIImageManager bundleImgWithName:@"activity_icon-_checkbox_unselected"];
        }
    }else
    {
        if (isSelected) {
            _selectedImg.image = [UIImage bundleImgWithName:@"icon_checkbox_selected"];// [UIImageManager bundleImgWithName:@"common_icon_checkbox_selected"];
        }else
        {
            _selectedImg.image = [UIImage bundleImgWithName:@"icon_checkbox"];// [UIImageManager bundleImgWithName:@"common_icon_checkbox"];
        }
    }
    
}




-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLB.text = title;
}


#pragma mark - private

- (instancetype)initWithIsMuti:(BOOL)isMuti
{
    self = [super init];
    if (self) {
        self.isMuti = isMuti;
        [self setupUI];
    }
    return self;
}

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
    
    CGFloat height = HBigHorizontalMagin;
    CGFloat magin = HCommonVerticalMagin;
    if (IS_IPHONE_5) {
        height = HCommonHorizontalMagin;
        self.titleLB.font = HSmallFontSize;
        magin = HSmallVerticalMagin;
    }
    [self.selectedImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf).offset(HSmallVerticalMagin);
        make.bottom.equalTo(weakSelf).offset(-HSmallVerticalMagin);
        make.height.mas_equalTo(height);
        make.width.equalTo(_selectedImg.mas_height).multipliedBy(1);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectedImg.mas_right).offset(magin);
        make.centerY.equalTo(_selectedImg);
        make.right.equalTo(weakSelf);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
}

#pragma mark - getter


-(UIImageView *)selectedImg
{
    if (!_selectedImg) {
        UIImageView *imgV = [UIImageView new];
        //正常: common_icon_checkbox  ,选中的:common_icon_selected
        //多选项的
        if (_isMuti)
        {
            imgV.image = [UIImage bundleImgWithName:@"icon-_checkbox_unselected"];//[UIImageManager bundleImgWithName:@"activity_icon-_checkbox_unselected"];
        }else
            imgV.image = [UIImage bundleImgWithName:@"icon_checkbox"];//[UIImageManager bundleImgWithName:@"common_icon_checkbox"];
        [self addSubview:imgV];
        _selectedImg = imgV;
    }
    return _selectedImg;
}


-(UILabel *)titleLB
{
    if (!_titleLB) {
    UILabel *titlelabel = [UILabel labelWithText:@""
                                            font:hNomalFont
                                       textColor:hBlackFontColor
                                 backgroundColor:hClearColor
                                     isSizeToFit:YES];
    [self addSubview:titlelabel];
    _titleLB = titlelabel;
    }
    return _titleLB;
}

-(UIButton *)btn
{
    if(!_btn){
        UIButton *view = [UIButton new];
        view.backgroundColor = [UIColor clearColor];
        [view addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:view];
        _btn = view;
    }
    return _btn;
}

@end
