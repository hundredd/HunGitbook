//
//  HFormManager.h
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFormOriginModel.h"
#import "HFormBaseItem.h"
@class HFormManager;
@protocol HFormManagerDataSource <NSObject>
@required

/**
 数据源
 
 @param manager 获取的manager的控件
 @return 数据源
 */
-(NSArray<HFormOriginModel *> *)editDatasoureWithManager:(HFormManager *)manager;


@end

@interface HFormManager : UIView

@property(nonatomic,weak)id<HFormManagerDataSource> datasource;

//设置空间的初始化的值!
@property(nonatomic,strong)NSArray<HFormModel *> *dataArr;


@property(nonatomic,strong,readonly)NSArray<HFormBaseItem *> *itemsArr;

/** 设置数据 */
-(void)setDataArr:(NSArray<HFormModel *> *)dataArr;

-(NSDictionary *)queryDic;

//layout时候添加底部
-(HFormBaseItem *)itemForKey:(NSString *)key;



//从新渲染数据源
-(void)resetOriginArr:(NSArray<HFormOriginModel *> *)resetOriginArr;


@end
