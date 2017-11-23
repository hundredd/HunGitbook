//
//  HFormOriginModel.h
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFormModule.h"

typedef NS_ENUM(NSUInteger, HFormStyle) {
    NomalTextFieldHFormStyle = 0 ,   //0 输入框!
    NumTextFieldHFormStyle ,         //1 数字输入框
    NumTextFieldDocHFormStyle ,      //2 数字输入框,带点
    PickerHFormStyle,                //3 选择数据!
    AddressHFormStyle,               //10 地址选择器
    DateHFormStyle,                  //4 这个是选择有效期区间段!
    DateMinHFormStyle,               //7 这个主要是左边是日期,右边是时间
    DoubleDateHFormStyle,            //4 主要是时间的左右两段!
    SelectHFormStyle,                //5 这个是获取选择项目!,需要单独配置selected选项
    MutiSelectHFormStyle,            //6 多选配置
    ButtonHFormStyle,                //8 按钮事件(整个item都是button) ,里面有一个布尔值可以做时间选择!
    ShowHFormStyle,                  //9 纯粹的展示!可以显示高亮!
    AutoShowHFormStyle,                //13 动态控制detail,如果没值就不显示
    SolidTelHFormStyle,              //11 电话,传真两项
    ButtonEditHFormStyle,            //12 按钮和编辑同时实现,与6做区分!,主要在份额转换赎回时候用的
    
};


@interface HFormOriginModel : NSObject

@property(nonatomic,assign)HFormStyle style;      //种类            //必填项目!,其他选填
@property(nonatomic,copy)NSString *title;         //标题
@property(nonatomic,copy)NSString *placeHolder;   //默认选项
@property(nonatomic,copy)NSString *value;         //默认的值
@property(nonatomic,copy)NSString *key;           //key唯一标识符
@property(nonatomic,assign)NSInteger maxNum;        //最大输入长度
@property(nonatomic,strong)NSArray<NSString *> *selectedArr; //可以选的内容
@property(nonatomic,copy)NSString *remark;        //添加备注项,主要是可以编辑项目,如果编辑此项目,不能显示img
@property(nonatomic,weak)id delegate;               //代理对象
@property(nonatomic,strong)NSNumber *maxNumStr ;    //最大title换行字符数目 //默认为25
@property(nonatomic,strong)NSNumber *maxNumLine ;   //最大title换行数目
@property(nonatomic,copy)NSString *remarkImg;       //备注按钮的图片,如果不写方法就当图片

@property(nonatomic,assign)BOOL isForBidden ;//是否允许禁止操作!


//
@property(nonatomic,strong)NSNumber *leftRightRate ;//左右宽度比率,主要是针对有左右两侧的picker
//如果是可选择的
@property(nonatomic,assign)BOOL isDefalutSelected;     //需要默认选项!,默认不需要选项!
//style ==SelectStyle ,默认选中项
@property(nonatomic,strong)NSNumber *selectedIndex; //默认选中的值

//如果是时间类型的
@property(nonatomic,copy)NSString *keyTime1;
@property(nonatomic,copy)NSString *keyTime2;
@property(nonatomic,copy)NSString *startTime;     //开始时间
@property(nonatomic,copy)NSString *endTime;       //结束时间
@property(nonatomic,assign)BOOL isRightLongTerm ;//是否长期选择


//如果是按钮类型的
@property(nonatomic,assign)BOOL isHideRightBtn;//隐藏右边的图片
@property(nonatomic,assign)BOOL isRightBtn;
@property(nonatomic,assign)BOOL isDateBtn;
@property(nonatomic,strong)NSArray<NSString *> *pickerArr;
@property(nonatomic,copy)NSString *pickerTitle;
@property(nonatomic,copy)NSString *rightBtnTitle;   //右边的按钮,不是全局的

//如果是展示类的话,有可能有符号
@property(nonatomic,copy)NSString *single;        //符号
@property(nonatomic,assign)BOOL isHighLight ;//是否高亮



//如果是solid类型的
@property(nonatomic,copy)NSString *leftKey;         //左边key
@property(nonatomic,copy)NSString *rightKey;         //右边key
@property(nonatomic,copy)NSString *leftValue;        //左边值
@property(nonatomic,copy)NSString *rightValue;       //右边值


+(NSArray<HFormOriginModel *> *)transferFromDicArr:(NSArray<NSDictionary *> *)dicArr;

@end
