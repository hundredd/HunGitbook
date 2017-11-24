//
//  WBImageCollectionCell.h
//  WBAssetPickerController
//
//  Created by zwb on 16/1/22.
//  Copyright © 2016年 zwb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface WBImageCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property(nonatomic,strong)PHAsset *asset;//视频信息

@end
