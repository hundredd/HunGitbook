//
//  WSPhotoGroupModel.h
//  QHZC
//
//  Created by LiuJian'e on 2017/6/26.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileModel.h"
#import "WSDetailPhotoModel.h"
@interface WSPhotoModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,strong)NSArray *imageIdList;//NSString 传入url www.ssss.com/read=askdskad 如果是订单的话就是nsstring!

@property(nonatomic,strong)NSArray<NSDictionary *> *imageIdFileInfoMapping;//订单传回来的具体值 WSDetailPhotoModel

@property(nonatomic,assign)BOOL readOnly;



@end
