//
//  HVideoItem.m
//  QHZC
//
//  Created by hun on 2017/11/14.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HVideoItem.h"

@implementation HVideoItem

-(void)cancelAction
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
@end
