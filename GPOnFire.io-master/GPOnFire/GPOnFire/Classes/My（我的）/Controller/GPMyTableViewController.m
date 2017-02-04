//
//  GPMyTableViewController.m
//  GPOnFire
//  Created by dandan on 16/3/15.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPMyTableViewController.h"
#import "GPSettingTableViewController.h"
#import "GPCaptureImageController.h"
#import "GPInfoChangViewController.h"
#define HeadBtnScalW 0.5
#define HeadBtnScalH 0.7

@interface GPMyTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,GPCaptureImageViewDelagate>

@property (nonatomic,strong) UIImageView *headImageView; // 头像背景
@property (nonatomic,strong) UIButton *headBtn; // 头像

@end

@implementation GPMyTableViewController

+(instancetype)myTableViewController
{
    return [UIStoryboard storyboardWithName:@"GPMyTableViewController" bundle:nil].instantiateInitialViewController;
}
#pragma mark - 懒加载
- (UIImageView *)headImageView
{
    if (!_headImageView) {
        
        // 初始化图片
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"backgroundImage1"];
        [_headImageView sizeToFit];
        _headImageView.userInteractionEnabled = YES;
        // 为图片添加点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageViewChang)];
        [_headImageView addGestureRecognizer:tapGesture];

        [_headImageView addSubview: self.headBtn];
    }
    return _headImageView;
}

- (UIButton *)headBtn
{
    _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headBtn setImage:[UIImage imageNamed:@"defaultPlayerIcon"] forState:UIControlStateNormal];
    [_headBtn sizeToFit];
    _headBtn.centerX = self.view.bounds.size.width * HeadBtnScalW;
    _headBtn.centerY = _headImageView.height *HeadBtnScalH;
    _headBtn.layer.cornerRadius = 45;
    [_headBtn addTarget:self action:@selector(infoChang) forControlEvents:UIControlEventTouchUpInside];
    return _headBtn;
}
#pragma mark - 初始化设置

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏样式
    [self setupNav];
    // 初始化背景
    self.tableView.tableHeaderView = self.headImageView;
    self.tableView.contentInset = UIEdgeInsetsMake(-120, 0, 0, 0);
}

// 设置导航栏样式
- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    

    // 设置右上角
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine-setting-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(settingController)];
    
}
// 跳转到设置界面
- (void)settingController
{
    [self.navigationController pushViewController:[GPSettingTableViewController settingViewController] animated:YES];

}
#pragma mark - 内部方法回调
// 信息设置
- (void)infoChang
{
   
    GPInfoChangViewController *infoViewController = [[GPInfoChangViewController alloc]init];
    [self.navigationController pushViewController:infoViewController animated:YES];
    
}
// 头像背景改变
- (void)ImageViewChang
{
    // 1.创建弹窗控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 2.添加行动
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"更换封面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhtons];
    }]];
    
    // 3.弹出控制器
    [self presentViewController:alertController animated:YES completion:nil];
    
}

// 打开相册
- (void)openPhtons
{
    // 1.打开相册
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark - 图片选择器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
    
    GPCaptureImageController *captureVc = [GPCaptureImageController captureImage];
    captureVc.selectImage = selectImage;
    captureVc.delegate = self;
    [picker pushViewController:captureVc animated:YES];
}
#pragma mark - 裁剪图片的代理
- (void)captureImageViewUserBtnCiclk:(GPCaptureImageController *)GPCaptureVc
{
    self.headImageView.image = GPCaptureVc.userImage;
    
}



@end
