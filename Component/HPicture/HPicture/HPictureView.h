//
//  HPictureView.h
//  QHZC
//
//  Created by hundred on 2017/4/29.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSDetailPhotoModel.h"//订单详情模型

typedef NS_ENUM(NSUInteger, HPictureStyle) {
    NomalPictureStyle = 0,     //正常模式 A.直接添加编辑,B.可以传入图片并展示编辑
    ShowPictureStyle,          //只可以看,不可以编辑
    AddOnlyPictureStyle,          //可以操作,但是不能删除
};


typedef NS_ENUM(NSUInteger, ActionStyle) {
    JustShow = 0,       //展示的时候的图片项
    AddAction,          //添加操作的时候的图片项
    CancelAction,             //删除操作时候剩余的图片项
};

@protocol HPictureViewDelegate <NSObject>

@optional
//单个采用以下的方法
//删除部分
-(void)cancelAction:(UIImageView *)img andIndex:(NSInteger)index;

//这个可以计算每次计算后最新的图片数目
-(void)finishSelectedActionWithArr:(NSArray<UIImageView *> *)imgVArr andActionStyle:(ActionStyle)style;

//这个单独获取添加图片的数目!
-(void)addAction:(NSArray<UIImageView *> *)imgVArr;

//多个的需要带上tag
//删除部分
-(void)cancelAction:(UIImageView *)img andIndex:(NSInteger)index andTag:(NSInteger)tag;

//这个可以计算每次计算后最新的图片数目
-(void)finishSelectedActionWithArr:(NSArray<UIImageView *> *)imgVArr andActionStyle:(ActionStyle)style andTag:(NSInteger)tag;

//这个单独获取添加图片的数目!
-(void)addAction:(NSArray<UIImageView *> *)imgVArr andTag:(NSInteger)tag;

//压缩视频的进度! 要做两件事,判断进度大小,还有就是判断是否没有进行压缩操作!
-(void)compressVideoProgress:(float)progress;
//添加视频
-(void)addVideo:(NSData *)data andTag:(NSInteger)tag;
//删除视频
-(void)cancelVideo:(NSString *)ReadKey andIndex:(NSInteger)index andTag:(NSInteger)tag;

@end


@interface HPictureView : UIView

@property(nonatomic,weak)id<HPictureViewDelegate> delegate;

@property(nonatomic,assign)NSInteger maxNum;


//设置显示选择录像的功能!
-(void)showVideo;
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

//传入视频的Url
-(void)setShowVideoUrlArr:(NSArray<NSString *> *)videoUrlArr;

//传入视频的model
-(void)setShowVideoModelArr:(NSArray<WSDetailPhotoModel *> *)videoUrlModelArr;

//传入pdf的model
-(void)setShowUrlModelArr:(NSArray<WSDetailPhotoModel *> *)pdfUrlModelArr;

//传入订单的详情数据!
-(void)setShowDetailPhotoArr:(NSArray<WSDetailPhotoModel *> *)detailModelArr;

@end
