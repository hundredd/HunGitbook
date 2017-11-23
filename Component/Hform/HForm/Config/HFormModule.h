//
//  HFormModule.h
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//


//部分对外的脚本
#ifndef HFormModule_h
#define HFormModule_h

//一般展示
#define HFormNoral(title,style,Key) @{@"title":title,@"style":@(style),@"key":Key}

#define HFormNoralPlace(title,style,place,Key) @{@"title":title,@"style":@(style),@"placeHolder":place,@"key":Key}
#define HFormNoralPlaceDele(title,style,place,Key,delegate) @{@"title":title,@"style":@(style),@"placeHolder":place,@"key":Key,@"delegate":delegate}
#define HFormNoralPlaceDeleRemark(title,style,place,Key,delegate,remark) @{@"title":title,@"style":@(style),@"placeHolder":place,@"key":Key,@"delegate":delegate,@"remark":remark}
#define HFormNoralPlaceMax(title,style,place,Key,maxNum) @{@"title":title,@"style":@(style),@"placeHolder":place,@"key":Key,@"maxNum":maxNum}
#define HFormNoralPlaceMaxDele(title,style,place,Key,maxNum,delegate) @{@"title":title,@"style":@(style),@"placeHolder":place,@"key":Key,@"maxNum":maxNum,@"delegate":delegate}
//一般输入
#define HFormNoralPlaceSin(title,style,place,Key,delegate,single)  @{@"title":title,@"style":@(style),@"placeHolder":place,@"key":Key,@"delegate":delegate,@"single":single}

//时间选择器
//时间间距!还有就是时间长短!
#define HFormDateDDelL(title,style,place,keyTime1,keyTime2,delegate,islong) @{@"title":title,@"style":@(style),@"placeHolder":place,@"keyTime1":keyTime1,@"keyTime2":keyTime2,@"delegate":delegate,@"isRightLongTerm":@(islong)}
#pragma mark - 单纯拼接元素

#define hftitle(title) @"title":title
#define hfplaceHolder(placeHolder) @"placeHolder":placeHolder
#define hfstyle(style) @"style":@(style)
#define hfkey(key) @"key":key
#define hfsingle(single) @"single":single
#define hfpickerArr(pickerArr) @"pickerArr":pickerArr
#define hfvalue(value) @"value":HNotNull(value)
#define hfDelegate(delegate) @"delegate":delegate

#define hfleftkey(key) @"leftKey":key
#define hfright(key) @"rightKey":key

//选择数据部分
#define hfpickerTitle(pickerTitle) @"pickerTitle":pickerTitle//选择标题
#define hfpickerHoldTitle(pickerTitle) @"placeHolder":pickerTitle,@"pickerTitle":pickerTitle//选择标题
#define hfRemark(remark) @"remark":remark

//数组
#define hfselectedArr(selectArr) @"selectedArr":@[selectArr]

//填充数据
#define hfDetailNoralForbid(Key,detail,Forbid) @{@"detail":HNotNull(detail),@"key":Key,@"isForBidden":@(Forbid)}
#define hfDetailNoral(Key,detail) @{@"detail":HNotNull(detail),@"key":Key}
#define hfDetailLeftRight(Key,leftValue,rightValue) @{@"key":Key,@"leftValue":HNotNull(leftValue),@"rightValue":HNotNull(rightValue)}
#define hfSelectedIndexNoral(Key,selectedIndex)  @{@"selectedIndex":selectedIndex,@"key":Key}
#define hfSelectedIndex(selectedIndex) @"selectedIndex":selectedIndex
#define hfDetail2Attr(detail) @"detail2Attr":detail
#define hfDetail2(detail) @"detail2":HNotNull(detail)
#define hfDetail(detail) @"detail":HNotNull(detail)
#define hfDetailNull(detail) @"detail":detail
//针对左右结构的
#define hfLeftValue(left) @"LeftValue":HNotNull(left)
#define hfrightValue(right) @"rightValue":HNotNull(right)


#endif /* HFormModule_h */
