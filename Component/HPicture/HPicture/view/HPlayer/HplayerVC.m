//
//  HplayerVC.m
//  QHZC
//
//  Created by hun on 2017/11/15.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HplayerVC.h"
#import "KYVedioPlayer.h"
@interface HplayerVC ()<KYVedioPlayerDelegate>
@property(nonatomic,copy)NSString *localPath ;//查看本地是否已经存在这一个文件!
@end

@implementation HplayerVC
{
    KYVedioPlayer  *videoPlayer;
    CGRect     playerFrame;
    NSString *URLString;
}
//-(NSString *)readKey
//{
//    if (!_readKey) {
//        _readKey = @"Re2c9ec72e9994434a855c65b8111b1f0";
//    }
//    return _readKey;
//}

-(NSString *)localPath
{
    if (!_localPath) {
        _localPath = [QHDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",self.readKey]];
    }
    return _localPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    
    [self downloadAction];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self checkDocumentAndCancel];
}

#pragma mark - 视频操作!
-(void)videoPlay
{
    playerFrame = CGRectMake(0, 20, kScreenWidth,kScreenHeight-20 );
    videoPlayer = [[KYVedioPlayer alloc]initWithFrame:playerFrame];
    videoPlayer.delegate = self;

    
//    if ([TheUserDefaults doubleForKey:URLString]) {//如果有存上次播放的时间点记录，直接跳到上次纪录时间点播放
//        double time = [TheUserDefaults doubleForKey:URLString];
//        vedioPlayer.seekTime = time;
//    }
    [videoPlayer setURLString:self.localPath];
    
    videoPlayer.titleLabel.text = self.title;
    videoPlayer.closeBtn.hidden = NO;
    videoPlayer.progressColor = [UIColor orangeColor];
    [self.view addSubview:videoPlayer];
    [videoPlayer play];
}

/**
 *  注销播放器
 **/
- (void)releasePlayer
{
    [videoPlayer resetKYVedioPlayer];
    videoPlayer = nil;
}

- (void)dealloc
{
    //记录播放的时间
//    double time = [vedioPlayer currentTime];
//    [USER_DEFAULT setDouble:time forKey:self.];
    
    [self releasePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"KYRememberLastPlayedVC dealloc");
}

/**
 *  隐藏状态栏
 **/
-(BOOL)prefersStatusBarHidden{
    return YES;
}


#pragma mark - KYVedioPlayerDelegate 播放器委托方法
//点击播放暂停按钮代理方法
-(void)kyvedioPlayer:(KYVedioPlayer *)kyvedioPlayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    
    NSLog(@"[KYVedioPlayer] clickedPlayOrPauseButton ");
}
//点击关闭按钮代理方法
-(void)kyvedioPlayer:(KYVedioPlayer *)kyvedioPlayer clickedCloseButton:(UIButton *)closeBtn{
    
    NSLog(@"[KYVedioPlayer] clickedCloseButton ");
    [self.navigationController popViewControllerAnimated:YES];
}

//点击分享按钮代理方法
-(void)kyvedioPlayer:(KYVedioPlayer *)kyvedioPlayer onClickShareBtn:(UIButton *)closeBtn{
    
    NSLog(@"[KYVedioPlayer] onClickShareBtn ");
    
}

//点击全屏按钮代理方法
-(void)kyvedioPlayer:(KYVedioPlayer *)kyvedioPlayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    NSLog(@"[KYVedioPlayer] clickedFullScreenButton ");
    
}
//单击WMPlayer的代理方法
-(void)kyvedioPlayer:(KYVedioPlayer *)kyvedioPlayer singleTaped:(UITapGestureRecognizer *)singleTap{
    
    NSLog(@"[KYVedioPlayer] singleTaped ");
}
//双击WMPlayer的代理方法
-(void)kyvedioPlayer:(KYVedioPlayer *)kyvedioPlayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    
    NSLog(@"[KYVedioPlayer] doubleTaped ");
}

///播放状态
//播放失败的代理方法
-(void)kyvedioPlayerFailedPlay:(KYVedioPlayer *)kyvedioPlayer playerStatus:(KYVedioPlayerState)state{
    NSLog(@"[KYVedioPlayer] kyvedioPlayerFailedPlay  播放失败");
}
//准备播放的代理方法
-(void)kyvedioPlayerReadyToPlay:(KYVedioPlayer *)kyvedioPlayer playerStatus:(KYVedioPlayerState)state{
    
    NSLog(@"[KYVedioPlayer] kyvedioPlayerReadyToPlay  准备播放");
}
//播放完毕的代理方法
-(void)kyplayerFinishedPlay:(KYVedioPlayer *)kyvedioPlayer{
    
    NSLog(@"[KYVedioPlayer] kyvedioPlayerReadyToPlay  播放完毕");
}

#pragma mark - 下载操作!
//成功下载
-(void)requestGetComplete:(id)response error:(NSError*)error;
{
    
    
    NSData *data = response;
    
    [self saveActionWithData:data];
    [self videoPlay];
}

//下载过程的!
-(void)requestGetDownloadWithProgress:(NSProgress *)process
{
    
    
}

-(void)downloadAction
{
    if (![self isFileExist:self.localPath]) {
        NSDictionary *bodyDic = @{@"readKey":self.readKey};
        //衡杰写的下载方法!
//        [self sendGetDownloadRequestWithKey:WSS_DOWNLOAD_FILE params:bodyDic];
//        [self.waitView showAnimated:YES];
    }else
        [self videoPlay];
    
    
}



-(void)saveActionWithData:(NSData *)data
{
    //这里自己写需要保存数据的路径
    [data writeToURL:[NSURL fileURLWithPath:self.localPath] atomically:YES];
}

#pragma mark - interface rotation

//横屏
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSString *frameString = NSStringFromCGRect(videoPlayer.frame);
    
    NSLog(@"视频窗口的frame:%@",frameString);
}

@end


@implementation HplayerVC (FileDeal)




/**
 检查文件夹,并删除
 */
-(void)checkDocumentAndCancel
{
    if ([self folderSizeAtPath:QHDocumentPath]>2)
    {
        float a = [self folderSizeAtPath:QHDocumentPath];
//        LxDBAnyVar(a);
        NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        NSString *path = QHDocumentPath;
//        if ([path containsString:DocumentsPath]) {
//            LxDBAnyVar(path);
//            LxDBAnyVar(DocumentsPath);
//        }
        NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:DocumentsPath];
        for (NSString *fileName in enumerator) {
            [[NSFileManager defaultManager] removeItemAtPath:[DocumentsPath stringByAppendingPathComponent:fileName] error:nil];
        }
        
    }
}

//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


//判断文件是否已经在沙盒中已经存在？
-(BOOL) isFileExist:(NSString *)filePath
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths objectAtIndex:0];
//    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}


@end

