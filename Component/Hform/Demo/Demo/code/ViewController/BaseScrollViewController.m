//
//  BaseScrollViewController.m
//  QHZC
//
//  Created by hundred on 2017/5/31.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "BaseScrollViewController.h"

@interface BaseScrollViewController ()

@end

@implementation BaseScrollViewController
{
    
    UIScrollView    *_scrollV;
}
#pragma mark - public

-(void)setupContentUI
{
    NSLog(@"重写内容方法");
}
-(void)setupContentLayout
{
    NSLog(@"重写内容Layout方法");
}





#pragma mark - private

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupLayout];
    

}


-(void)setupUI
{
    
    if (!_scrollV) {
        UIScrollView *scrollV = [UIScrollView new];
        [self.view addSubview:scrollV];
        _scrollV=scrollV;
        _scrollV.userInteractionEnabled = YES;
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.bounces=NO;
    }
    
    if (!_contentV) {
        UIView *contentV = [UIView new];
        contentV.backgroundColor = [UIColor clearColor];
        [_scrollV addSubview:contentV];
        _contentV = contentV;
    }
    

}


-(void)setupLayout
{

    WEAK_SELF;
    [_scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.navigationController.navigationBar.mas_bottom);
        make.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
    
    [_contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollV);
        make.width.equalTo(_scrollV);
    }];
    


    //需要重写以下方法
    [self setupContentUI];
    [self setupContentLayout];
}


@end
