//
//  ViewController.m
//  Demo
//
//  Created by hun on 2017/11/23.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "ViewController.h"
#import "TargetViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (IBAction)senderAction:(UIButton *)sender
{
    TargetViewController *vc = [TargetViewController new];
    vc.title = sender.titleLabel.text;
    vc.style = sender.tag;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
