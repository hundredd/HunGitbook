//
//  HVideoController.m
//  QHZC
//
//  Created by hun on 2017/11/9.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HVideoController.h"
@interface HVideoController ()



@end

@implementation HVideoController

// 继承原来的操作!,主要就是可以进行block的初始化
-(void)showInVC:(UIViewController *)vc andResultBlock:(ResultBlock)resultBlock
{
    [super showInVC:vc andResultBlock:resultBlock];
    //设定录像的媒体类型
    self.pickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
    //设置摄像头捕捉模式为捕捉视频
    self.pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    //设置视频质量为高清
    self.pickerController.videoQuality = UIImagePickerControllerQualityType640x480;
    //模式弹出拾取控制器
    [vc presentViewController:self.pickerController animated:YES completion:nil];
}


#pragma mark - 代理方法
/* 拍照或录像成功，都会调用*/
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//{
//    [super imagePickerController:picker didFinishPickingMediaWithInfo:info];
//    // 从info取出此时摄像头的媒体类型
//    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) { // 如果是拍照
//        // 获取录像文件路径URL
//        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
//        NSString *path = url.path;
//        if (self.calBackBlock) {
//            self.calBackBlock(path);//把录制的视频扔过去
//        }
//    }
//    
//    // 拾取控制器弹回
//    [self.showVC dismissViewControllerAnimated:YES completion:nil];
//    
//}

@end
