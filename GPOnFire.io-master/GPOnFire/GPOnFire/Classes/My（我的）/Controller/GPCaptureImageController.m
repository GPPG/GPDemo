//
//  GPOnFire
//
//  Created by dandan on 16/3/16.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPCaptureImageController.h"

@interface GPCaptureImageController ()
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
- (IBAction)cancleBtn:(UIButton *)sender;
- (IBAction)userBtn:(UIButton *)sender;

@end

@implementation GPCaptureImageController

+(instancetype)captureImage
{
    return [UIStoryboard storyboardWithName:@"GPCaptureImageController" bundle:nil].instantiateInitialViewController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    
    self.selectImageView.image = self.selectImage;
    
    // 添加所有的手势
    [self addGestureRecognizerToView:self.selectImageView];
}

#pragma mark - 手势方法

// 添加所有的手势方法
-(void)addGestureRecognizerToView:(UIImageView *)imageView
{
    // 1.添加旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationView:)];
    [imageView addGestureRecognizer:rotationGestureRecognizer];
    // 2.添加缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [imageView addGestureRecognizer:pinchGestureRecognizer];
    // 3.添加移动手势
    UIPanGestureRecognizer *panGestureRecongnizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView:)];
    [imageView addGestureRecognizer:panGestureRecongnizer];

}
// 旋转手势回调
- (void)rotationView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.selectImageView.transform = CGAffineTransformRotate(self.selectImageView.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];

    }
    
}
// 缩放手势
- (void)pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.selectImageView.transform = CGAffineTransformScale( self.selectImageView.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
    
}
// 拖拽手势
- (void)panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:self.selectImageView.superview];
        [self.selectImageView setCenter:(CGPoint){self.selectImageView.center.x + translation.x, self.selectImageView.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:self.selectImageView.superview];
    }

}
#pragma mark - 私有方法
- (IBAction)cancleBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)userBtn:(UIButton *)sender {
    
    // 1.设置裁剪区域
    CGFloat W = self.view.bounds.size.width;
    GPLog(@"%f",W);
    CGRect clipR = CGRectMake(0, 150, W, W);
    // 2.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(W, W), NO, 0);
    // 3.画图片
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:clipR];
    [path addClip];
    
    [self.selectImageView.image drawAtPoint:CGPointMake(0, 150)];
    
    // 4.从上下文中获取图片
    UIImage *userImage = UIGraphicsGetImageFromCurrentImageContext();
    // 5.关闭上下文
    UIGraphicsEndImageContext();
    
    self.userImage = userImage;
    
    GPLog(@"%f,%f",userImage.size.width,userImage.size.height);
    
    if ([self.delegate respondsToSelector:@selector(captureImageViewUserBtnCiclk:)]) {
        
        [self.delegate captureImageViewUserBtnCiclk:self];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
@end
