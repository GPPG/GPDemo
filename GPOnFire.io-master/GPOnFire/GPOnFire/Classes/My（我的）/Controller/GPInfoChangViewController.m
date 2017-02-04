//
//  GPInfoChangViewController.m
//  GPOnFire
//
//  Created by dandan on 16/3/17.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPInfoChangViewController.h"
#import "GPCaptureImageController.h"

@interface GPInfoChangViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,GPCaptureImageViewDelagate>

@property (weak, nonatomic) IBOutlet UIButton *loginBtn; // 确定按钮
@property (weak, nonatomic) IBOutlet UITextField *nameText; // 选择用户名
- (IBAction)setupHeadImageBtn:(UIButton *)sender; // 添加头像
@property (weak, nonatomic) IBOutlet UIButton *headImageBtn;
@property (weak, nonatomic) IBOutlet UITextField *sexText; // 选择性别
@end

@implementation GPInfoChangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];

  
}

// 设置导航栏
- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.title = @"信息修改";
    
}
#pragma mark - 设置头像

- (IBAction)setupHeadImageBtn:(UIButton *)sender {
    
    // 1.创建弹窗控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 2.添加行动
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changPhots];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamor];
    }]];
    // 3.弹出控制器
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)changPhots
{
    // 1.打开相册
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    
    [self presentViewController:pickerController animated:YES completion:nil];
}

-(void)openCamor
{
    // 1.打开相机
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
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
- (void)captureImageViewUserBtnCiclk:(GPCaptureImageController *)GPCaptureVc
{
    
    [self.headImageBtn setImage:GPCaptureVc.userImage.circleImage forState:UIControlStateNormal];
}
@end
