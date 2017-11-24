//
//  SupplementViewController.h
//  QHZC
//
//  Created by hundred on 2017/6/2.
//  Copyright © 2017年 QHJF. All rights reserved.
//

//展现目前已经上传的和重新上传!

#import "BaseScrollViewController.h"
#import "WSPhotoModel.h"

typedef NS_ENUM(NSUInteger, SupplementStyle) {
    ShowSuppleStyle = 0,    //只可展示
    EditSuppleStyle,        //判断是否可以编辑
    OperationStyle,         //判断是否运营,只能添加,不能删除!
};

@interface SupplementViewController : BaseScrollViewController

//企业客户号
-(void)setOrgCusNo:(NSString *)orgCusNo;

//个人客户号
-(void)setPersonCusNo:(NSString *)personCusNo;

//用于订单影像,对应的id
@property(nonatomic,strong) NSString *orderNo;

//到期变更影像,变更id
@property(nonatomic,strong) NSString *assoJnlNo;


@property(nonatomic,assign)BOOL isCustPofessor ;//是否专业投资者
@property(nonatomic,assign)SupplementStyle style ;//编辑的种类


@end
