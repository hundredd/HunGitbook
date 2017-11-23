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
                     @{hfkey(@"gender"),hftitle(@"性别"),hfstyle(SelectHFormStyle),@"selectedArr":@[@"男",@"女"],hfDelegate(self)},//客户性别
                     @{hfkey(@"birthday"),hftitle(@"出生年月"),hfstyle(DateHFormStyle),@"isDateBtn":@1,hfDelegate(self),hfvalue(@"2010-10-10")},//出生年月
                     HFormNoralPlaceMaxDele(@"联系电话",NumTextFieldHFormStyle, @"请输入联系电话", @"mobileNo",@11,self),//联系电话
                     HFormNoralPlaceDele(@"电子邮箱",NomalTextFieldHFormStyle, @"请输入电子邮箱", @"email",self),//输入邮箱
                     @{hftitle(@"纳税居民"),hfstyle(SelectHFormStyle),hfkey(@"flagRatepayingResident"),hfDelegate(self),@"selectedArr":[ESDomain EJudgeNomal],@"remarkImg":@"common_question"},//是否为纳税居民
                     @{hftitle(@"职业"),hfstyle(PickerHFormStyle),hfpickerHoldTitle(@"请选择职业"),hfkey(@"employerOccupation"),hfDelegate(self),@"pickerArr":[ESDomain EPOccupationOps]},//选择职业
                     @{hftitle(@"职务"),hfstyle(PickerHFormStyle),hfpickerHoldTitle(@"请选择职务"),hfkey(@"employerDuty"),hfDelegate(self),@"pickerArr":[ESDomain EPDutyOps],hfRemark(@"选填")},//选择职务
                     ];
    
    return [HFormOriginModel transferFromDicArr:arr];
}


@end
