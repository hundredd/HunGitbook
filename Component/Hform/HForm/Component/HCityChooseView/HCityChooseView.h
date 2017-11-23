//
//  LSCityChooseView.h
//  LSCityChoose
//
//  Created by hundred on 26/04/2017.
//  Copyright © 2017 hundred. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedHandle)(NSString * province, NSString * city, NSString * area);

@interface HCityChooseView : UIView

@property(nonatomic, copy) SelectedHandle selectedBlock;

@end
