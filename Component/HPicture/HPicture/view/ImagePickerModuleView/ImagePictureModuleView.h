//
//  ImagePickerModuleView.h
//  QHZC
//
//  Created by hundred on 2017/5/15.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "BaseInfoView.h"
#import "HPictureView.h"
#import "WSPhotoModel.h"
#import "WSDetailPhotoModel.h"

@interface ImagePictureModuleView : BaseInfoView

//只有设置了vc才可以弹出图片浏览器
-(void)setViewController:(UIViewController *)viewController;

/**
 设置pick最大的选择数目,如果不设置默认为4个!

 @param maxNum 最大的数目,每行都是4个图片
 */
-(void)setPickerMaxNum:(NSInteger)maxNum;


-(void)setShowImgArr:(NSArray<UIImage *> *)imgArr;

-(void)setShowImgUrlArr:(NSArray<NSString *> *)imgUrlArr;

//这是直接获取的网络数据!
-(void)setShowFileModelArr:(NSArray<FileModel *> *)fileModelArr;
//这是重新刷新数据
-(void)resetShowFileModelArr:(NSArray<FileModel *> *)fileModelArr;

//主要是展示pdf的
-(void)setPdfUrlArr:(NSArray<NSString *> *)pdfUrlArr;

-(void)setShowDetailPhotoArr:(NSArray<WSDetailPhotoModel *> *)detailModelArr;

-(void)setPickerShowStyle;

//设置运营岗类型!
-(void)setOperationAction;

@property(nonatomic,strong)WSPhotoModel *model ;//  设置模型的是进行编辑

//获取目前布局的pdf和图片的readKey列表;
-(NSArray<NSString *> *)pdfReadKeys;
-(NSArray<NSString *> *)imgReadKeys;

@end
