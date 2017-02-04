//
//  GPTabBarViewController.m
//  GPOnFire
//
//  Created by dandan on 16/3/15.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTabBarViewController.h"
#import "GPNewsViewController.h"
#import "GPEquipmentTableViewController.h"
#import "GPFanTableViewController.h"
#import "GPMyTableViewController.h"
#import "GPNavigationController.h"
#import "GPDataViewController.h"

@interface GPTabBarViewController ()

@end

@implementation GPTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加所有的子控制器
    [self setUpChildVcs];
    
}

// 添加所有的子控制器
- (void)setUpChildVcs
{
    
    // 1.添加新闻控制器
    [self addOneChildVc:[[GPNavigationController alloc] initWithRootViewController:[[GPNewsViewController alloc] init]]title:@"新闻" iamgeName:@"tabIcon1" SelecImageName:@"tabIcon1_highlight"];
    // 2.添加装备控制器
    [self addOneChildVc:[[GPNavigationController alloc] initWithRootViewController:[[GPEquipmentTableViewController alloc] init]]title:@"装备" iamgeName:@"tabIcon2" SelecImageName:@"tabIcon2_highlight"];
    // 3.添加数据控制器
    
   
    
    [self addOneChildVc:[[GPNavigationController alloc] initWithRootViewController: [UIStoryboard storyboardWithName:@"GPDataViewController" bundle:nil].instantiateInitialViewController] title:@"数据" iamgeName:@"tabIcon3" SelecImageName:@"tabIcon3_highlight"];
    // 4.添加范特西控制器
    [self addOneChildVc:[[GPNavigationController alloc] initWithRootViewController:[[GPFanTableViewController alloc] init]]title:@"范特西" iamgeName:@"tabIcon4" SelecImageName:@"tabIcon4_highlight"];
    // 5.添加我控制器
    [self addOneChildVc:[[GPNavigationController alloc] initWithRootViewController:[GPMyTableViewController myTableViewController]]title:@"我的" iamgeName:@"tabIcon5" SelecImageName:@"tabIcon5_highlight"];
}

// 添加一个子控制器
- (void)addOneChildVc:(UIViewController *)ViewComtroller title:(NSString *)title iamgeName:(NSString *)imageName SelecImageName:(NSString *)SelecIamgeName
{
    ViewComtroller.title = title;
    ViewComtroller.tabBarItem.image = [UIImage imageNamed:imageName];
    ViewComtroller.tabBarItem.selectedImage = [UIImage imageNamed:SelecIamgeName];
    [self addChildViewController:ViewComtroller];
    
}

@end
