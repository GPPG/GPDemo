//
//  GPTranslationController.m
//  GPOnFire
//
//  Created by dandan on 16/3/18.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTranslationController.h"
#import "GPHttpTool.h"
#import "MJExtension.h"
#import "GPWebViewController.h"
#import "GPNewTableViewCell.h"
#import "GPdata.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "GPDIYHeader.h"
#import "GPDIYFooter.h"

@interface GPTranslationController()

@property (nonatomic, strong) NSMutableArray *dataS; // 最新模型数组
@property (nonatomic, copy) NSString *nextPage; // 页码

@end

static NSString * const GPNewCell = @"newCell";

@implementation GPTranslationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupTablView];
    [self loadData];
}

// 设置tablView的样式
- (void)setupTablView
{
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(GPNavBarBottom + GPTitlesViewH, 0, GPTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"GPNewTableViewCell" bundle:nil] forCellReuseIdentifier:GPNewCell];
    
}

#pragma mark - 数据处理
// 加载数据
- (void)loadData
{
    // 添加下拉刷新控件
    self.tableView.mj_header = [GPDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动调整透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 开始刷新
    [self.tableView.mj_header beginRefreshing];
    
    //    // 添加上拉刷新控件
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.alpha = 0.01;
    
    
}
// 上拉加载数据
- (void)loadMoreData
{
    
    self.tableView.mj_footer.alpha = 1;
    
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fields"] = @"articleid,columnid,ctime,type,comment_total,url,title,summary,thumb,images,images_total";
    params[@"len"] = @"12";
    params[@"focus"] = @"";
    params[@"columnid"] = @"3";
    params[@"offset"] = self.nextPage;
    
    __weak typeof(self) weakSelf = self;
    // 2.发送请求
    [GPHttpTool get:@"http://www.bbonfire.com/api/news/roll" params:params success:^(id responseObj) {
        // 保存下一页的页码
        weakSelf.nextPage = responseObj[@"next_offset"];
        // 1.新闻字典数组
        NSArray *MoredataS = responseObj[@"data"];
        // 2.字典转模型
        NSArray *moredataS = [GPdata mj_objectArrayWithKeyValuesArray:MoredataS];
        
        [weakSelf.dataS addObjectsFromArray:moredataS];
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}

// 下拉加载数据
- (void)loadNewData
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"正在加载数据"];
    // 1.添加请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"fields"] = @"articleid,columnid,ctime,type,comment_total,url,title,summary,thumb,images,images_total";
    params[@"len"] = @"12";
    params[@"focus"] = @"";
    params[@"columnid"] = @"3";
    params[@"offset"] = @"";
    
    __weak typeof(self) weakSelf = self;
    
    // 2.发起请求
    [GPHttpTool get:@"http://www.bbonfire.com/api/news/roll" params:params success:^(id responseObj) {
        
        weakSelf.nextPage = responseObj[@"next_offset"];
        
        // 3.新闻字典数组
        NSArray *dataArray = responseObj[@"data"];
        // 4.字典转模型
        
        weakSelf.dataS = [GPdata mj_objectArrayWithKeyValuesArray:dataArray];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GPNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GPNewCell];
    cell.data = self.dataS[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPdata *data = self.dataS[indexPath.row];
    
    GPWebViewController *webViewVc = [[GPWebViewController alloc] init];
    webViewVc.data = data;
    [self.navigationController pushViewController:webViewVc animated:YES];
}
@end
