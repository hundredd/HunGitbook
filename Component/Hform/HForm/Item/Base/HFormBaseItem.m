//
//  HFormBaseItem.m
//  QHZC
//
//  Created by hun on 2017/10/12.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HFormBaseItem.h"
#import "HFormConfig.h"
@interface HFormBaseItem ()


@end

@implementation HFormBaseItem

#pragma mark - method
-(void)forBidAction
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addEditItemForBidClickWithView:)]) {
        [self.delegate addEditItemForBidClickWithView:self];
    }
}

#pragma mark - overWrite
-(NSDictionary *)valueDic
{
    return @{};
}

#pragma mark - public
//更新是否隐藏
-(void)updateForbiden:(BOOL)isforbiden
{
    if (isforbiden) {
        self.forbidenView.hidden = NO;
        [self.forbidenView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self.RightV) {
                make.edges.equalTo(self.RightV);
            }
        }];
    }else
    {
        self.forbidenView.hidden = YES;
        [self.forbidenView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
}

//是否要出现挡板!
-(void)setIsFirstForbiden:(BOOL)isFirstForbiden
{
    _isFirstForbiden = isFirstForbiden;
    //创收
    [self updateForbiden:isFirstForbiden];
}

-(void)setOriginModel:(HFormOriginModel *)originModel
{
    _originModel = originModel;
    
    //这里调用子类的方法!
    self.style = originModel.style;
    
    //控制换行!
    self.titleLB.text =originModel.title;
    //如果是iphone5之类的设备可以在这里设置好
    if (originModel.title.length>0) {
        NSMutableString *titleStr = [originModel.title mutableCopy];
//        if (!originModel.maxNumStr) {
//            if (IS_IPHONE_5) {
//                originModel.maxNumStr = @5;
//            }else
//                originModel.maxNumStr = @6;
//        }
        
        if (originModel.maxNumStr)
        {
            if (originModel.maxNumLine != nil)
            {
                NSInteger lineNum = originModel.maxNumLine.intValue;
                NSInteger strNum = originModel.maxNumStr.intValue;
                NSInteger realMaxNum = 1;
                for (int i =0; i<lineNum; i++)
                {
                    if ((i+1)*strNum<titleStr.length-1)
                    {
                        [titleStr insertString:@"\n" atIndex:(i+1)*strNum+i];
                        realMaxNum ++;
                    }else
                        break;
                    
                }
                _titleLB.numberOfLines = realMaxNum;
            }else
            {
                if (originModel.title.length>=originModel.maxNumStr.intValue)
                {
                    [titleStr insertString:@"\n" atIndex:originModel.maxNumStr.intValue];
                    _titleLB.numberOfLines = 2;
                }
            }
        }else
        {
            NSInteger defaultLength = 4;
            if (originModel.title.length>defaultLength+1)
            {
                [titleStr insertString:@"\n" atIndex:defaultLength];
                _titleLB.numberOfLines = 2;
            }
        }
        
        self.titleLB.text =titleStr;
    }
    
    
    if (originModel.remark.length>0)
    {
        //添加备注
        [self layoutRemark];
        
    }
    if (originModel.remarkImg.length>0)
    {
        //添加备注的图片
        [self layoutRemarkImg];
    }
}




-(void)setModel:(HFormModel *)model
{
    _model = model;
    
    //是否禁用操作!
    if (model.isForBidden||(self.isFirstForbiden&&!model.isForBidden))
    {
        self.isFirstForbiden = model.isForBidden;
    }
}

#pragma mark 设置备注
-(void)layoutRemark
{
    UILabel *remarklabel =[UILabel labelWithText:@""
                                            font:hNomalFont
                                       textColor:HFieldPlaceHoldColor
                                 backgroundColor:hClearColor
                                     isSizeToFit:YES];
    remarklabel.text =self.originModel.remark;
    [self addSubview:remarklabel];
    
    WEAK_SELF;
    [_RightV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleV.mas_right);
        make.centerY.height.equalTo(_titleV);
    }];
    [remarklabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_RightV.mas_right);
        make.centerY.height.equalTo(_titleV);
        make.width.lessThanOrEqualTo(@40);
        make.right.equalTo(weakSelf).offset(-HModuleTitleLeft);
    }];
}


-(void)layoutRemarkImg
{
    self.delegate = self.originModel.delegate;
    UIButton *remarkImg = [[UIButton alloc] init];
    [remarkImg addTarget:self action:@selector(remarkAction) forControlEvents:UIControlEventTouchUpInside];
    [remarkImg setImage:[UIImage imageNamed:self.originModel.remarkImg] forState:UIControlStateNormal];//[UIImageManager imageNamed:self.originModel.remarkImg]
    
    [self addSubview:remarkImg];
    
    WEAK_SELF;
    [_RightV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleV.mas_right);
        make.centerY.height.equalTo(_titleV);
    }];
    [remarkImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_RightV.mas_right);
        make.centerY.equalTo(_titleV);
        make.width.height.equalTo(@40);
        make.right.equalTo(weakSelf).offset(-HModuleTitleLeft);
    }];
}
-(void)remarkAction
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addEditItemOnClickRemarkActionWithView:)]) {
        [self.delegate addEditItemOnClickRemarkActionWithView:self];
    }
}

#pragma mark - private

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    [self addSubview:self.titleV];
    [self addSubview:self.titleLB];
    WEAK_SELF;
    [self.titleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weakSelf);
        make.width.equalTo(weakSelf).multipliedBy(HFormTitleRate);
    }];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleV).offset(HCommonVerticalMagin);
        make.top.equalTo(_titleV);
        make.bottom.equalTo(_titleV);
    }];
    
}

#pragma mark - getter
-(UIView *)titleV
{
    if(!_titleV){
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        _titleV = view;
    }
    return _titleV;
}

-(UILabel *)titleLB
{
    if (!_titleLB) {
        UILabel *titlelabel = [UILabel labelWithText:@""
                                                font:hNomalTitleFont
                                           textColor:hBlackFontColor
                                     backgroundColor:hClearColor
                                         isSizeToFit:YES];
        _titleLB = titlelabel;
    }
    return _titleLB;
}

-(UIView *)forbidenView
{
    if (!_forbidenView) {
        UIView *view = [UIView new];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forBidAction)];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:tap];
        view.layer.cornerRadius = 5;
        [self addSubview:view];
        view.backgroundColor = hForbidenFontColor;
        _forbidenView = view;
    }
    return _forbidenView;
}


@end
