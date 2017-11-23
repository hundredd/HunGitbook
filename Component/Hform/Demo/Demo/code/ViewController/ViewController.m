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
    switch (sender.tag)
    {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
