//
//  FileModel.h
//  QHZC
//
//  Created by hundred on 2017/5/25.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject

@property(nonatomic,copy)NSString *fileId;          //文件ID
@property(nonatomic,copy)NSString *fileSize;        //文件大小（字节）
@property(nonatomic,copy)NSString *readKey;         //文件KEY

@property(nonatomic,copy)NSString *fileType;        //文件种类  PNG还是其他
@property(nonatomic,copy)NSString *fileItemType;    //文件类型
@property(nonatomic,copy)NSString *uploadOn;        //上传时间
@property(nonatomic,copy)NSString *uploadBy;        //上传人UM号

@property(nonatomic,copy)NSString *acctNo;          //银行卡号!主要做匹配!

//目前不清楚
@property(nonatomic,copy)NSString *recordId;        //记录号
@property(nonatomic,copy)NSString *flagDeleted;     //标记是否删除了

//查询的时候用到的
@property(nonatomic,copy)NSString *refObjectType;   //外键类型
@property(nonatomic,copy)NSString *refObjectNo;     //外键

@end
