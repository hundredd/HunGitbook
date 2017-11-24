//
//  HPictureView.h
//  QHZC
//
//  Created by hundred on 2017/4/29.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSDetailPhotoModel.h"//订单详情模型
#import "HPictureView.h"

//为了避免和原来不兼容,重新定义一个可以来操作row的view!


@interface HMutiPictureView : UIView

@property(nonatomic,weak)id<HPictureViewDelegate> delegate;

@property(nonatomic,assign)NSInteger maxNum;

@property(nonatomic,strong)NSNumber *row ;//当前使用row,默认是4
//只有设置了vc才可以弹出图片浏览器
-(void)setViewController:(UIViewController *)viewController;


-(NSArray<UIImageView *> *)getPictures;

-(void)setStyle:(HPictureStyle)style;

//传入图片数组
-(void)setShowImgArr:(NSArray<UIImage *> *)imgArr;
//传入图片URL数组,直接做加载
-(void)setShowImgUrlArr:(NSArray<NSString *> *)imgUrlArr;

//传入pdf的Url
-(void)setShowPdfUrlArr:(NSArray<NSString *> *)pdfUrlArr;

//传入pdf的model
-(void)setShowUrlModelArr:(NSArray<WSDetailPhotoModel *> *)pdfUrlModelArr;

//传入订单的详情数据!
-(void)setShowDetailPhotoArr:(NSArray<WSDetailPhotoModel *> *)detailModelArr;

@end
