//
//  BaseScrollViewController.h
//  QHZC
//
//  Created by hundred on 2017/5/31.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseScrollViewController : UIViewController

//内容的view
@property(nonatomic,strong)UIView    *contentV;

//重写ui的内容
-(void)setupContentUI;
-(void)setupContentLayout;

@end
