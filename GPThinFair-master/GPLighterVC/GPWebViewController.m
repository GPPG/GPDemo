//
//  GPWebViewController.m
//  GPHandMade
//
//  Created by dandan on 16/5/21.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPWebViewController.h"
#import "GPFariHotData.h"

@interface GPWebViewController()<UIWebViewDelegate,UIScrollViewDelegate>

@end
@implementation GPWebViewController

-(void)viewDidLoad{
    [super viewDidLoad];

    [self configNav];
}
#pragma mark - 初始化设置
- (void)configNav
{
    self.loadWebView.scalesPageToFit = YES;
    self.loadWebView.backgroundColor = [UIColor whiteColor];
    self.loadWebView.scrollView.delegate = self;
    self.loadWebView.scrollView.bounces = NO;
}
#pragma mark - 数据处理
- (void)setHotData:(GPFariHotData *)hotData
{
    _hotData = hotData;
    if (hotData.special_id.length) {
        [self loadSlidDataType:hotData.special_id title:@"专题详情"];}
}
- (void)loadSlidDataType:(NSString *)urlString title:(NSString *)title
{
    NSURL *url = [NSURL URLWithString:urlString];
    [self.view addSubview:self.loadWebView];
    [self.loadWebView loadRequest:[NSURLRequest requestWithURL:url]];
    self.navigationItem.title = title;
}
@end
