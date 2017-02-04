//
//  GPProjectController.m
//  GPOnFire
//
//  Created by dandan on 16/3/18.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPProjectController.h"
#import "MJRefresh.h"
#import "GPDIYHeader.h"
#import "GPHttpTool.h"
#import "GPdata.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "GPProjectTableViewCell.h"
#import "GPWebViewController.h"

@interface GPProjectController ()

@property (nonatomic, strong) NSMutableArray *dataS; // 最新模型数组
@property (nonatomic, copy) NSString *nextPage; // 页码
@end

@implementation GPProjectController

static NSString * const GPProjectCell = @"projectCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tablView的样式设置
    [self setupTableView];
    
    [self loadData];
}

- (void)setupTableView
{
    self.tableView.rowHeight = 200;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = GPCommonBgColor;
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(GPNavBarBottom + GPTitlesViewH, 0, GPTabBarH + 40, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"GPProjectTableViewCell" bundle:nil] forCellReuseIdentifier:GPProjectCell];
    
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
    params[@"columnid"] = @"15";
    params[@"offset"] = @"";
    
    __weak typeof(self) weakSelf = self;
    
    // 2.发起请求
    [GPHttpTool get:@"http://www.bbonfire.com/api/news/roll" params:params success:^(id responseObj) {
        
        weakSelf.nextPage = responseObj[@"next_offset"];
        
        // 3.新闻字典数组
        NSArray *dataArray = responseObj[@"data"];
        // 4.字典转模型
        weakSelf.dataS = [GPdata mj_objectArrayWithKeyValuesArray:dataArray];
        GPLog(@"%@",weakSelf.dataS);

        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}

#pragma mark - 数据源

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GPProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GPProjectCell];
    
    cell.data = self.dataS[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
@end
