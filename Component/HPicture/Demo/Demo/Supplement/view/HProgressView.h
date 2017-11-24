//
//  HProgressView.h
//  QHZC
//
//  Created by hun on 2017/11/16.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HProgressView : UIView


//设置进度!
-(void)setProcess:(float)process;

@end


@interface HProgressItem : UIView

@property(nonatomic,assign)float process ;//进度情况!

@property(nonatomic,copy)void (^finishHide)(void) ;//隐藏的block

@end
