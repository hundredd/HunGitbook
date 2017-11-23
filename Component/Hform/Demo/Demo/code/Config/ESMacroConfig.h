//
//  ESMacroConfig.h
//  QHZC
//
//  Created by hundred on 2017/3/13.
//  Copyright © 2017年 QHJF. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef ESMacroConfig_h
#define ESMacroConfig_h

#pragma mark - common
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define HNotNullDomain(value,single) [ConstantOrder CheckNotNull:[NSString stringWithFormat:@"%@%@",value,single]]
#define HNotNull(value) [ConstantOrder CheckNotNull:value]
#define HStrFromNum(value) [NSString stringWithFormat:@"%@",value]
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#pragma mark - UI相关宏定义

#define H_SCREENWIDTH       [UIScreen mainScreen].bounds.size.width
#define H_SCREENHEIGHT      [UIScreen mainScreen].bounds.size.height
#define H_UI_StatueH        20
#define H_UI_NaviH          44
#define H_UI_TabbarH        98/2
#define H_UI_MarginH        10

//部分常用宏
#define AchiveHeaderViewH 50

#define HVideoType @"mp4"

//顶部的高度
#define H_UI_Top            H_UI_StatueH+H_UI_NaviH-H_UI_MarginH
//去除tabar,status,margin等
#define H_UI_BodyHeight     H_SCREENHEIGHT-H_UI_StatueH-H_UI_NaviH-H_UI_TabbarH

//255以内的随机数
#define crm_random255 arc4random_uniform(255)/255.0




#pragma mark 色调部分
//色调部分
#define H_UI_RandomColor [UIColor colorWithRed:crm_random255 green:crm_random255 blue:crm_random255 alpha:1]
#define UIColorFromHexAValue(rgbValue,A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:A]
//设置字体大小,需要字库
#define UIFontSizeWithName(foneName,size1) [UIFont fontWithName:foneName size:size1]

//默认采用regular的字体!
#define UIFontSizeWithDefault(size1) [UIFont fontWithName:hFontStyleRegular size:size1]



// 按钮颜色
#define hButtonNormalColor    UIColorFromHexValue(0xc2914e)
#define hButtonHighlightColor UIColorFromHexValue(0xaf8143)
#define hMarginNormalColor    UIColorFromHexValue(0xe3e3e3) //magin的颜色
#define hMaginRate  0.9     //间距的比例

#define hBackGroundColor      UIColorFromHexValue(0xF3F4F8) // APP主题色
//#define hNaviColor            UIColorFromHexValue(HGGrayFontColorX) // APP导航栏颜色
#define hNaviColor            UIColorFromHexValue(0x1F9ED5)
#define hStatusColor          UIColorFromHexValue(HGGrayFontColorX) // APP状态栏颜色
#define hTabarColor           UIColorFromHexValue(0xF7F7F7) // APP状态栏颜色

#pragma mark - 字体部分

#pragma mark 字体种类
#define hFontStyleRegular   @"PingFangSC-Regular"       //常规
#define hFontStyleLight     @"PingFangSC-Light"         //高亮
#define hFontStyleThin      @"PingFangSC-Thin"          //细的
#define hFontStyleNum       @"PingFangSC-Medium"        //数字

#pragma mark 字体颜色

//色值
#define HGGrayFontColorX        0x101829                //原362e2b,这是灰色带透明度的颜色
#define HGLightGrayFontColorX   0x1b2741                //原59493f,浅色调
#define HGHighLightFontColorX   0xff8500                //原ff8500,橙色颜色
#define HGWhiteFontColorX       0xffffff                //白色调
#define HGBlueFontColorX        0x009fc9                //蓝色调
#define HGRedFontColorX         0xf4333c                //红色调
#define HGDeepBlueFontColorX    0x078cbd                //深色蓝色调
#define HGBtnBlueFontColorX     0x009fd9                //按钮深色蓝色调
#define HGMaginColor            0xefefef                //magin的颜色
#define HGBtnYellowColor        0xc2914e                //按钮和按钮字体黄色调
#define HGLightGlodColorX          0xf7941d                //金黄色
#define HGTitleGlodColorX          0x59493F                //金黄色
#define HGTitleYellowColorX        0xedd3b3                //普通黄色

#define hChartLeftColor [UIColor redColor]          //对其左边的表格线条颜色
#define hChartRightColor [UIColor greenColor]       //对其右边的表格线条颜色

#define hMaiginColor            UIColorFromHexValue(HGMaginColor);              //magin的颜色
//#define hNaviTitleColor         UIColorFromHexAValue(0xffffff,0.4)            // APP导航栏标签
#define hNaviTitleColor         UIColorFromHexValue(0xffffff)                   // APP导航栏标签
#define hHightLightFontColor    UIColorFromHexValue(0xa6937c)                   // 中黄色高亮文字颜色,场景:title或者特殊字段
#define hDefaultBlackFontColor  UIColorFromHexAValue(HGLightGrayFontColorX,0.8) // 浅色调,场景:大部分cell中的detail
#define hDetailFontColor        UIColorFromHexAValue(HGGrayFontColorX,0.4)      // 浅色调,场景:提示框的颜色
#define hClearColor    [UIColor clearColor]    //透明
#define hForbidenFontColor        UIColorFromHexAValue(HGGrayFontColorX,0.1)      // 浅色调,场景:蒙版,自己定义的
#define hDefaultDetailFontColor  UIColorFromHexAValue(HGGrayFontColorX,0.8)      // 浅色调,场景:提示框的颜色
#define hLightFontColor        UIColorFromHexAValue(HGLightGrayFontColorX,0.4) // 浅色调,场景:大部分cell中的detail
#define hBlackFontColor         UIColorFromHexValue(HGLightGrayFontColorX)      // 默认的黑色字体
#define hWhiteTextColor         UIColorFromHexValue(HGWhiteFontColorX)          //  默认白色
#define hBlueTextColor          UIColorFromHexValue(HGBlueFontColorX)           //  默认蓝色
#define hRedTextColor           UIColorFromHexValue(HGRedFontColorX)            //  默认红色
#define hHighLightTextColor     UIColorFromHexValue(HGHighLightFontColorX)      //  默认橙色,高亮色
#define hHighLightGlodTextColor     UIColorFromHexValue(HGLightGlodColorX)      //高亮黄色

#define hGBtnYellowTextColor     UIColorFromHexValue(HGBtnYellowColor)          //  按钮和按钮字体黄色调
#define hYellowTextColor     UIColorFromHexValue(HGTitleYellowColorX)      //  文字黄色正常

#define hBlueBtnColor          UIColorFromHexValue(HGBtnBlueFontColorX)         //  默认蓝色
#define HNomalBlueBackColor     UIColorFromHexValue(HGBlueFontColorX)           //  正常蓝色背景
#define HHighLightBlueBackColor UIColorFromHexValue(HGDeepBlueFontColorX)       //  深蓝色背景
#define HLightBlueBackColor UIColorFromHexAValue(HGDeepBlueFontColorX,0.05)       // 浅蓝色背景
#define hLightBlackGrayColor  UIColorFromHexAValue(HGLightGrayFontColorX,0.05) // 浅色调,场景:大部分cell中的detail

#pragma mark 字体
#define hBigFont            36 // 大的字体
#define hAniMateFont        26 // 首页动画字体
#define hNaviTitleFont      18 // APP导航栏标签
#define hBarTitleFont       16 // bar的字体大小
#define hNomalTitleFont     15 // 正常的title的高度
#define hNomalFont          14 // 普通文字大小
#define hSmallFont          12 // 小的字体
#define hSmallTinyFont          10 // 小的字体
#define hTinyFont          8 // 小的字体


//QH新字号规范
//内容下一步等按钮的大小: 18
#define HbuttomFontSize        UIFontSizeWithDefault(hNaviTitleFont)    //导航的大小
#define HBarTitleFontSize      UIFontSizeWithDefault(hBarTitleFont)     //常用bar字体大小
#define HTitleFontSize         UIFontSizeWithDefault(hNomalTitleFont)   //常规Title字体大小
#define HNomalFontSize         UIFontSizeWithDefault(hNomalFont)        //常规字体大小
#define HSmallFontSize         UIFontSizeWithDefault(hSmallFont)        //常规字体大小
#define HTinyFontSize         UIFontSizeWithDefault(hTinyFont)        //常规字体大小

//颜色
#define HNomalFontBlueColor         UIColorFromHexValue(HGBlueFontColorX)       //正常的 蓝色 字体颜色
#define HNomalFontWhiteColor        UIColorFromHexValue(HGBlueFontColorX)       //正常的 白色 字体颜色

#define HBarTitleFontWhiteColor     UIColorFromHexAValue(HGWhiteFontColorX,0.7) //barTitleColor 白色,70%


#pragma mark 编辑字体项颜色

#define HFieldPlaceHoldColor    UIColorFromHexValue(0xc6c6c6)               //编辑框待编辑颜色
#define HFieldValueColor        UIColorFromHexAValue(HGGrayFontColorX,0.8)  //编辑框文字颜色
#define HFieldTitleFontColor    UIColorFromHexAValue(HGGrayFontColorX,0.8)  //编辑框标题颜色


#pragma mark - 页面部分设计

#pragma mark conponent(组件)

#define H_SearchHeight      40

#pragma mark 通用
#define HpageCount              10          //每页条数
#define HSmallImgHW             7           //默认编辑框的图片宽高
#define HMiddleImgHW            12           //默认编辑框的图片宽高
#define HNomalArrowHW           15          //通用ios特殊上/下/左右大小
#define HMaginHW             1              //默magin的宽高
#define HSmallVerticalMagin    KHeight(5) //默认上下间距
#define HSmallHorizontalMagin  KWidth(5)  //默认左右间距
#define HCommonVerticalMagin    KHeight(10) //默认上下间距
#define HCommonHorizontalMagin  KWidth(10)  //默认左右间距
#define HBigHorizontalMagin  KWidth(20)  //默认左右间距

#pragma mark - 自己设计控件部分
#define HModuleTitleLeft KWidth(18) //标题向左边的边距



#pragma mark 主页
#define HP_MainScrollH      150
#define HP_MainMenuH        200


#pragma mark 产品


#pragma mark 客户

typedef NS_ENUM(NSUInteger, CustomInfoKindStyle) {
    PersonStyle,        //个人类型
    CompanyStyle,       //公司类型
    DepartmentStyle,    //机构类型
};

#define hWeixinAppKey @"wx5a05c084ef54ce68"     //原来财富理财师wx928bd032cf754371
#define hWeixinAppSecret @"b7d824df44b50479d67e72fed8bf9697"
static NSString *kMessageAction = @"<action>dotalist</action>";
static NSString *kMessageExt = @"私募理财师分享文件";
static NSString *kMessageExtLink = @"私募理财师分享链接";

#pragma mark 我的


#endif /* ESMacroConfig_h */
