//
//  HFormEditUnit.h
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFormOriginModel.h"
@class HFormEditUnit;
@protocol HFormEditUnitDelegate <NSObject>

@optional

/**
 按钮事件传输出去
 */
-(void)addEditUnitOnClick;


/**
 需要用到tag的按钮事件
 */
-(void)addEditUnitOnClickWithView:(HFormEditUnit *)targetView;

- (void)addEditUnitTextFieldDidChangedWithView:(HFormEditUnit *)targetView andValue:(NSString *)value;

- (void)addEditUnitTextFieldDidChangedWithValue:(NSString *)value;

- (void)addEditUnitTextFieldDidBegin;

@end

typedef NS_ENUM(NSUInteger, HFormEditUnitStyle) {
    TextFieldNomalHFormEditUnitStyle = 0 ,       //输入框!
    TextFieldNumHFormEditUnitStyle ,             //数字输入框
    TextFieldNumDocHFormEditUnitStyle ,          //数字带点输入框
};


@interface HFormEditUnit : UIView

@property(nonatomic,weak)id<HFormEditUnitDelegate> delegate;
@property(nonatomic,strong)HFormOriginModel *model;       //这个model可以通过这里获取,或者传出去!
@property(nonatomic,copy)NSString *placeholder;
@property(nonatomic,copy)NSString *value;
@property(nonatomic,assign)NSInteger limitNum;  //限制输入最大数
@property(nonatomic,copy)NSString *rightTitle;  //单独设置右边的按钮,设置了名称就会显示
@property(nonatomic,assign)BOOL isRightStyle;  //是否要向右的按钮

@property(nonatomic,assign)BOOL isButtonHide;   //隐藏上层的按钮
@property(nonatomic,assign)BOOL isErrorHide;    //隐藏label的删除键
@property(nonatomic,assign)BOOL isPickShowCenter; //是否显示中间的长期
@property(nonatomic,copy)NSString *single;    //有些编辑需要有单位
//如果是按钮的
@property(nonatomic,assign)BOOL isDate;         //判断是否date,如果不是的话,弹出pick的选择器,如果以后有别的再+数据
@property(nonatomic,strong)NSArray<NSString *> *pickerData; //弹出一个用这个数据的dataPick选择
@property(nonatomic,copy)NSString *pickerTitle; // picker的名称

-(void)setFirstResponder;
//设立设置textfield的内容类型;
- (instancetype)initWithStyle:(HFormEditUnitStyle)style;

-(void)setImageHidden:(BOOL)hidden;

@end
