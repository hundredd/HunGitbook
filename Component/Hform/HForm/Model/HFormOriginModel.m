//
//  HFormOriginModel.m
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormOriginModel.h"
#import "MJExtension.h"
@implementation HFormOriginModel

+(NSArray<HFormOriginModel *> *)transferFromDicArr:(NSArray<NSDictionary *> *)dicArr
{
    NSMutableArray *tmpArr = [@[] mutableCopy];
    for (NSDictionary *dic in dicArr) {
        HFormOriginModel *model = [HFormOriginModel mj_objectWithKeyValues:dic];
        //            NSLog(@"打印传入的数据:%@",model);
        [tmpArr addObject:model];
    }
    return tmpArr;
}

@end
