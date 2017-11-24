//
//  WBImageCollectionCell.m
//  WBAssetPickerController
//
//  Created by zwb on 16/1/22.
//  Copyright © 2016年 zwb. All rights reserved.
//

#import "WBImageCollectionCell.h"

@interface WBImageCollectionCell()
@property (weak, nonatomic) IBOutlet UILabel *detailLB;


@end

@implementation WBImageCollectionCell

-(void)setAsset:(PHAsset *)asset
{
    _asset = asset;
    self.detailLB.text = [self getMMSSFromSS:asset.duration];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    NSString *selectImageUrl = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"WBImagePicker.bundle/image/select.png"];
    NSString *unSelectImageUrl = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"WBImagePicker.bundle/image/unselect.png"];
    
//
    [self.selectButton setImage:[UIImage imageWithContentsOfFile:unSelectImageUrl] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageWithContentsOfFile:selectImageUrl] forState:UIControlStateSelected];
//    [self.selectButton setImage:[UIImageManager imageNamed:@"activity_icon_single_unselected-拷贝"] forState:UIControlStateNormal];
//    [self.selectButton setImage:[UIImageManager imageNamed:@"activity_icon-_single_selected-"] forState:UIControlStateSelected];
}


-(NSString *)getMMSSFromSS:(NSInteger)totalTime{
    
    NSInteger seconds = totalTime;
    
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@分%@秒",str_minute,str_second];
    
    NSLog(@"format_time : %@",format_time);
    
    return format_time;
}



@end
