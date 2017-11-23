//
//  HFormMarco.h
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

//参数配置!
#ifndef HFormMarco_h
#define HFormMarco_h

#define HFormTitleRate 0.3

#define kScreenSize           [[UIScreen mainScreen] bounds].size                 //(e.g. 320,480)
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height          //包含状态bar的高度(e.g. 480)

#define kApplicationSize      [[UIScreen mainScreen] applicationFrame].size       //(e.g. 320,460)
#define kApplicationWidth     [[UIScreen mainScreen] applicationFrame].size.width //(e.g. 320)
#define kApplicationHeight    [[UIScreen mainScreen] applicationFrame].size.height//不包含状态bar的高度(e.g. 460)
#define kSystemVesion         [[[UIDevice currentDevice] systemVersion] floatValue]
#define STRONG_SELF         __strong __typeof(self) strongSelf = weakSelf;
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)

#define NUM       @"0123456789"
#define ALPHA     @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM  @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define OTHER     @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"
#define EMAIL     @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-@."

// 输入限制检查
#define kLoginNameMaxLength     30   // 登录名长度
#define kRealNameMaxLength  30       // 姓名最大长度
#define kIdCardMaxLength    18       // 证件号最大长度
#define kIdTypeMaxLength    20       // 证件类型最大长度
#define kPhoneNoMaxLength   11       // 手机号最大长度
#define kSmsOTPMaxInputLength 6      // 短信验证码最大长度
#define kImageOTPMaxInputLength 4    // 图形验证码最大长度
#define kBankCardMinLength 16        // 银行卡号最小长度
#define kBankCardMaxLength 19        // 银行卡号最大长度
#define kPasswordMinLength 6
#define kPasswordMaxLength 20
#define kPasswordRegexString  @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"

// time marco
#define smsTimeout       10  // 短信超时
#define waitTimeout      9
#define showCancleTime   5


#define APP_KEYWINDOW         [[UIApplication sharedApplication] keyWindow]

#define kImageOTPMaxInputLength 4    // 图形验证码最大长度

#define kIOSVersions [[[UIDevice currentDevice] systemVersion] floatValue] //获得iOS版本

#define UIColorFromHexValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBValue(R,G,B)    [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define UIColorFromRGBAValue(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define navBarOrigin (kIOSVersions>=7.0?64:44)

#pragma mark- UIDevice size
//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define IS_SCREEN_4_INCH    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_35_INCH    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),  [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_47_INCH   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_55_INCH   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define DiffHeight (IS_SCREEN_4_INCH ? 88 : 0) //(1136-960)/2

#define isPad ([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location != NSNotFound)
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)


#define KWidth(width) (IS_SCREEN_4_INCH ? (width * (CGFloat)320 / 375):(IS_SCREEN_47_INCH ? (width):(width *(CGFloat)414 / 375)))
#define KHeight(height)  (IS_SCREEN_4_INCH ? (height * (CGFloat)568 / 667):(IS_SCREEN_47_INCH ? (height):(height *(CGFloat)736 / 667)))

#define WEAK_SELF           __weak __typeof(self) weakSelf = self;
#define HModuleTitleLeft KWidth(18) //标题向左边的边距

#define HSmallVerticalMagin    KHeight(5) //默认上下间距
#define HSmallHorizontalMagin  KWidth(5)  //默认左右间距
#define HCommonVerticalMagin    KHeight(10) //默认上下间距
#define HCommonHorizontalMagin  KWidth(10)  //默认左右间距
#define HBigHorizontalMagin  KWidth(20)  //默认左右间距

#define UIColorFromHexAValue(rgbValue,A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:A]
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
#define HMiddleImgHW            12           //默认编辑框的图片宽高
#define HSmallImgHW             7           //默认编辑框的图片宽高
#define assistFontSize       14


#define titleFontSize        18
#define textFontSize         15
#define assistFontSize       14
#define remarkFontSize       10
#define keyboardNumFontSize  24
#define keyboardLetterFontSize 20

#define hMaginRate  0.9     //间距的比例

#define FONT(size)                          ([UIFont systemFontOfSize:size])

#define kThemeColor      UIColorFromHexValue(0xF3F4F8) // APP主题色
#define kSingleLineColor UIColorFromHexValue(0xe1e4f1)
#define kAlertColor      UIColorFromHexValue(0xea3f4b) // 手势错误,警告红色
#define kAssistColor     UIColorFromHexValue(0xc6c6c6) // 辅助字体色
#define kLinkedColor      UIColorFromHexValue(0x40506c) // 键盘字体颜色
#define kOrangeColor     UIColorFromHexValue(0xf17825) // 收益率橙色
#define kNormalTextColor UIColorFromHexAValue(HGGrayFontColorX,0.8) // 标准字体颜色
#define klineColor          UIColorFromHexValue(0xe5e5e5)
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

//设置字体大小,需要字库
#define UIFontSizeWithName(foneName,size1) [UIFont fontWithName:foneName size:size1]

//默认采用regular的字体!
#define UIFontSizeWithDefault(size1) [UIFont fontWithName:hFontStyleRegular size:size1]

#endif /* HFormMarco_h */
