//
//  EditActivityHeaderView.m
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//
/*
#import "EditActivityHeaderView.h"
#import "HAddEditManager.h"
#import "HFormManager.h"
@interface EditActivityHeaderView()<HFormManagerDataSource>

@property(nonatomic,strong)HFormManager *managerV ;//管理页面

@end

@implementation EditActivityHeaderView

#pragma mark - public

-(NSDictionary *)headerDic
{
    if (_managerV) {
        return [_managerV queryDic];
    }
    return @{};
}


-(void)setModel:(EditActivityModel *)model
{
    _model = model;
    //设置模型!,填充数据!
    
}


#pragma mark - private
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        [self mockData];
    }
    return self;
}

-(void)mockData
{
    NSArray *arr = @[
                     @{hfkey(@"single"),@"selectedIndex":@1},
                     @{hfkey(@"mutiple"),@"selectedArr":@[@1,@2]},
                                       
                                       ] ;
    self.managerV.dataArr = [HFormModel transferFromDicArr:arr];
}

-(void)setupUI
{
    [self.managerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


#pragma mark - getter

-(HFormManager *)managerV
{
    if (!_managerV)
    {
        _managerV = [HFormManager new];
        _managerV.datasource  = self;
        [self addSubview:_managerV];
    }
    return _managerV;
}

#pragma mark - datasource
-(NSArray<HFormOriginModel *> *)editDatasoureWithManager:(HFormManager *)manager
{
    NSArray *arr = @[
                     HFormNoralPlaceSin(@"投资金额",0,@"请输入金额",@"address",self,@"元"),
                     @{hftitle(@"投资金额"),hfstyle(0),hfplaceHolder(@"请输入金额"),hfkey(@"address"),hfsingle(@"元")},
                     @{hftitle(@"单选"),hfstyle(SelectHFormStyle),@"selectedArr":@[@"男",@"女"],hfkey(@"single")},
                     @{hftitle(@"多选"),hfstyle(MutiSelectHFormStyle),@"selectedArr":@[@"男",@"女",@"中"],hfkey(@"mutiple")},
                     @{hftitle(@"日期"),hfstyle(DateHFormStyle),hfkey(@"date")},
                     @{hftitle(@"分钟"),hfstyle(DateMinHFormStyle),hfleftkey(@"hdate"),hfright(@"htime")},
                     
                     @{@"title":@"投资金额",@"style":@0,@"placeHolder":@"请输入金额",@"key":@"money",
                       @"delegate":self,@"single":@"元"},
                     @{@"title":@"年化收益率",@"style":@0,@"placeHolder":@"请输入年化收益率",@"key":@"rate",
                       @"delegate":self,@"single":@"%"},
                     @{@"title":@"投资天数",@"style":@0,@"placeHolder":@"请输入天数",@"key":@"days",
                       @"delegate":self,@"single":@"元"},
//                     @{@"title":@"基本天数",@"style":@4,@"selectedArr":@[@"360天",@"365天"],@"key":@"customStyle"},//客户类型 选择框
                     ];
    
    return [HFormOriginModel transferFromDicArr:arr];
}


@end
*/
