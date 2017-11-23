//
//  HFormBaseItem.h
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFormOriginModel.h"
#import "HFormModel.h"
@class HFormBaseItem;

@protocol HFormBaseItemDelegate <NSObject>

@optional


//点击禁用按钮的操作
-(void)addEditItemForBidClickWithView:(HFormBaseItem *)item;
/**
 需要用到tag的按钮事件
 */
-(void)addEditItemOnClickWithView:(HFormBaseItem *)item;

/**
 //备注项目点击事件
 */
-(void)addEditItemOnClickRemarkActionWithView:(HFormBaseItem *)item;


/**
 编辑框事件
 
 @param item 编辑对象item
 @param value 变化的值!
 */
-(void)editTextDidChangeWithView:(HFormBaseItem *)item andValue:(NSString *)value;

/**
 开始编辑事件!
 
 @param item 编辑对象item
 */
-(void)editTextBeginWithView:(HFormBaseItem *)item;

/**
 左右填充控件的数据,主要是时间回填的数据
 */
-(void)addEditItemFinshSelectedWithView:(HFormBaseItem *)item andLeftValue:(NSString *)leftValue andRightValue:(NSString *)rightValue;


/**
 主要是选择器选中的地址
 style = address的时候的代理
 
 @param province 省份
 @param city 城市
 @param area 区域
 */
-(void)selectedCityWithProvince:(NSString *)province andCity:(NSString *)city andArea:(NSString *)area;

@end

@interface HFormBaseItem : UIView

@property(nonatomic,strong)HFormOriginModel *originModel ;//初始化的模型!

@property(nonatomic,strong)HFormModel *model ;//填充的数据!

@property(nonatomic,assign)HFormStyle style;

@property(nonatomic,copy)NSString *value;//获取value值

@property(nonatomic,weak)id<HFormBaseItemDelegate> delegate;
/**
 返回一个数据字典

 @param NSDictionary 对应空间的数据
 @return 键值对
 */
-(NSDictionary *)valueDic;

#pragma mark - ui
@property(nonatomic,strong)UIView *titleV;//标题的容器
@property(nonatomic,strong)UILabel *titleLB;//标题的LB
@property(nonatomic,strong)UIView *forbidenView ;//组织操作蒙版
@property(nonatomic,strong)UIView *RightV;//右边的页面
@property(nonatomic,assign)BOOL isFirstForbiden;   //是否第一次开启蒙版

-(void)updateForbiden:(BOOL)isforbiden;

@end
