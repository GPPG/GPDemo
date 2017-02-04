//
//  GPSettingTableViewController.m
//  GPOnFire
//
//  Created by dandan on 16/3/15.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSettingTableViewController.h"

@interface GPSettingTableViewController ()

@end

@implementation GPSettingTableViewController

// 返回设置控制器
+ (instancetype)settingViewController
{
    return [UIStoryboard storyboardWithName:@"GPSettingTableViewController" bundle:nil].instantiateInitialViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.sectionHeaderHeight = 10;

}
- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

@end
