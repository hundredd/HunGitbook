//
//  TargetViewController.h
//  Demo
//
//  Created by hun on 2017/11/23.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "BaseScrollViewController.h"

typedef NS_ENUM(NSUInteger, Targetstyle) {
    SynthesizeStyle = 0,    //综合
    TextStyle,              //填充表单
    PickerStyle,            //选择器表单
    SelectStyle,            //选择表单
};

@interface TargetViewController : BaseScrollViewController

@property(nonatomic,assign)Targetstyle style ;//默认采用综合!

@end
