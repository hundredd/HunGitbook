//
//  HPictureView.m
//  QHZC
//
//  Created by hundred on 2017/4/29.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HPictureView.h"
#import "ZZPhotoKit.h"
#import "AppDelegate.h"

#import "YYPhotoGroupView.h"
#import "HPictureItem.h"

//由于需要设置请求头,所以最好独立设置
#import "SDWebImageManager.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
//进行录像操作
#import "HVideoController.h"
#import "HVideoPhotoKitController.h"
#import "TranTool.h"
#import "HPictureView+Video.h"
//pdf展示页面
#import "PdfShowViewController.h"
#import "HplayerVC.h"
#import "HVideoItem.h"

#define HPictureRow 4
#define HPictureMagin 10
#define HPictureItemWH (kScreenWidth-(HPictureRow+1)*HPictureMagin)/(HPictureRow*1.0)
#define HPictureVC [UIApplication sharedApplication].keyWindow.rootViewController
#define HPicturePDFTag 2838
#define HPictureVideoTag 3536
@interface HPictureView ()<ZZBrowserPickerDelegate,HPictureItemDelegate>

@property(strong,nonatomic) UIButton *addBtn;
@property(copy  ,nonatomic) NSArray<ZZPhoto *> *picArray;
@property(nonatomic,strong) NSArray<UIImageView *> *selectedPicArr;
@property(nonatomic,strong) NSArray<UIButton *> *selectedBtns;

@property(nonatomic,strong) NSArray<NSString *> *videosArr;//video的链接组!
@property(nonatomic,strong) NSArray<WSDetailPhotoModel *> *videosModelArr;//video订单传来的模型组
@property(nonatomic,strong) NSArray<UIButton *> *videosBtns;//视频组

@property(nonatomic,strong) NSArray<NSString *> *pdfUrlArr;//pdf的链接组!
@property(nonatomic,strong) NSArray<WSDetailPhotoModel *> *pdfModelArr;//pdf的链接组!
@property(nonatomic,strong) NSArray<UIButton *> *pdfBtns;//pdf的Btns


@property(nonatomic,weak)UIViewController *viewController;
@property(nonatomic,strong)UILabel *spaceLB;//  没值lb

@property(nonatomic,assign)HPictureStyle style;

@property(nonatomic,strong)NSArray<NSString *> *imgUrlArr;
//订单详情
@property(nonatomic,strong)NSArray<WSDetailPhotoModel *> *detailModelArr;
///剩余数目!
@property(nonatomic,assign)NSInteger restNum;


@property(nonatomic,strong)HBaseVideoController *videoManager ;//会自己销毁的

@property(nonatomic,assign)BOOL isVideo ;//判断是否需要选择录像功能!

@end

@implementation HPictureView
{
    float _progress;
}
@synthesize style = _style;
#pragma mark - getter/setter

-(UILabel *)spaceLB
{
    if (!_spaceLB) {
        _spaceLB = [UILabel labelWithText:@"暂无影像" font:hNomalFont textColor:hBlackFontColor backgroundColor:kWhiteTextColor isSizeToFit:YES];
    }
    return _spaceLB;
}

-(HPictureStyle)style
{
    if (!_style)
    {
        return NomalPictureStyle;
    }
    return _style;
}

-(void)setViewController:(UIViewController *)viewController
{
    _viewController = viewController;
}


-(UIButton *)addBtn
{
    if (!_addBtn) {
        UIButton *target = [UIButton new];
        [target setBackgroundImage:[UIImage bundleImgWithName:@"icon_addphoto"] forState:UIControlStateNormal];
        [target setBackgroundImage:[UIImage bundleImgWithName:@"icon_addphoto"] forState:UIControlStateHighlighted];
        [target addTarget:self action:@selector(alertAction) forControlEvents:UIControlEventTouchUpInside];
        _addBtn = target;
    }
    return _addBtn;
}


#pragma mark - 添加控件数组,顺便刷新!
-(void)setPdfBtns:(NSArray<UIButton *> *)pdfBtns
{
    _pdfBtns = pdfBtns;
    //主要为了就是刷新选择的数据!
    [self updatePicView];
}

-(void)setSelectedPicArr:(NSArray<UIImageView *> *)selectedPicArr
{
    _selectedPicArr = selectedPicArr;
    //主要为了就是刷新选择的数据!
    [self updatePicView];
}


-(void)setVideosBtns:(NSArray<UIButton *> *)videosBtns
{
    _videosBtns = videosBtns;
    //主要为了就是刷新选择的数据!
    [self updatePicView];
}


-(void)updatePicView
{
    //清除数据
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    
    NSMutableArray<UIImageView *> *tmpArr = [@[] mutableCopy];
    
    BOOL flagForAdd = NO;
    //把imgV的值提取image出来,然后进行组装
    if (_selectedPicArr.count == _maxNum) {
        [tmpArr addObjectsFromArray:_selectedPicArr];
    }else{
        [tmpArr addObjectsFromArray:_selectedPicArr];
        //可以局部进行编辑(只能添加!)||还有正常编辑,添加删除!
        if (self.style == NomalPictureStyle||self.style == AddOnlyPictureStyle)
        {
            [tmpArr addObject:[[UIImageView alloc]initWithImage:[UIImage bundleImgWithName:@"icon_addphoto"]]];
            //主要是为了判断是不是需要添加ADD和判断是否最后一个要添加删除按钮
            flagForAdd = YES;
        }
        
    }
    
    //        这里计算列数目
    //        判断有没有余数
    NSInteger raw ;
    if (_maxNum%HPictureRow) {
        raw = _maxNum/HPictureRow +1;
    }else
        raw = _maxNum/HPictureRow;
    
    
    //这里进行判断,
    if (_style == ShowPictureStyle)
    {
        _selectedBtns = [self showActionWithArr:tmpArr andFlagForAdd:flagForAdd];
    }else
    {
        //这里还需要区分是否可以进行删除的判断
        _selectedBtns = [self pickActionWithArr:tmpArr andFlagForAdd:flagForAdd];
    }
    
}

//仅仅作为展示!
-(NSArray *)showActionWithArr:(NSArray<UIImageView *> *)tmpArr andFlagForAdd:(BOOL)flagForAdd
{
    //创建以及布局
    UIButton *lastBtn;
    //注意,传入的tmpArr 主要是图片数组
    NSArray<UIImageView *> *imgArr = tmpArr;
    
    //这里需要做下区分,这里需要区分pdf传入的数据,pdf放在最前面!
    NSMutableArray<HPictureItem *> *tmpBtns = [@[] mutableCopy];
    //这里要判断是否有pdf的数据!
    NSInteger pdfCount = _pdfBtns.count;
    NSInteger imgCount = imgArr.count;
    NSInteger videoCount = _videosBtns.count;
    NSInteger total = pdfCount + imgCount+videoCount;//pdf+展示图片的数目!

    
    if (total==0)    //如果没值,或者没有数据!
    {
        [self addSubview:self.spaceLB];
        
        WEAK_SELF;
        [self.spaceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(weakSelf).offset(HPictureMagin);
            make.bottom.equalTo(weakSelf).offset(-HPictureMagin);
        }];

    }else
    {
        for (int i =0 ; i<total; i++) {
        
        UIButton *targetV;
        if (i<pdfCount&&pdfCount>0)//先添加了pdf的按钮
        {
            UIButton *pdfBtn = self.pdfBtns[i];
            [self addSubview:pdfBtn];
            targetV = pdfBtn;
        }else if(i-pdfCount<videoCount&&videoCount>0)//后添加图片的
        {
            NSInteger index =  i-pdfCount;
            HVideoItem *videoBtn = self.videosBtns[index];
            [videoBtn setCancelHidden];
            [self addSubview:videoBtn];
            targetV = videoBtn;
        }else  if(i-pdfCount-videoCount<imgCount&&imgCount>0)
        {
            NSInteger imgIndex = i-pdfCount-videoCount;
            //判断是不是不满限制!是否有添加按钮
            HPictureItem *target = [HPictureItem new];
            target.delegate = self;
            if (self.style == ShowPictureStyle)
            {
                [target setCancelHidden];
            }
            //判断是否不存在添加按钮
            if (flagForAdd) {
                if (imgIndex == tmpArr.count-1) {
                    [target setCancelHidden];
                }
                
            }
            [tmpBtns addObject:target];
            if (tmpArr.count != self.selectedPicArr.count) {
                if (imgIndex==tmpArr.count-1) {
                    [target addTarget:self action:@selector(alertAction) forControlEvents:UIControlEventTouchUpInside];
                }else
                {
                    //图片的按钮事件
                    [target addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                }
            }else
            {
                //图片的按钮事件
                [target addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            target.tag = imgIndex;
            
            //由于有可能存在添加按钮的情况,所以需要判断
            UIImageView *imgV = tmpArr[imgIndex];
            target.imgV = imgV;
            
            [self addSubview:target];
            targetV = target;
        }
        
        
        
        //开始布局,这里目前只能实现单行
        WEAK_SELF;
        [targetV mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lastBtn) {
                make.top.left.equalTo(weakSelf).offset(HPictureMagin);
                make.width.height.mas_equalTo(HPictureItemWH);
                //由于这个设计逻辑中,如果不设置这一行,删除到最后的一个图片的时候,整个约束会消失了,按钮就无法触发
                make.bottom.equalTo(weakSelf).offset(-HPictureMagin).with.priorityLow();
            }else
            {
                
                //判断是不是新的一行开始,注意如果只有一行的话不能用这个方法
                if (i%HPictureRow==0) {
                    make.left.equalTo(weakSelf).offset(HPictureMagin);
                    make.top.equalTo(lastBtn.mas_bottom).offset(HPictureMagin);
                    make.height.width.equalTo(lastBtn);
                }else
                {
                    //如果不是同一行的话
                    make.centerY.height.width.equalTo(lastBtn);
                    make.left.equalTo(lastBtn.mas_right).offset(HPictureMagin);
                }
                
                if (i == total-1||total ==1) {
                    //最后一个做支撑!
                    make.bottom.equalTo(weakSelf).offset(-HPictureMagin);
                }
            }
        }];
        lastBtn = targetV;
        
    }
    }
    return tmpBtns;
}


//不是展示的布局
-(NSArray *)pickActionWithArr:(NSArray *)tmpArr andFlagForAdd:(BOOL)flagForAdd
{
    //创建以及布局
    UIButton *lastBtn;
    NSMutableArray<HPictureItem *> *tmpBtns = [@[] mutableCopy];
    
    //注意,传入的tmpArr 主要是图片数组  这里就包含了哪个添加按钮了!
    NSArray<UIImageView *> *imgArr = tmpArr;
    //这里要判断是否有pdf的数据!
    NSInteger pdfCount = _pdfBtns.count;
    NSInteger imgCount = imgArr.count;
    NSInteger videoCount = _videosBtns.count;
    NSInteger total = pdfCount + imgCount+videoCount;//pdf+展示图片的数目!

    for (int i =0 ; i<total; i++) {
        
        UIButton *targetV;
        if (i<pdfCount)
        {
            UIButton *pdfBtn = self.pdfBtns[i];
            [self addSubview:pdfBtn];
            targetV = pdfBtn;
        }else if(i-pdfCount<videoCount&&videoCount>0)//后添加图片的
        {
            NSInteger index =  i-pdfCount;
            HVideoItem *videoBtn = self.videosBtns[index];
            [self addSubview:videoBtn];
            targetV = videoBtn;
        }else  if(i-pdfCount-videoCount<imgCount&&imgCount>0)
        {
            NSInteger imgIndex = i-pdfCount-videoCount;
            //判断是不是不满限制!是否有添加按钮
            HPictureItem *target = [HPictureItem new];
            target.delegate = self;
            if (self.style == ShowPictureStyle||self.style == AddOnlyPictureStyle)
            {
                [target setCancelHidden];
            }
            //判断是否不存在添加按钮
            if (flagForAdd) {
                if (imgIndex == tmpArr.count-1) {
                    [target setCancelHidden];
                }
                
            }
            [tmpBtns addObject:target];
            if (tmpArr.count != self.selectedPicArr.count)
            {
                if (imgIndex==tmpArr.count-1) {
                    [target addTarget:self action:@selector(alertAction) forControlEvents:UIControlEventTouchUpInside];
                }else
                {
                    //图片的按钮事件
                    [target addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                }
            }else
            {
                //图片的按钮事件
                [target addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            target.tag = imgIndex;
            //由于有可能存在添加按钮的情况,所以需要判断
            UIImageView *imgV = tmpArr[imgIndex];
            target.imgV = imgV;
            
            [self addSubview:target];
            targetV = target;
            
        }
        
        //开始布局,这里目前只能实现单行
        WEAK_SELF;
        
        [targetV mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lastBtn) {
                make.top.left.equalTo(weakSelf).offset(HPictureMagin);
                make.width.height.mas_equalTo(HPictureItemWH);
                //由于这个设计逻辑中,如果不设置这一行,删除到最后的一个图片的时候,整个约束会消失了,按钮就无法触发
                make.bottom.equalTo(weakSelf).offset(-HPictureMagin).with.priorityLow();
            }else
            {
                
                //判断是不是新的一行开始,注意如果只有一行的话不能用这个方法
                if (i%HPictureRow==0) {
                    make.left.equalTo(weakSelf).offset(HPictureMagin);
                    make.top.equalTo(lastBtn.mas_bottom).offset(HPictureMagin);
                    make.height.width.equalTo(lastBtn);
                }else
                {
                    //如果不是同一行的话
                    make.centerY.height.width.equalTo(lastBtn);
                    make.left.equalTo(lastBtn.mas_right).offset(HPictureMagin);
                }
                
                if (i == total-1||total ==1) {
                    //最后一个做支撑!
                    make.bottom.equalTo(weakSelf).offset(-HPictureMagin);
                }
            }
        }];
        lastBtn = targetV;
        
    }
    return tmpBtns;
}


#pragma mark - public

-(NSArray<UIImageView *> *)getPictures
{
    //传已经选择的数据
    return self.selectedPicArr;
}


-(void)setStyle:(HPictureStyle)style
{
    //设置样式
    _style = style;
    //重新渲染一遍!
    self.selectedPicArr = self.selectedPicArr;
    
}

#pragma mark - 传入数组!

#pragma mark 图片
//传入图片数组
-(void)setShowImgArr:(NSArray<UIImage *> *)imgArr
{
    NSMutableArray<UIImageView *> *imgVArr = [@[] mutableCopy];
    for (int i =0 ; i<imgArr.count; i++) {
        [imgVArr addObject:[[UIImageView alloc]initWithImage:imgArr[i]]];
    }
    //直接传入
    self.selectedPicArr = imgVArr;
    [self setFinishActionWithArr:imgVArr andStyle:JustShow];
    
}
//传入图片URL数组,直接做加载
-(void)setShowImgUrlArr:(NSArray<NSString *> *)imgUrlArr
{
    self.imgUrlArr = imgUrlArr;
    NSMutableArray *arr = [@[] mutableCopy];
    for (int i =0 ; i<imgUrlArr.count; i++) {
        UIImageView *tmpImg = [UIImageView new];
        [tmpImg sd_setImageWithURL:[NSURL URLWithString:imgUrlArr[i]]];
        [arr addObject:tmpImg];
    }
    //下面就是要开始布局了!问题就是,pdf放在前面吧!所以就是pdf放在这个前面!
    self.selectedPicArr = arr;
    [self setFinishActionWithArr:arr andStyle:JustShow];
}

#pragma mark pdf
//展示pdf的数组!
-(void)setShowPdfUrlArr:(NSArray<NSString *> *)pdfUrlArr
{
    self.pdfUrlArr = pdfUrlArr;
    NSMutableArray *arr = [@[] mutableCopy];
    for (int i =0 ; i<pdfUrlArr.count; i++)
    {
        UIButton *pdfBtn = [UIButton new];
        pdfBtn.tag = HPicturePDFTag + i;
        [pdfBtn addTarget:self action:@selector(pdfAction:) forControlEvents:UIControlEventTouchUpInside];
        [pdfBtn setImage:[UIImage bundleImgWithName:@"icon_pdf"] forState:UIControlStateNormal];
        [arr addObject:pdfBtn];
    }
    self.pdfBtns = arr; //当传入的有Pdf就显示!pdf!
}

-(void)setShowUrlModelArr:(NSArray<WSDetailPhotoModel *> *)pdfUrlModelArr
{
    self.pdfModelArr = pdfUrlModelArr;
    NSMutableArray *arr = [@[] mutableCopy];
    for (int i =0 ; i<pdfUrlModelArr.count; i++)
    {
        UIButton *pdfBtn = [UIButton new];
        pdfBtn.tag = HPicturePDFTag + i;
        [pdfBtn addTarget:self action:@selector(pdfModelAction:) forControlEvents:UIControlEventTouchUpInside];
        [pdfBtn setImage:[UIImage bundleImgWithName:@"icon_pdf"] forState:UIControlStateNormal];
        [arr addObject:pdfBtn];
    }
    self.pdfBtns = arr;
}



//跳转到btn
-(void)pdfAction:(UIButton *)btn
{
    //查看是否要进行查看和分享!,目前分享不在这个页面做!
    if (_viewController) {
        NSInteger index = btn.tag - HPicturePDFTag;
        NSString *url = self.pdfUrlArr[index];
        PdfShowViewController *vc = [PdfShowViewController new];
        vc.urlStr = url;
        [_viewController.navigationController pushViewController:vc animated:YES];
    }else
        NSLog(@"没有传入控制器,无法打开pdf页面!");
//        [APP_KEYWINDOW makeToast:@"没有传入控制器,无法打开pdf页面!"];
}

-(void)pdfModelAction:(UIButton *)btn
{
    //查看是否要进行查看和分享!,目前分享不在这个页面做!
    if (_viewController) {
        NSInteger index = btn.tag - HPicturePDFTag;
        WSDetailPhotoModel *model = self.pdfModelArr[index];
        PdfShowViewController *vc = [PdfShowViewController new];
        vc.model = model;
        [_viewController.navigationController pushViewController:vc animated:YES];
    }else
        NSLog(@"没有传入控制器,无法打开pdf页面!");
//        [APP_KEYWINDOW makeToast:@"没有传入控制器,无法打开pdf页面!"];
}
#pragma mark 创建视频按钮
//展示pdf的数组!
-(void)setShowVideoUrlArr:(NSArray<NSString *> *)videoUrlArr
{
    self.videosArr = videoUrlArr;
    NSMutableArray *arr = [@[] mutableCopy];
    for (int i =0 ; i<videoUrlArr.count; i++)
    {
        HVideoItem *pdfBtn = [HVideoItem new];
        pdfBtn.tag = HPictureVideoTag + i;
        pdfBtn.cancelBlock = ^{
            [self deleteVideoWithIndex:i];
        };
        [pdfBtn addTarget:self action:@selector(videoAction:) forControlEvents:UIControlEventTouchUpInside];
        [pdfBtn setImage:[UIImage bundleImgWithName:@"videoplayer"] forState:UIControlStateNormal];
        [arr addObject:pdfBtn];
    }
    self.videosBtns = arr; //当传入的有Pdf就显示!pdf!
}

-(void)setShowVideoModelArr:(NSArray<WSDetailPhotoModel *> *)videoUrlModelArr
{
    self.videosModelArr = videoUrlModelArr;
    NSMutableArray *arr = [@[] mutableCopy];
    for (int i =0 ; i<videoUrlModelArr.count; i++)
    {
        HVideoItem *pdfBtn = [HVideoItem new];
        pdfBtn.tag = HPictureVideoTag + i;
        pdfBtn.cancelBlock = ^{
            [self deleteVideoWithIndex:i];
        };
        
        [pdfBtn addTarget:self action:@selector(videoModelAction:) forControlEvents:UIControlEventTouchUpInside];
        [pdfBtn setImage:[UIImage bundleImgWithName:@"videoplayer"] forState:UIControlStateNormal];
        [arr addObject:pdfBtn];
    }
    self.videosBtns = arr;
}

//跳转到btn
-(void)videoAction:(UIButton *)btn
{
    //进入播放器,这是传入Readkey数组的
    if (_viewController) {
        NSInteger index = btn.tag - HPictureVideoTag;
        NSString *readKey = self.videosArr[index];
        [self showPlayerWithVC:_viewController andReadKey:readKey andModel:nil];
    }else
        NSLog(@"没有传入控制器,播放器!");
//        [APP_KEYWINDOW makeToast:@"没有传入控制器,播放器!"];
}

-(void)videoModelAction:(UIButton *)btn
{
    //进入播放器,这是传入模型数组的
    if (_viewController)
    {
        NSInteger index = btn.tag - HPictureVideoTag;
        WSDetailPhotoModel *model = self.videosModelArr[index];
        [self showPlayerWithVC:_viewController andReadKey:nil andModel:model];
    }else
        NSLog(@"没有传入控制器,播放器!");
//        [APP_KEYWINDOW makeToast:@"没有传入控制器,播放器!"];
}



//订单详情布局,主要是区分普通按钮
-(void)setShowDetailPhotoArr:(NSArray<WSDetailPhotoModel *> *)detailModelArr
{
    _detailModelArr = detailModelArr;
}


#pragma mark - private

-(void)setFinishActionWithArr:(NSArray<UIImageView *> *)imgArr andStyle:(ActionStyle)style
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(finishSelectedActionWithArr:andActionStyle:)]) {
        [self.delegate finishSelectedActionWithArr:imgArr andActionStyle:style];
    }
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(finishSelectedActionWithArr:andActionStyle:andTag:)]) {
        [self.delegate finishSelectedActionWithArr:imgArr andActionStyle:style andTag:self.tag];
    }
}

//根据需要添加判断是否要弹窗录像!
-(void)showVideo
{
    self.isVideo = YES;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        [self _initUI];
        [self _initLayout];
    }
    return self;
}


-(void)_initUI
{
    SDWebImageDownloader *sdmanager = [SDWebImageManager sharedManager].imageDownloader;
    [sdmanager setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    [self addSubview:self.addBtn];
}


-(void)_initLayout
{
    WEAK_SELF;
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf).offset(HPictureMagin);
        make.width.height.mas_equalTo(HPictureItemWH);
        make.bottom.equalTo(weakSelf).offset(-HPictureMagin);
    }];
}


#pragma mark 删除事件!


#pragma mark - delegate
-(void)cancelImgActionWithTag:(NSInteger)index
{
    //进行删除的代理
    if (self.delegate&&[self.delegate respondsToSelector:@selector(cancelAction:andIndex:)]) {
        [self.delegate cancelAction:[self.selectedPicArr objectAtIndex:index] andIndex:index];
    };
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(cancelAction:andIndex:andTag:)]) {
        [self.delegate cancelAction:[self.selectedPicArr objectAtIndex:index] andIndex:index andTag:self.tag];
    };
    
    NSMutableArray *tmpArr = [_selectedPicArr mutableCopy];
    [tmpArr removeObjectAtIndex:index];
    self.selectedPicArr = tmpArr;
    
    //完成删除后的数据更新!
    [self setFinishActionWithArr:tmpArr andStyle:CancelAction];
    
}

//点击删除按钮的事件!,点击事件
-(void)btnAction:(UIButton *)btn
{
    //删除操作
    [self showPhotoBowerWithIndex:btn.tag];
}


#pragma mark - 弹窗操作
-(void)alertAction
{
    UIAlertController *alertVC = [[UIAlertController alloc]init];
    UIAlertAction *picAction = [UIAlertAction actionWithTitle:@"选择相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self photoAction];
        
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"选择相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cameraAction];
    }];
    if (self.isVideo) {
        UIAlertAction *videoAction = [UIAlertAction actionWithTitle:@"选择录像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self videoPhotoShow];
            
        }];
        UIAlertAction *videoPhotoAction = [UIAlertAction actionWithTitle:@"现场录像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self videoAction];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:picAction];
        [alertVC addAction:cameraAction];
        [alertVC addAction:videoPhotoAction];
        [alertVC addAction:videoAction];
        [alertVC addAction:cancelAction];
    }else
    {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:picAction];
        [alertVC addAction:cameraAction];
        [alertVC addAction:cancelAction];
    }

    
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

//相册操作! ,通过这里可以获取相册信息
-(void)photoAction
{
    ZZPhotoController *photoController = [[ZZPhotoController alloc]init];
    //控制最大数据
    photoController.selectPhotoOfMax = self.maxNum-self.selectedPicArr.count;
    //设置相册中完成按钮旁边小圆点颜色。
    
    [photoController showIn:HPictureVC result:^(id responseObject){
        
        NSArray *ZZPhotoArr = (NSArray *)responseObject;
        NSMutableArray *tmpImgArr = [@[] mutableCopy];
        for (ZZPhoto *photo in ZZPhotoArr) {
            [tmpImgArr addObject:photo.originImage];
        }
        [self saveSelectedImg:tmpImgArr];
        self.picArray = ZZPhotoArr;
        
    }];
}

//相机操作
-(void)cameraAction
{
    ZZCameraController *cameraController = [[ZZCameraController alloc]init];
    cameraController.takePhotoOfMax = self.maxNum-self.selectedPicArr.count;
    //不保存本地!
    cameraController.isSaveLocal = NO;
    [cameraController showIn:HPictureVC result:^(id responseObject){
        
        NSArray *ZZCameraArr = (NSArray *)responseObject;
        NSMutableArray *tmpImgArr = [@[] mutableCopy];
        for (ZZCamera *camera in ZZCameraArr) {
            [tmpImgArr addObject:camera.image];
        }
        [self saveSelectedImg:tmpImgArr];
        self.picArray = ZZCameraArr;
    }];
}

//录像操作
-(void)videoAction
{
    HVideoController *video = [[HVideoController alloc]init];
    
    [video showInVC:HPictureVC andResultBlock:^(NSString *originPath) {
        [self showCompressAndSaveAlertWithPath:originPath
                                    andProcess:^(float ProcessFloat) {
            [self showProgress:ProcessFloat];
        } FinishBlock:^(NSData *FinishData) {
            [self saveSelectedVideo:FinishData];
        }];
    }];
    self.videoManager = video;
}




//选择本地录像操作
-(void)videoPhotoShow
{
    HVideoPhotoKitController *video = [[HVideoPhotoKitController alloc]init];
    
    [video showInVC:HPictureVC andResultBlock:^(NSString *originPath) {
        [self showCompressAndSaveAlertWithPath:originPath andProcess:^(float ProcessFloat) {
            [self showProgress:ProcessFloat];
        } FinishBlock:^(NSData *FinishData) {
            [self saveSelectedVideo:FinishData];
        }];
    }];
    self.videoManager = video;
}


#pragma mark 弹出浏览器
// 参考关键字:ZZPhotoPickerViewController
//这里需要知道怎么打开查看,因为相机和图片源是不一样的
-(void)showPhotoBowerWithIndex:(NSInteger )index
{
    if (_viewController) {
        NSMutableArray *items = [NSMutableArray new];
        
        for (int i = 0; i < self.selectedPicArr.count; i++) {
            UIImageView *imageView = self.selectedPicArr[i];
            YYPhotoGroupItem *item	= [YYPhotoGroupItem new];
            item.thumbView = imageView;
//            item.largeImageURL = [NSURL URLWithString:urlString];
            [items addObject:item];
        }
        
        YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items];
        [v presentFromImageView:_selectedBtns[index]
                    toContainer:_viewController.view
                       animated:YES
                     completion:nil];
    }
    
}

#pragma mark - 视频处理

-(void)showProgress:(float)progress
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(compressVideoProgress:)]) {
        [self.delegate compressVideoProgress:progress ];
    }
}
-(void)saveSelectedVideo:(NSData *)data
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(addVideo:andTag:)]) {
        [self.delegate addVideo:data andTag:self.tag];
    }
}

-(void)deleteVideoWithIndex:(NSInteger)index
{
    //进行删除的代理
    if (self.delegate&&[self.delegate respondsToSelector:@selector(cancelVideo:andIndex:andTag:)]) {
        NSString *readKey = nil;
        if (self.videosArr) {
            readKey = [self.videosArr objectAtIndex:index];
        }
        if (self.videosModelArr) {
            readKey = [self.videosModelArr objectAtIndex:index].fileId;
        }
        [self.delegate cancelVideo:readKey andIndex:index andTag:self.tag];
    };
    
    NSMutableArray *tmpArr = [_videosArr mutableCopy];
    [tmpArr removeObjectAtIndex:index];
    self.videosArr = tmpArr;
}


#pragma mark - 图片处理
-(void)saveSelectedImg:(NSArray<UIImage *> *)imgArr
{
    NSArray *imgVArr = [self imgViewArrTranferFromImgArr:imgArr];
    //先判断有没有选择的数据
    if (self.selectedPicArr) {
        
        NSMutableArray *updateSelectedarr = [@[] mutableCopy];
        [updateSelectedarr addObjectsFromArray:self.selectedPicArr];
        [updateSelectedarr addObjectsFromArray:imgVArr];
        self.selectedPicArr = updateSelectedarr;
        if (self.delegate &&[self.delegate respondsToSelector:@selector(addAction:)]) {
            [self.delegate addAction:imgVArr];
        }
        if (self.delegate &&[self.delegate respondsToSelector:@selector(addAction:andTag:)]) {
            [self.delegate addAction:imgVArr andTag:self.tag];
        }
    }else
    {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(addAction:)]) {
            [self.delegate addAction:imgVArr];
        }
        if (self.delegate &&[self.delegate respondsToSelector:@selector(addAction:andTag:)]) {
            [self.delegate addAction:imgVArr andTag:self.tag];
        }
        //没有就先赋值
        self.selectedPicArr = [self imgViewArrTranferFromImgArr:imgArr];
    }
    [self setFinishActionWithArr:self.selectedPicArr andStyle:AddAction];

}

-(NSArray<UIImageView *> *)imgViewArrTranferFromImgArr:(NSArray<UIImage *> *)imgArr
{
    NSMutableArray<UIImageView *> *imgVArr = [@[] mutableCopy];
    for (int i =0 ; i<imgArr.count; i++) {
        [imgVArr addObject:[[UIImageView alloc]initWithImage:imgArr[i]]];
    }
    return imgVArr;
}





@end
