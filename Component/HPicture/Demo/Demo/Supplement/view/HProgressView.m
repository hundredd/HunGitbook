//
//  HProgressView.m
//  QHZC
//
//  Created by hun on 2017/11/16.
//  Copyright © 2017年 QHJF. All rights reserved.
//

#import "HProgressView.h"

#define kProgressWidth kScreenWidth*0.8
#define kProgressHeight 10

@interface HProgressView ()
@property(nonatomic,strong)UIView *backV ;         //蒙版
@property(nonatomic,strong)HProgressItem * progressV;   //整个进度视图

@property(nonatomic,assign)float process ;//进度情况!
@end


@implementation HProgressView

-(void)setProcess:(float)process
{
    _process = process;
    self.progressV.process = process;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
        [self setupUI];
    }
    return self;
}


-(void)setupUI
{
    [self addSubview:self.backV];
    [self addSubview:self.progressV];
    WEAK_SELF;
    [self.backV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [self.progressV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(HCommonVerticalMagin);
        make.right.equalTo(weakSelf).offset(-HCommonVerticalMagin);
    }];
    
    
}

-(HProgressItem *)progressV
{
    if (!_progressV) {
        _progressV = [HProgressItem new];
        
        _progressV.backgroundColor = hWhiteTextColor;
        WEAK_SELF;
        __weak typeof(_progressV) tmp;
        _progressV.finishHide = ^{
            weakSelf.hidden = YES;
            tmp.process = 0;
        };
    }
    return _progressV;
}

-(UIView *)backV
{
    if (!_backV) {
        _backV = [UIView new];
        _backV.backgroundColor = hBlackFontColor;
        _backV.alpha = 0.7;
    }
    return _backV;
}



@end



@interface HProgressItem ()
@property(nonatomic,strong)UILabel *titleLB ;//显示字幕
@property(nonatomic,strong)UIView *backV;//进度条后面背景
@property(nonatomic,strong)UIView *progressV;//进度条后面背景
@property(nonatomic,strong)UILabel *progressNumLB ;//显示进度情况
@property (nonatomic, strong)UIProgressView *progressView;

@end
@implementation HProgressItem

-(void)setProcess:(float)process
{
    _process = process;
    self.progressNumLB.text = [NSString stringWithFormat:@"%.2f%%",process*100];
    if (process == 0) {
        [self.progressView setProgress:process animated:YES];
    }else{
        [self.progressView setProgress:process animated:YES];

        if (process>=1)
        {
//                self.progressV.frame = self.backV.frame;
            //目前没有解决没有画完的问题
            if (self.finishHide) {
                self.finishHide();
            }
        }

        
    }
}

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
    [self addSubview:self.titleLB];
    [self addSubview:self.progressNumLB];
//    [self addSubview:self.backV];
//    [self addSubview:self.progressV];
    [self addSubview:self.progressView];
    
    WEAK_SELF;
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).offset(HCommonVerticalMagin);
    }];
    [self.progressNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.titleLB);
        make.top.equalTo(weakSelf.titleLB.mas_bottom).offset(HCommonVerticalMagin);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.titleLB);
        make.top.equalTo(weakSelf.progressNumLB.mas_bottom).offset(HCommonVerticalMagin);
        make.width.mas_equalTo(kProgressWidth);
        make.height.mas_equalTo(kProgressHeight);
        make.bottom.equalTo(weakSelf).offset(-3*HCommonVerticalMagin);
    }];
//    [self.backV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakSelf.titleLB);
//        make.top.equalTo(weakSelf.progressNumLB.mas_bottom).offset(HCommonVerticalMagin);
//        make.width.mas_equalTo(kProgressWidth);
//        make.height.mas_equalTo(kProgressHeight);
//        make.bottom.equalTo(weakSelf).offset(-3*HCommonVerticalMagin);
//    }];
//    [self.progressV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.equalTo(weakSelf.backV);
//        make.height.mas_equalTo(kProgressHeight);
//        make.width.mas_equalTo(0);
//    }];
    
}


-(UIView *)backV
{
    if (!_backV) {
        _backV = [UIView new];
        _backV.backgroundColor = hLightBlackGrayColor;
    }
    return _backV;
}
-(UIView *)progressV
{
    if (!_progressV) {
        _progressV = [UIView new];
        _progressV.backgroundColor = hBlueTextColor;
    }
    return _progressV;
}

- (UIProgressView *)progressView {
    
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
//        _progressView.frame = (CGRect){0,0,kProgressWidth,kProgressHeight};
//        _progressView.backgroundColor = hLightBlackGrayColor;
        _progressView.trackTintColor = hLightBlackGrayColor;
        _progressView.tintColor = hBlueTextColor;
        _progressView.progress = 0.0f;
        //更改进度条高度
//        _progressView.transform = CGAffineTransformMakeScale(1.0f,kProgressHeight);
    }
    
    return _progressView;
}

-(UILabel *)titleLB
{
    if (!_titleLB) {
        UILabel *title = nil;
        NSString *titleStr = @"视频压缩中\n压缩完将自动保存到本地并上传";
        if (IS_IPHONE_5) {
            title = [UILabel labelWithText:titleStr
                                      font:hSmallFont
                                 textColor:hDefaultBlackFontColor
                           backgroundColor: [UIColor clearColor]
                               isSizeToFit:YES];
        }else
        {
            title = [UILabel labelWithText:titleStr
                                      font:hNomalFont
                                 textColor:hDefaultBlackFontColor
                           backgroundColor: [UIColor clearColor]
                               isSizeToFit:YES];
        }
        
        
        
        title.textAlignment = NSTextAlignmentCenter;
        title.numberOfLines = 0;
        _titleLB = title;
    }
    return _titleLB;
}

-(UILabel *)progressNumLB
{
    if (!_progressNumLB) {
        UILabel *title = nil;
        if (IS_IPHONE_5) {
            title = [UILabel labelWithText:@"0%"
                                      font:hSmallFont
                                 textColor:hDefaultBlackFontColor
                           backgroundColor: [UIColor clearColor]
                               isSizeToFit:YES];
        }else
        {
            title = [UILabel labelWithText:@"0%"
                                      font:hNomalFont
                                 textColor:hDefaultBlackFontColor
                           backgroundColor: [UIColor clearColor]
                               isSizeToFit:YES];
        }
        
        
        
        title.textAlignment = NSTextAlignmentCenter;
        _progressNumLB = title;
    }
    return _progressNumLB;
}




@end

