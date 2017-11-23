//
//  HFormModel.m
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormModel.h"
#import "MJExtension.h"
@implementation HFormModel


+(NSArray<HFormModel *> *)transferFromDicArr:(NSArray<NSDictionary *> *)dicArr
{
    NSMutableArray *tmpArr = [@[] mutableCopy];
    for (NSDictionary *dic in dicArr) {
        HFormModel *model = [HFormModel mj_objectWithKeyValues:dic];
        //            NSLog(@"打印传入的数据:%@",model);
        [tmpArr addObject:model];
    }
    return tmpArr;
}

@end
