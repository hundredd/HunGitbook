//
//  HPictureView+Video.m
//  QHZC
//
//  Created by hun on 2017/11/9.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HPictureView+Video.h"
#import "TranTool.h"

#import "HplayerVC.h"


@implementation HPictureView (Video)

-(void)showCompressAndSaveAlertWithPath:(NSString *)path andProcess:(void(^)(float ProcessFloat))ProcessBlock FinishBlock:(void(^)(NSData *FinishData))finishBLock
{
    UIAlertController *alertVC = [UIAlertController
                                  alertControllerWithTitle:@"请确定以下操作"
                                  message:@"请确认是否压缩本次上传本视频并保存到本地"
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *picAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [TranTool convertVideoWithModel:path andProccessBlock:^(float process) {
            if (ProcessBlock) {
                ProcessBlock(process);
            }
        } andFinishBlock:^(NSData *data, NSString *filePath) {
            //完成之后把Block传出去?,主要是上传
            // 判断能不能保存到相簿
            if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(filePath))
            {
                // 保存视频到相簿
                UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);;
            }
//            [TipShowManager showToastWoView:self andDetail:@"保存成功"];
            
            if (finishBLock) {
                finishBLock(data);
            }
        } andError:^(NSError *error) {
//            [TipShowManager showToastWoView:self andDetail:@"视频保存失败,请删除已经处理后的视频,再重试"];
        }];
        
        
    }];
    
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:picAction];
    [alertVC addAction:cancelAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}





#pragma mark - 保存视频的代理
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo {
    NSLog(@"保存视频完成");
}

#pragma mark - 展示播放器!
-(void)showPlayerWithVC:(UIViewController *)vc
             andReadKey:(NSString *)readKey
               andModel:(WSDetailPhotoModel *)videoUrlModel
{
    HplayerVC *playerVC = [HplayerVC new];
    
    if (readKey.length>0) {
        playerVC.readKey = readKey;
    }
    if (videoUrlModel!=nil)
    {
        playerVC.readKey = videoUrlModel.fileId;
    }
    
    [vc.navigationController pushViewController:playerVC animated:YES];
}

@end
