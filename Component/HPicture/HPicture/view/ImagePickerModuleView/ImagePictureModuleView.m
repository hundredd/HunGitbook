//
//  ImagePickerModuleView.m
//  QHZC
//
//  Created by hundred on 2017/5/15.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "ImagePictureModuleView.h"


@interface ImagePictureModuleView ()

@property(nonatomic,strong)NSArray<UIImage *> *imgArr;

@property(nonatomic,strong)NSArray<NSString *> *imgUrlArr;

@property(nonatomic,strong)NSArray<NSString *> *pdfUrlArr;//比例差不多

@property(nonatomic,strong)NSArray<WSDetailPhotoModel *> *detailModelArr;

@property(nonatomic,weak)UIViewController *viewController;

@property(nonatomic,strong)NSArray<NSString *> *pdfReadKeys;
@property(nonatomic,strong)NSArray<NSString *> *imgReadKeys;


@end

@implementation ImagePictureModuleView
{
    HPictureView *_pictureVC;
}


#pragma mark - public
-(void)setTag:(NSInteger)tag
{
    [super setTag:tag];
    _pictureVC.tag = tag;
}


-(void)setDelegate:(id<BaseInfoViewDelegate>)delegate
{
    [super setDelegate:delegate];
    _pictureVC.delegate = delegate;
}



-(void)setViewController:(UIViewController *)viewController
{
    _viewController = viewController;
    [_pictureVC setViewController:viewController];
}

-(void)setPickerMaxNum:(NSInteger)maxNum
{
    _pictureVC.maxNum = maxNum;
}


-(void)setShowImgArr:(NSArray<UIImage *> *)imgArr
{
    _imgArr = imgArr;
    [_pictureVC setShowImgArr:imgArr];
}

-(void)setShowImgUrlArr:(NSArray<NSString *> *)imgUrlArr
{
    _imgUrlArr = imgUrlArr;
    [_pictureVC setShowImgUrlArr:imgUrlArr];
}

-(void)setShowFileModelArr:(NSArray<FileModel *> *)fileModelArr
{
    NSMutableArray *urlArr = [@[] mutableCopy];
    for (FileModel *fileModel in fileModelArr)
    {
//        [urlArr addObject:[ConstantOrder imgUrlWithReadkey:fileModel.readKey]];
    }
    [_pictureVC setShowImgUrlArr:urlArr];
}

//这是重新刷新数据
-(void)resetShowFileModelArr:(NSArray<FileModel *> *)fileModelArr
{
    NSMutableArray *urlArr = [@[] mutableCopy];
    for (FileModel *fileModel in fileModelArr)
    {
//        [urlArr addObject:[ConstantOrder imgUrlWithReadkey:fileModel.readKey]];
    }
    [_pictureVC setShowImgUrlArr:urlArr];
}


-(void)setPdfUrlArr:(NSArray<NSString *> *)pdfUrlArr
{
    _pdfUrlArr = pdfUrlArr;
    [_pictureVC setShowPdfUrlArr:pdfUrlArr];
}
-(void)setPdfUrlModelArr:(NSArray<WSDetailPhotoModel *> *)pdfUrlArr
{
    [_pictureVC setShowUrlModelArr:pdfUrlArr];
}
-(void)setVideoUrlModelArr:(NSArray<WSDetailPhotoModel *> *)videoModelArr
{
    [_pictureVC setShowVideoModelArr:videoModelArr];
}



-(void)setShowDetailPhotoArr:(NSArray<WSDetailPhotoModel *> *)detailModelArr
{
    _detailModelArr = detailModelArr;
    [_pictureVC setShowDetailPhotoArr:detailModelArr];
}

-(void)setOperationAction
{
    [_pictureVC setStyle:AddOnlyPictureStyle];
}

-(void)setPickerShowStyle
{
    [_pictureVC setStyle:ShowPictureStyle];
}

-(void)setModel:(WSPhotoModel *)model
{
    _model = model;
    
    
}

#pragma mark - private



- (void)setupCell
{
    if (!_pictureVC) {
        HPictureView *pictureVC = [HPictureView new];
        pictureVC.backgroundColor = [UIColor whiteColor];
        pictureVC.maxNum = 4;
        [self.detailView addSubview:pictureVC];
        _pictureVC = pictureVC;
    }
}

- (void)setupDetailView
{
    WEAK_SELF;
    [_pictureVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.detailView);
        make.left.right.equalTo(weakSelf.detailView);
        make.bottom.equalTo(weakSelf.detailView);
    }];
}

@end
