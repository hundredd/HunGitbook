//
//  HFormModel.h
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFormModel : NSObject

@property(nonatomic,copy)NSString *detail;    //内容
@property(nonatomic,copy)NSString *detail2;   //图片左边的文字 有点忘记了
@property(nonatomic,strong)NSMutableAttributedString *detail2Attr ;//详情的艺术字
@property(nonatomic,copy)NSString *imgDetail; //图片左边的文字 cell的时候可以用
@property(nonatomic,copy)NSString *key;       //这是key的设置!,作为一个匹配!
@property(nonatomic,strong)id model;          //通过这个model,进行取值和对比值操作 5-19添加

@property(nonatomic,assign)BOOL isForBidden ;//是否允许禁止操作!

@property(nonatomic,strong)NSNumber *selectedIndex ;//选择的下标选项!针对选项
@property(nonatomic,strong)NSArray<NSNumber *> *selectedArr ;//多选选项的数据

//针对有左右两边的控件设计
@property(nonatomic,copy)NSString *leftValue;     //左边内容
@property(nonatomic,copy)NSString *rightValue;    //右边内容
//特殊 => picker选择器的选项值
@property(nonatomic,strong)NSArray<NSString *> *pickData ;//可以刷新控件自身的picker,因为每次是独立生成的!

+(NSArray<HFormModel *> *)transferFromDicArr:(NSArray<NSDictionary *> *)dicArr;

@end
