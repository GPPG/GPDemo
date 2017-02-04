//
//  ViewController.m
//  GPLighterVC
//
//  Created by dandan on 16/8/2.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "ViewController.h"
#import "GPFairTableViewController.h"

@interface ViewController ()
- (IBAction)fatBtnClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)fatBtnClick:(id)sender {
    
    GPFairTableViewController *fairVc = [[GPFairTableViewController alloc]init];
    [self.navigationController pushViewController:fairVc animated:YES];
}
@end
