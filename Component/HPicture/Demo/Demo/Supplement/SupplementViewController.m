//
//  SupplementViewController.m
//  QHZC
//
//  Created by hundred on 2017/6/2.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "SupplementViewController.h"
#import "ImagePictureModuleView.h"
#import "FileModel.h"       //转数据的模型
#import "OnloadModel.h"     //上传的模型!

#import "HProgressView.h"       //进度页面
@interface SupplementViewController ()<HPictureViewDelegate,BaseInfoViewDelegate>

@property(nonatomic,strong)HProgressView *progressV ;//进度条页面

@property(nonatomic,strong)NSArray<FileModel *> *fileModelArr ;//企业和个人的数据

@property(nonatomic,strong)NSMutableArray<WSPhotoModel *> *photoTypes;      //WSPhotoModel

@property(nonatomic,strong)NSMutableArray<ImagePictureModuleView *> *pictureViews ;   //展示图片的view数组


@end

@implementation SupplementViewController
{
    BOOL isCustReadOnly;
    BOOL _isOnloadVideo;//判断是上传图片还是视频!,不一样的处理1
    NSData *_onloadData;//上传的视频
}

#pragma mark - getter

-(HProgressView *)progressV
{
    if (!_progressV) {
        WEAK_SELF;
        // 通知主线程刷新 神马的
        HProgressView *progressV = [HProgressView new];
        [self.view addSubview:progressV];
        
        [progressV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view);
        }];
        _progressV = progressV;
//        dispatch_async(dispatch_get_main_queue(), ^{
//           
//        });
        
    }
    return _progressV;
}


-(NSMutableArray<ImagePictureModuleView *> *)pictureViews
{
    if (!_pictureViews) {
        _pictureViews = [@[] mutableCopy];
    }
    return _pictureViews;
}


-(NSMutableArray<WSPhotoModel *> *)photoTypes
{
    if (!_photoTypes) {
        _photoTypes = [@[] mutableCopy];
    }
    return _photoTypes;
}


#pragma mark - webAction
- (void)viewDidLoad {
    [super viewDidLoad];

}

-(NSArray<FileModel *> *)getImgArrWithType:(NSString *)type andBankNo:(NSString *)bankNo
{
    if (!self.fileModelArr||self.fileModelArr<=0) {
        return @[];
    }
    NSMutableArray *fileModelArr = [@[] mutableCopy];
    for (FileModel *model in self.fileModelArr) {
        //判断是否一致
        if ([model.fileItemType isEqualToString:type])
        {
            if (bankNo)
            {
                if ([bankNo isEqualToString:model.acctNo]) {
                    [fileModelArr addObject:model];
                }
            }else
                [fileModelArr addObject:model];
            
        }
    }
    return fileModelArr;
}

#pragma mark - delegate
#pragma mark info 部分
-(void)baseInfoViewClick:(BaseInfoView *)targetV
{
    
}
#pragma mark - video 部分

-(void)compressVideoProgress:(float)progress
{
    self.progressV.hidden = NO;
    [self.progressV setProcess:progress];
}


//添加视频
-(void)addVideo:(NSData *)data andTag:(NSInteger)tag
{
    
}
//删除视频
-(void)cancelVideo:(NSString *)ReadKey andIndex:(NSInteger)index andTag:(NSInteger)tag
{
    ImagePictureModuleView *pictureV = self.pictureViews[tag];
    
}

#pragma mark picture 部分

#pragma mark - 删除
//删除请求!
-(void)cancelAction:(UIImageView *)img andIndex:(NSInteger)index andTag:(NSInteger)tag
{
    NSLog(@"删除的图片编号%d,还有tag:%d",index,tag);
   
    
    
    
}

#pragma mark - 添加图片!
//这个单独获取添加图片的数目!
-(void)addAction:(NSArray<UIImageView *> *)imgVArr andTag:(NSInteger)tag
{
    ImagePictureModuleView *pictureV = self.pictureViews[tag];
    WSPhotoModel *model = pictureV.model;
    
}


#pragma mark - 页面ui 订单的UI,订单目前需要区分开来!
-(void)setupContentUI
{
    WEAK_SELF;
    ImagePictureModuleView *lastView;
    for (int i = 0; i<10; i++){
        WEAK_SELF;
        WSPhotoModel *model = self.photoTypes[i];
        //这里需要控制一下就是传过去的数据是不是pdf
        ImagePictureModuleView *view = nil;
        //判断是否不展示特定的提示跳转!
        if (i%2)
        {
            view = [[ImagePictureModuleView alloc]initWithHideBtn:YES];
            self.style = ShowSuppleStyle;
        }else
        {
            view = [[ImagePictureModuleView alloc]initWithHideBtn:NO];
            self.style = OperationStyle;
        }
        
        
        if (self.style == ShowSuppleStyle)
        {
            //只做展示!
            [view setPickerShowStyle];
        }else if(self.style == OperationStyle)
        {
            //只能进行添加,不能删除!
            [view setOperationAction];
        }

        
        [view setPickerMaxNum:8];
        [view setViewController:self];
        view.tag = i;
        //随机设计
        view.delegate = self;
        [view setbtnTitle:@"影像示例"];
        [view setModel:model];  //设置模型
        view.backgroundColor = [UIColor clearColor];
        [self.contentV addSubview:view];
        [self.pictureViews addObject:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lastView) {
                make.top.equalTo(weakSelf.contentV);
            }else{
                make.top.equalTo(lastView.mas_bottom);
            }
            make.left.right.equalTo(weakSelf.contentV);
            
            if (i==_photoTypes.count-1) {
                make.bottom.equalTo(weakSelf.contentV);
            }
        }];
        lastView = view;
    }
}

//判断是否在控制范围内!
-(BOOL)checkContainForbidName:(NSString *)name andArr:(NSArray *)arr
{
    for (NSString * tmp in arr)
    {
        if ([name containsString:tmp])
        {
            return YES;
        }
    }
    return NO;
}

-(void)setupContentLayout
{
    
}



@end
