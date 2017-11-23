//
//  HFormSelectUnit.h
//  QHZC
//
//  Created by hun on 2017/10/13.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFormSelectUnit : UIView

@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)BOOL isHighLightTitle;
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,copy)void (^addSelectUnitOnclick)(HFormSelectUnit *selectedItem) ;//点击事件


/**
 创建示范多选操作

 @param isMuti 创建是否多选
 @return
 */
- (instancetype)initWithIsMuti:(BOOL)isMuti;
@end
