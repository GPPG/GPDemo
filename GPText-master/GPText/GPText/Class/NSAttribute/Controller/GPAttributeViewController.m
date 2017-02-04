//
//  GPAttributeViewController.m
//  GPText
//
//  Created by dandan on 16/8/31.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPAttributeViewController.h"
#import "GPAPPViewController.h"

@interface GPAttributeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *oneLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoLabel;
- (IBAction)BtnClick:(UIButton *)sender;

@end

@implementation GPAttributeViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupLabel];
}
#pragma mark - 初始化方法
- (void)setupNav
{
    self.navigationItem.title = @"富文本";
    
}
- (void)setupLabel
{
    // 设置颜色等
    NSMutableDictionary *arrDic = [NSMutableDictionary dictionary];
    arrDic[NSForegroundColorAttributeName] = [UIColor purpleColor];
    arrDic[NSBackgroundColorAttributeName] = [UIColor greenColor];
    arrDic[NSKernAttributeName] = @10;
    arrDic[NSUnderlineStyleAttributeName] = @1;
    
    NSMutableAttributedString *attriOneStr = [[NSMutableAttributedString alloc]initWithString:@"来呀,快活呀,反正有大把时光" attributes:arrDic];
    self.oneLabel.attributedText = attriOneStr;
    
    // 简单的图文混排
    NSMutableAttributedString *arrTwoStr = [[NSMutableAttributedString alloc]init];
    NSMutableAttributedString *TwoChildStr = [[NSMutableAttributedString alloc]initWithString:@"你好啊"];
    [arrTwoStr appendAttributedString:TwoChildStr];
    
    NSTextAttachment *attachMent = [[NSTextAttachment alloc]init];
    attachMent.image = [UIImage imageNamed:@"2"];
    attachMent.bounds = CGRectMake(0, -5, 20, 20);
    NSAttributedString *picStr = [NSAttributedString attributedStringWithAttachment:attachMent];
    [arrTwoStr appendAttributedString:picStr];
    
    NSAttributedString *TwooStr = [[NSAttributedString alloc]initWithString:@"我是小菜鸟"];
    [arrTwoStr appendAttributedString:TwooStr];
    self.twoLabel.attributedText = arrTwoStr;
}

#pragma mark - 事件响应
- (IBAction)BtnClick:(UIButton *)sender {
    GPAPPViewController *AppVc = [[GPAPPViewController alloc]init];
    [self.navigationController pushViewController:AppVc animated:YES];
}
@end
