//
//  PickerDemoView.m
//  Demo
//
//  Created by hun on 2017/11/23.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "PickerDemoView.h"

@implementation PickerDemoView

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
                     //投资者部分
                     @{hftitle(@"普通选择"),
                       hfstyle(PickerHFormStyle),
                       hfpickerHoldTitle(@"请选择客户类型"),
                       hfkey(@"orgType"),
                       hfDelegate(self),
                       @"pickerArr":@[@"客户类型1",@"客户类型2",@"客户类型3"]},//客户类型
                     @{hftitle(@"普通选择"),
                       hfstyle(PickerHFormStyle),
                       hfpickerHoldTitle(@"请选择证件类型"),
                       hfkey(@"legalPersonIdType"),
                       hfDelegate(self),
                       @"pickerArr":@[@"身份证1",@"身份证2",@"身份证3"],hfvalue(@"身份证")},//客户类型
                     HFormDateDDelL(@"有效时间段",DoubleDateHFormStyle, @"请选择有效期", @"legalPersonIdStartdate",@"legalPersonIdDuedate",self,YES),
                     @{hftitle(@"日期时间"),hfstyle(DateMinHFormStyle),hfleftkey(@"hdate"),hfright(@"htime")},
                     @{hftitle(@"日期"),hfstyle(DateHFormStyle),hfkey(@"date")},
                     @{hftitle(@"地址"),hfstyle(AddressHFormStyle),hfkey(@"address")},
                     ];
    
    return [HFormOriginModel transferFromDicArr:arr];
}

@end
