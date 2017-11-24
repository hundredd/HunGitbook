//
//  PdfShowViewController.h
//  OnlinepdfDemo
//
//  Created by hun on 2017/8/7.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "QHBaseViewController.h"
#import "WSDetailPhotoModel.h"
@interface PdfShowViewController : QHBaseViewController

@property(nonatomic,assign)BOOL isShowLocal ;   //是否展现本地文件

@property(nonatomic,strong)WSDetailPhotoModel *model   ;   //分享模型

@property(nonatomic,copy)NSString *urlStr   ;   //网页连接

//这是针对单独传入url的
-(void)setUrlStr:(NSString *)urlStr FileDic:(NSDictionary *)fileDic;

@property(nonatomic,assign)BOOL isShare ;//判断是否分享,默认不分享

@end
