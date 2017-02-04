//
//  GPWebViewController.m
//  GPOnFire
//
//  Created by dandan on 16/3/24.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPWebViewController.h"
#import "GPFocus.h"
#import "GPdata.h"
#import "GPEquipmentLates.h"

@interface GPWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *articWebView;
@end

@implementation GPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.articWebView.scalesPageToFit = YES;
}
#pragma mark - 内部方法
- (void)setTopic:(GPFocus *)topic
{
    _topic = topic;
    
    [self loadWebView:nil articleString:topic.articleid];
}

-(void)setData:(GPdata *)data
{
    _data = data;
    
    
    [self loadWebView:data.url articleString:data.articleid];
}
- (void)setLates:(GPEquipmentLates *)lates
{
    _lates = lates;
    [self loadWebView:nil articleString:lates.articleid];
}
// 加载网页
- (void)loadWebView:(NSString *)VoideUrl articleString:(NSString *)articleString
{
    if (VoideUrl.length != 0) {
        NSURL *url  = [NSURL URLWithString:VoideUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.view addSubview:self.articWebView];
        [self.articWebView loadRequest:request];
    }else{
        
        NSString *urlString = [NSString stringWithFormat:@"http://article.bbonfire.com/detail/%@?__from=app&__appVersion=1.4.3",articleString];
        
        NSURL *url  = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [self.view addSubview:self.articWebView];
        [self.articWebView loadRequest:request];
    }

    
}
@end
