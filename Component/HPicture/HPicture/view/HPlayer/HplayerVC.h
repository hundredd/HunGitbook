//
//  HplayerVC.h
//  QHZC
//
//  Created by hun on 2017/11/15.
//  Copyright © 2017年 QHJF. All rights reserved.
//

/*
 功能说明:
 1. 主要就是
 */
#import <UIKit/UIKit.h>

@interface HplayerVC : UIViewController

@property(nonatomic,copy)NSString *readKey ;//查看ReadKey!


@end


@interface HplayerVC (FileDeal)

-(void)checkDocumentAndCancel;


-(BOOL) isFileExist:(NSString *)fileName;
@end
