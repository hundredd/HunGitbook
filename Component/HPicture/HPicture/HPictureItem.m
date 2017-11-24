//
//  HPictureItem.m
//  QHZC
//
//  Created by hundred on 2017/5/22.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HPictureItem.h"
#import "UIButton+WebCache.h"
@implementation HPictureItem
{
    UIImageView *_cancelImgV;
    UIButton    *_cancelBtn;
}

#pragma mark - public
-(void)cancelAction
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(cancelImgActionWithTag:)]) {
        [self.delegate cancelImgActionWithTag:self.tag];
    }
}


-(void)setImgV:(UIImageView *)imgV
{
    _imgV = imgV;
    [self addSubview:_imgV];
    [self insertSubview:_imgV atIndex:0];
    //保证图片不变形
    _imgV.contentMode = UIViewContentModeScaleAspectFill;
    _imgV.clipsToBounds = YES;
    WEAK_SELF;
    [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
}


-(void)setCancelHidden
{
    _cancelBtn.hidden = YES;
    _cancelImgV.hidden = YES;
}


#pragma mark - private

- (instancetype)init
{
    self = [super init];
    if (self) {
       
        [self _initUI];
        [self _initLayout];
    }
    return self;
}


-(void)_initUI
{
    if (!_cancelImgV) {
        UIImageView *imgV = [UIImageView new];
        imgV.image = [UIImage bundleImgWithName:@"icon_x"];
        [self addSubview:imgV];
        _cancelImgV = imgV;
    }
    
    if (!_cancelBtn) {
        UIButton *cancelBtn = [UIButton new];
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        _cancelBtn = cancelBtn;
    }
    
    
}


-(void)_initLayout
{
    WEAK_SELF;
    [_cancelImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.height.width.equalTo(@20);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(weakSelf);
//        make.width.equalTo(weakSelf).multipliedBy(0.5);
        make.height.width.equalTo(@30);
    }];
}

@end
