//
//  HVideoItem.h
//  QHZC
//
//  Created by hun on 2017/11/14.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HPictureItem.h"

@interface HVideoItem : HPictureItem

@property(nonatomic,copy)void (^cancelBlock)(void);//删除block



@end
