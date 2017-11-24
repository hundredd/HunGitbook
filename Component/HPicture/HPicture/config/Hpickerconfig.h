//
//  Hpickerconfig.h
//  Demo
//
//  Created by hun on 2017/11/24.
//  Copyright © 2017年 hun. All rights reserved.
//

#ifndef Hpickerconfig_h
#define Hpickerconfig_h

#define WEAK_SELF           __weak __typeof(self) weakSelf = self;
#define QHDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

#define kWhiteTextColor [UIColor whiteColor]
#define hWhiteTextColor [UIColor whiteColor]
#define hBlackFontColor [UIColor blackColor]
#define hLightBlackGrayColor [UIColor grayColor]
#define hBlueTextColor [UIColor blueColor]
#define hDefaultBlackFontColor [UIColor blackColor]
#define kButtonNormalColor [UIColor blueColor]

#define hDetailFontColor [UIColor grayColor]
#define kBackgroundColor [UIColor whiteColor]

#define IS_IPHONE_5 1
#define assistFontSize 12
#define hSmallFont 10
#define hNomalFont 15
#define HCommonVerticalMagin 10
#define HCommonHorizontalMagin 10

#endif /* Hpickerconfig_h */
