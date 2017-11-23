//
//  SelectDemoView.m
//  Demo
//
//  Created by hun on 2017/11/23.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "SelectDemoView.h"

@implementation SelectDemoView

-(void)mockData
{
    NSArray *arr = @[
                     @{hfkey(@"single"),@"selectedIndex":@1},
                     @{hfkey(@"mutiple"),@"selectedArr":@[@1,@2]},
                     
                     ] ;
    self.managerV.dataArr = [HFormModel transferFromDicArr:arr];
}


#pragma mark - datasource
-(NSArray<HFormOriginModel *> *)editDatasoureWithManager:(HFormManager *)manager
{
    NSArray *arr = @[
                     @{hftitle(@"单选"),hfstyle(SelectHFormStyle),@"selectedArr":@[@"男",@"女"],hfkey(@"single")},
                     @{hftitle(@"多选"),hfstyle(MutiSelectHFormStyle),@"selectedArr":@[@"男",@"女",@"中"],hfkey(@"mutiple")},
                     
                     ];
    
    return [HFormOriginModel transferFromDicArr:arr];
}


@end
