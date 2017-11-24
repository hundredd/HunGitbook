//
//  TranTool.h
//  JFUpLoadVideo
//
//  Created by hun on 2017/10/30.
//  Copyright © 2017年 Jessonliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TranTool : NSObject

//视频转换!
+ (void) convertVideoWithModel:(NSString *)filePath
              andProccessBlock:(void(^)(float process))ProcessBlock
                andFinishBlock:(void(^)(NSData *data,NSString *filePath))finishBlock
                      andError:(void(^)(NSError *error)) errorBlock;


//保存视频到本地!
+(void)saveVideoToLocal:(NSString *)path;


@end
