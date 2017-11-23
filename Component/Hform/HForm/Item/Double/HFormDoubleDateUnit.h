//
//  HFormDoubleDateItem.h
//  QHZC
//
//  Created by hun on 2017/10/31.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFormDoubleDateUnit : UIView

@property(nonatomic,copy)NSString *leftValue;
@property(nonatomic,copy)NSString *rightValue;

@property(nonatomic,assign)BOOL isRightLongTerm ;//是否长期选择

@property(nonatomic,copy)void (^timeSelectAction)();

@property(nonatomic,copy)void (^finishSelected)(NSString *leftValue,NSString *righthValue);

@end
