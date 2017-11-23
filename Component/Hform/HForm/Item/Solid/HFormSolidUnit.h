//
//  HFormSolidUnit.h
//  QHZC
//
//  Created by hun on 2017/10/31.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFormSolidUnit : UIView

@property(nonatomic,copy)NSString *leftValue;
@property(nonatomic,copy)NSString *rightValue;

@property(nonatomic,copy)void (^editAction)();



@end
