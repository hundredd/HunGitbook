//
//  HPictureItem.h
//  QHZC
//
//  Created by hundred on 2017/5/22.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HPictureItemDelegate <NSObject>

-(void)cancelImgActionWithTag:(NSInteger)index;

@end


@interface HPictureItem : UIButton

@property(nonatomic,weak)id<HPictureItemDelegate> delegate;

@property(nonatomic,strong)UIImageView *imgV;

-(void)setCancelHidden;

@end
