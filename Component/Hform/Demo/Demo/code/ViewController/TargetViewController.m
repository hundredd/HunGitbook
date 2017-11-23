//
//  TargetViewController.m
//  Demo
//
//  Created by hun on 2017/11/23.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "TargetViewController.h"
#import "BaseEditView.h"


@interface TargetViewController ()

@property(nonatomic,strong)BaseEditView *editView ;//显示!


@end

@implementation TargetViewController




-(void)setupContentUI
{
    [self.contentV addSubview:self.editView];
    WEAK_SELF;
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentV);
    }];
}

-(BaseEditView *)editView
{
    if (!_editView) {
        _editView = [BaseEditView new];
    }
    return _editView;
}



@end
