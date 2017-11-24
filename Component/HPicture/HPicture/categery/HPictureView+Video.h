//
//  HPictureView+Video.h
//  QHZC
//
//  Created by hun on 2017/11/9.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HPictureView.h"

@interface HPictureView (Video)

-(void)showCompressAndSaveAlertWithPath:(NSString *)path
                             andProcess:(void(^)(float ProcessFloat))ProcessBlock
                            FinishBlock:(void(^)(NSData *FinishData))finishBLock;


-(void)showPlayerWithVC:(UIViewController *)vc
             andReadKey:(NSString *)readKey
               andModel:(WSDetailPhotoModel *)videoUrlModel;

@end
