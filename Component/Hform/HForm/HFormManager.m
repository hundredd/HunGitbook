//
//  HFormManager.m
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormManager.h"
#import "HFormEditManager.h"
#import "HFormPickerManager.h"
#import "HFormSelectManager.h"
#import "HFormShowManager.h"
#import "HFormDoubleManager.h"
#import "HFormSolidManager.h"
@interface HFormManager()

@property(nonatomic,strong)NSArray<HFormOriginModel *> *originArr;




@end

@implementation HFormManager
{
    BOOL _isNotStaticHeight;//是否固定高度
}

-(void)setDatasource:(id<HFormManagerDataSource>)datasource
{
    _datasource = datasource;
    if ([datasource respondsToSelector:@selector(editDatasoureWithManager:)]) {
        //这里进行数据布局
        self.originArr = [datasource editDatasoureWithManager:self];
    }
}


-(void)resetOriginArr:(NSArray<HFormOriginModel *> *)resetOriginArr
{
    if (resetOriginArr) {
        //这里进行数据布局,重新渲染
        self.originArr = resetOriginArr;
    }
}


-(HFormBaseItem *)itemForKey:(NSString *)key
{
    if (!key&&[key isEqualToString:@""]) {
        return nil;
    }
    
    for (HFormBaseItem *item1 in self.itemsArr) {
        if ([item1.originModel.key isEqualToString:key]) {
            return item1;
        }
    }
    
    return nil;
}

#pragma mark - private
#pragma mark - setter/getter
-(instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = hWhiteTextColor;
    }
    return self;
}


#pragma mark - public

-(void)setDataArr:(NSArray<HFormModel *> *)dataArr
{
    _dataArr = dataArr;
    for (HFormModel *model in dataArr) {
        NSString *key = model.key;
        //    获取到item以及传入对应的model!
        //    根据每个key传值!
        for (int i=0; i<self.originArr.count; i++) {
            HFormOriginModel *oriModel = self.originArr[i];
            if ([oriModel.key isEqualToString:key]||
                [oriModel.leftKey isEqualToString:key]||
                [oriModel.rightKey isEqualToString:key]||
                [oriModel.keyTime1 isEqualToString:key]||
                [oriModel.keyTime2 isEqualToString:key])
            {
                HFormBaseItem *item = self.itemsArr[i];
                item.model = model;
            }
        }
    }
}


-(void)setOriginArr:(NSArray<HFormOriginModel *> *)originArr
{
    //重新刷新数据,首先把所有数据清除
    if (_originArr)
    {
        //清除顶部数据
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }
    _originArr = originArr;
    NSInteger total = originArr.count;
    HFormBaseItem *lastItem;
    UIView *lastMaginV;
    NSMutableArray *itemsArr = [@[] mutableCopy];
    for (int i =0 ; i<total; i++)
    {
        HFormBaseItem *item ;
        HFormOriginModel *originModel = originArr[i];
        /*
         NomalTextFieldHFormStyle = 0 ,   //0 输入框!
         NumTextFieldHFormStyle ,         //1 数字输入框
         PickerHFormStyle,                //2 选择数据!
         DoubleButtonHFormStyle,          //3 主要是时间的左右两段!
         SelectHFormStyle,                //4 这个是获取选择项目!,需要单独配置selected选项
         DateHFormStyle,                  //5 这个是选择有效期区间段!
         ButtonHFormStyle,                //6 按钮事件(整个item都是button) ,里面有一个布尔值可以做时间选择!
         ShowHFormStyle,                  //7 纯粹的展示!可以显示高亮!
         AddressHFormStyle,               //8 地址选择器
         SolidTelHFormStyle,              //9 电话,传真两项
         ButtonEditHFormStyle,             //10 按钮和编辑同时实现,与6做区分!,主要在份额转换赎回时候用的
         NumTextFieldDocHFormStyle ,         //11 数字输入框,带点
         */
        switch (originModel.style) {
            case NomalTextFieldHFormStyle:
            case NumTextFieldHFormStyle:
            case NumTextFieldDocHFormStyle:
            case ButtonHFormStyle:
                item = [HFormEditManager new];
                break;
            case PickerHFormStyle:
            case AddressHFormStyle:
            case DateHFormStyle:
            case DateMinHFormStyle:
                item = [HFormPickerManager new];
                break;
            case SelectHFormStyle:
            case MutiSelectHFormStyle:
                item = [HFormSelectManager new];
                break;
            case ShowHFormStyle:
                item = [HFormShowManager new];
                break;
            case AutoShowHFormStyle:
                _isNotStaticHeight = YES;
                item = [[HFormShowManager alloc]initWithShowAuto:YES];
                break;
            case SolidTelHFormStyle:
                item = [HFormSolidManager new];
                break;
            case DoubleDateHFormStyle:
                item = [HFormDoubleManager new];
                break;
            default:
                [HFormBaseItem new];
                break;
        }
        item.originModel = originModel;
        //这里要分配编辑,选择,picker!
        [itemsArr addObject:item];
        item.backgroundColor = [UIColor clearColor];
        [self addSubview:item];
        
        WEAK_SELF;
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!_isNotStaticHeight)
            {
                if (!lastItem) {
                    make.top.equalTo(weakSelf).offset(HCommonVerticalMagin);
                }else
                {
                    make.top.equalTo(lastMaginV.mas_bottom).offset(HCommonVerticalMagin);
                }
                make.height.greaterThanOrEqualTo(@30);//设置最低高度
            }else
            {
                if (!lastItem) {
                    make.top.equalTo(weakSelf).offset(HSmallVerticalMagin);
                }else
                {
                    make.top.equalTo(lastMaginV.mas_bottom).offset(HSmallVerticalMagin);
                }
            }
                
            make.left.right.equalTo(weakSelf);
            if (i==total-1) {
                make.bottom.equalTo(weakSelf).offset(-HCommonVerticalMagin);
            }
            
        }];
        
        if (i != total-1) {
            UIView *maginV = [UIView new];
            maginV.backgroundColor = hClearColor;
            [self addSubview:maginV];
            
            [maginV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(item.mas_bottom).offset(5);
                make.centerX.equalTo(weakSelf);
                make.height.mas_equalTo(HCommonVerticalMagin);
                make.width.equalTo(weakSelf).multipliedBy(hMaginRate);
            }];
            lastMaginV = maginV;
        }
        
        lastItem = item;
        
    }
    _itemsArr = itemsArr;
    
}


-(NSDictionary *)queryDic
{
    NSMutableDictionary *dataDir =[@{} mutableCopy];
    //这里是统计,并且组装数据内容!
    for (HFormBaseItem *item in _itemsArr) {
        [dataDir addEntriesFromDictionary:item.valueDic];
    }

    return dataDir;
}

@end
