//
//  HVideoPhotoKitController.m
//  QHZC
//
//  Created by hun on 2017/11/9.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HVideoPhotoKitController.h"

#import "PHImageCollectionController.h"
#import "PHImageModel.h"

@interface HVideoPhotoKitController ()

@end
@implementation HVideoPhotoKitController


// 继承原来的操作!,主要就是可以进行block的初始化
-(void)showInVC:(UIViewController *)vc andResultBlock:(ResultBlock)resultBlock
{
    [super showInVC:vc andResultBlock:resultBlock];
    
    NSInteger type=2;
    PHImageCollectionController * phCL =[[PHImageCollectionController alloc] init];
    phCL.maxNum = 1;
    [phCL getResultWithType:type andWithSuccess:^(NSArray *result) {
        //这里只获取到第一个选项
        if(result.hash)
        {
            NSLog(@"%ld",result.count);
            
            PHImageModel * model =result[0];
            
            if (self.calBackBlock) {
                self.calBackBlock(model.url.path);//把录制的视频扔过去 model.imageName
            }
        }
        
    }];
    
    UINavigationController * phNvc = [[UINavigationController alloc] initWithRootViewController:phCL];
    [vc presentViewController:phNvc animated:YES completion:nil];
}





@end
