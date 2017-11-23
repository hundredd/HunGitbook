
//
//  HFormSelectManager.m
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormSelectManager.h"
#import "HFormSelectUnit.h"

#define HFormSelectedTagNum 181         //按钮的编码序号
@interface HFormSelectManager()

@property(nonatomic,strong)UIView *selectedV;
@property(nonatomic,assign)BOOL isDefalutSelected ;//是否不选择
@property(nonatomic,assign)NSInteger selectedNum;             //如果是选项,选中的部分!
@property(nonatomic,strong)NSArray *selectedArr;//选中数据
@property(nonatomic,strong)NSArray *selectItemArr;//选中数据
@property(nonatomic,strong)NSMutableArray *selectItems;//项目数组
@end

@implementation HFormSelectManager
{
    HFormSelectUnit *lastSelectedItem ;//
}

#pragma mark - public

-(NSDictionary *)valueDic
{
    if (self.style == SelectHFormStyle)
    {
        return @{self.originModel.key:@(self.selectedNum)};
    }else if (self.style == MutiSelectHFormStyle)
    {
        return @{self.originModel.key:[self loopSelectedItem]};
    }
    return @{};
}

-(void)setSelectedIndex:(NSNumber *)selectedIndex
{
    _selectedIndex = selectedIndex;
    self.selectedNum = _selectedIndex.integerValue;
    lastSelectedItem.isSelected = NO;
    HFormSelectUnit *item = [_selectedV viewWithTag:(self.selectedNum + HFormSelectedTagNum)];
    item.isSelected = YES;
    lastSelectedItem = item;
}

#pragma mark - action

-(void)selectAction:(HFormSelectUnit *)selectedItem
{
    //区分单选还是多选
    if (self.style == MutiSelectHFormStyle)
    {
        
    }else if (self.style == SelectHFormStyle)
    {
        //这里控制初始化生成的selected
        lastSelectedItem.isSelected = NO;
        lastSelectedItem = selectedItem;
        self.selectedNum = lastSelectedItem.tag - HFormSelectedTagNum;
    }
    //这里要区分
    selectedItem.isSelected = !selectedItem.isSelected;
}

#pragma mark - public
//渲染并创建
-(void)setOriginModel:(HFormOriginModel *)originModel
{
    [super setOriginModel:originModel];
    
    if (originModel.isDefalutSelected)//是否预先填充
    {
        self.isDefalutSelected = originModel.isDefalutSelected;
    }
    
    if (originModel.selectedArr)
    {
        //布置选中项目
        self.selectItemArr = originModel.selectedArr;
    }
}


-(void)setModel:(HFormModel *)model
{
    [super setModel:model];
    
    if (self.style == MutiSelectHFormStyle)
    {
        if (model.selectedArr.count>0)
        {
            //对多项选择的答案填充
            self.selectedArr = model.selectedArr;
            //进行数据
            for (NSNumber *index in self.selectedArr)
            {
                if (index.intValue<_selectedV.subviews.count)//避免和原来的崩溃!
                {
                    HFormSelectUnit *lastItem = _selectedV.subviews[index.intValue];
                    lastItem.isSelected = YES;
                }
            }
        }
    }if (self.style == SelectHFormStyle)
    {
        for (HFormSelectUnit *lastItem  in _selectedV.subviews) {
            lastItem.isSelected = NO;
        }
        if (model.selectedIndex)
        {
            self.selectedNum = model.selectedIndex.intValue;
            HFormSelectUnit *lastItem = _selectedV.subviews[self.selectedNum];
            lastItem.isSelected = YES;
            lastSelectedItem = lastItem;
        }
    }
    
}


//创建对应的UI
-(void)setStyle:(HFormStyle)style
{
    [super setStyle:style];
    //因为布局的内容一致,就用一个就可以了
    self.RightV = self.selectedV;
    WEAK_SELF;
    [self.selectedV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleV.mas_right);
        make.centerY.height.equalTo(weakSelf.titleV);
        make.right.equalTo(weakSelf);
    }];
    
}

//配置基本的选项!,这里不进行填充
-(void)setSelectItemArr:(NSArray *)selectItemArr
{
    _selectItemArr = selectItemArr;
    BOOL isMuti = NO;
    if (self.style == MutiSelectHFormStyle)
    {
        isMuti = YES;
    }
    //这里布置选项的数据
    if (_selectedV)
    {
        HFormSelectUnit *lastItem;
        NSInteger total = selectItemArr.count;
        for (int i = 0; i<total; i++)
        {
            //设置是否多选!
            HFormSelectUnit *item = [[HFormSelectUnit alloc]initWithIsMuti:isMuti];
            
            item.title = selectItemArr[i];
            item.backgroundColor = [UIColor clearColor];
            item.tag = i + HFormSelectedTagNum;
            item.addSelectUnitOnclick = ^(HFormSelectUnit *selectedItem)
            {
                [self selectAction:selectedItem];

            };
            [_selectedV addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                if (!lastItem) {
                    //距离第一个的位置
                    make.left.equalTo(_selectedV);
                }else
                {
                    //把数据进行排布
                    make.left.equalTo(lastItem.mas_right).offset(HCommonVerticalMagin);
                }
                make.centerY.height.equalTo(self.titleV);
            }];
            //如果是只有一个选项,默认颜色就是高亮
            if (total == 1) {
                item.isHighLightTitle = YES;
            }
            
            lastItem = item;
            [self.selectItems addObject:item];
        }
    }
}

-(NSArray<NSNumber *> *)loopSelectedItem
{
    NSMutableArray *tmpSelect = [@[] mutableCopy];
    for (HFormSelectUnit *item in self.selectItems) {
        if (item.isSelected) {
            [tmpSelect addObject:@(item.tag - HFormSelectedTagNum)];
        }
    }
    return tmpSelect;
}

#pragma mark - getter
-(NSMutableArray *)selectItems
{
    if (!_selectItems)
    {
        _selectItems = [@[] mutableCopy];
    }
    return _selectItems;
}

-(UIView *)selectedV
{
    //先设置一个选择框的尺寸
    if (!_selectedV) {
        UIView *selectedV = [UIView new];
        selectedV.backgroundColor = [UIColor clearColor];
        [self addSubview:selectedV];
        _selectedV = selectedV;
    }
    return _selectedV;
}

@end
