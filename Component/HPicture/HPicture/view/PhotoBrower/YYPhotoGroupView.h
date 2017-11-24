//
//  YYPhotoGroupView.h
//
//  Created by ibireme on 14/3/9.
//  Copyright (C) 2014 ibireme. All rights reserved.
//

#import <UIKit/UIKit.h>


/// Single picture's info.
@interface YYPhotoGroupItem : NSObject

/// 
@property (nonatomic, strong) UIView	*thumbView;
@property (nonatomic, assign) CGSize	largeImageSize;
@property (nonatomic, strong) NSURL		*largeImageURL;

@end


@interface YYPhotoGroupView : UIView

@property (nonatomic, readonly) NSArray		*groupItems;
@property (nonatomic, readonly) NSInteger	currentPage;
@property (nonatomic, assign)	BOOL		blurEffectBackground;


/// 禁用一下实例方法
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;


- (instancetype)initWithGroupItems:(NSArray *)groupItems;


- (void)presentFromNomalImageView:(UIView *)fromView
                      toContainer:(UIView *)toContainer
                         animated:(BOOL)animated
                       completion:(void (^)(void))completion;
//这是专门给picture专门设计的弹出窗体
- (void)presentFromImageView:(UIView *)fromView
                 toContainer:(UIView *)container
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion;

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (void)dismiss;

@end
