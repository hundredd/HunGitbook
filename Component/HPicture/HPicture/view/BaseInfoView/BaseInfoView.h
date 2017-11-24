//
//  BaseInfoView.h
//  QHZC
//
//  Created by Vincent on 2017/4/19.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BaseInfoView;
@protocol BaseInfoViewDelegate <NSObject>

-(void)baseInfoViewClick:(BaseInfoView *)targetV;

@end

typedef NS_ENUM(NSInteger, ClientType){
    kCompany,
    kOrganization,
    kPerson
};
#define aligementMargin 15 + 80 + 30
@interface BaseInfoView : UIView

@property(nonatomic,weak)id<BaseInfoViewDelegate> delegate;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIView *detailView;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIView *lastView;

@property (nonatomic, assign) ClientType clientType;

- (void)setTitleName:(NSString *)titleName;

- (void)setupCell;

- (void)setupDetailView;

//按钮的名称
-(void)setbtnTitle:(NSString *)btnTitle;
//修改按钮的图片名称
-(void)setbtnImg:(NSString *)btnImg;

/** 修改隐藏按钮 */
-(void)setBtnHideStatus:(BOOL)isHidden;

/** 隐藏顶部view,就等于没有顶部! */
-(void)hideTitleView;

//开启显示红色提示字体
-(void)showWarning;
/**
 自定义btn,主要是自定义文字内容

 @param btnTitle 文字内容
 @return 文字内容
 */
- (instancetype)initWithBtnTitle:(NSString *)btnTitle;

- (instancetype)initWithHideBtn:(BOOL)hideBtn;

@end
