//
//  JXAlertview.h
//  customalert
//
//  Created by jiangxiao on 14-7-8.
//  Copyright (c) 2014年 jiangxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HDateAlertDelegete <NSObject>

-(void)btnindex:(int)index :(int) tag;

@end
@interface HDateAlertview : UIImageView
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *message;
@property(nonatomic,strong)UIButton *cancelbtn;
@property(nonatomic,strong)UIButton *surebtn;
@property(nonatomic,strong)UIButton *centerBtn;
@property (nonatomic,weak) id<HDateAlertDelegete> delegate;
//-(void)dismmis1;

//初始化设置
-(void)initwithtitle:(NSString *)str andmessage:(NSString *)str1 andcancelbtn:(NSString *)cancel andotherbtn:(NSString *)other;

//是否显示中间按钮
-(void)initwithtitle:(NSString *)str andmessage:(NSString *)str1 andcancelbtn:(NSString *)cancel andotherbtn:(NSString *)other andCenterBtn:(BOOL)showCenter;
//显示
-(void)show;
-(void)showview;
-(void)dismmis;
//-(void)dismmis;

@end
