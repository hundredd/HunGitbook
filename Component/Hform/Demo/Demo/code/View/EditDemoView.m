//
//  EditDemoView.m
//  Demo
//
//  Created by hun on 2017/11/23.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "EditDemoView.h"

@implementation EditDemoView

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
                     //新增部分
                     HFormNoralPlaceMaxDele(@"控制长度",NumTextFieldHFormStyle, @"请输入联系电话", @"legalMobileNo",@11,self),//联系电话
                     HFormNoralPlaceDele(@"数字键盘",NumTextFieldHFormStyle, @"请输入注册地址", @"postAddress",self),//注册地址
                     HFormNoralPlaceDele(@"数字键盘带点",NumTextFieldDocHFormStyle, @"请输入电子邮箱", @"legalEmail",self),//输入邮箱
                     HFormNoralPlaceDele(@"正常键盘",NomalTextFieldHFormStyle, @"请输入电子邮箱", @"legalEmail",self),//输入邮箱
                     
                     ];
    
    return [HFormOriginModel transferFromDicArr:arr];
}
@end
