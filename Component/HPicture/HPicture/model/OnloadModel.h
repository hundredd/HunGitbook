//
//  OnloadModel.h
//  QHZC
//
//  Created by hun on 2017/6/30.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <Foundation/Foundation.h>

//上传接口返回的数据  通过返回的数据进行修改

@interface OnloadModel : NSObject


@property(nonatomic,copy)NSString *readKey ;//添加的readKey

@property(nonatomic,copy)NSString *fileId   ;//file的ID

@property(nonatomic,copy)NSString *fileUrl   ;//如果是请求WWW的时候会有url返回!

@end
