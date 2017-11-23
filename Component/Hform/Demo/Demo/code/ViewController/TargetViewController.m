//
//  TargetViewController.m
//  Demo
//
//  Created by hun on 2017/11/23.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "TargetViewController.h"
#import "BaseEditView.h"
#import "EditDemoView.h"
#import "PickerDemoView.h"
#import "SelectDemoView.h"
@interface TargetViewController ()

@property(nonatomic,strong)BaseEditView *editView ; //显示!

@property(nonatomic,strong)UIButton *subBtn ;       //按钮!
@end

@implementation TargetViewController




-(void)setupContentUI
{
    [self.contentV addSubview:self.editView];
    [self.contentV addSubview:self.subBtn];
    WEAK_SELF;
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.contentV);
    }];
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.editView.mas_bottom).offset(10);
        make.centerX.equalTo(weakSelf.editView);
        make.bottom.equalTo(weakSelf.contentV);
    }];
    
}

-(BaseEditView *)editView
{
    if (!_editView) {
        switch (self.style)
        {
            case SynthesizeStyle:
                _editView = [BaseEditView new];
                break;
            case TextStyle:
                _editView = [EditDemoView new];
                break;
            case PickerStyle:
                _editView = [PickerDemoView new];
                break;
            case SelectStyle:
                _editView = [SelectDemoView new];
                break;
            default:
                _editView = [BaseEditView new];
                break;
        }
        
    }
    return _editView;
}


-(void)subAction
{
    NSLog([NSString stringWithFormat:@"%@",[self.editView headerDic]]);
}

-(UIButton *)subBtn
{
    if (!_subBtn)
    {
        UIButton *btn = [UIButton new];
        
        [btn setTitle:@" 提交 " forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderWidth = 2;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        _subBtn = btn;

    }
    return _subBtn;
}


@end
