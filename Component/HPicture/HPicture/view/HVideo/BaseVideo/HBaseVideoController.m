//
//  HBaseVideoController.m
//  QHZC
//
//  Created by hun on 2017/11/9.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HBaseVideoController.h"
@interface HBaseVideoController ()
@property(nonatomic,copy)ResultBlock saveBlock ;//回调
@end

@implementation HBaseVideoController


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupInit];
    }
    return self;
}

-(void)setupInit
{
    // 创建拾取控制器
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    // 设置拾取源为摄像头
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 设置摄像头为后摄像头
    pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    
    pickerController.editing = YES; // 设置运行编辑，即可以
    pickerController.delegate = self;
    self.pickerController = pickerController;
}
-(void)showInVC:(UIViewController *)vc andResultBlock:(ResultBlock)resultBlock
{
    self.calBackBlock = resultBlock;
    self.showVC = vc;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 从info取出此时摄像头的媒体类型
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    // 拾取控制器弹回
    [self.showVC dismissViewControllerAnimated:YES completion:^{
        //需要返回才能弹窗!,注意这个操作流程
        if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) { // 如果是拍照
            // 获取录像文件路径URL
            NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
            NSString *path = url.path;
            if (self.calBackBlock) {
                self.calBackBlock(path);//把录制的视频扔过去
            }
        }
    }];
}


@end
