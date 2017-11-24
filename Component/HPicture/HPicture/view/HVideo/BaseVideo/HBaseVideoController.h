//
//  HBaseVideoController.h
//  QHZC
//
//  Created by hun on 2017/11/9.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>


typedef void (^ResultBlock)(NSString *originPath);//选择的地址,或者录像后的地址
@interface HBaseVideoController : NSObject<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *pickerController; // 拾取控制器

@property(nonatomic,strong)UIViewController *showVC ;//弹出的Vc
@property(nonatomic,copy)ResultBlock calBackBlock ;//回调


-(void)showInVC:(UIViewController *)vc andResultBlock:(ResultBlock)resultBlock;

@end
