//
//  GPRecommendedController.m
//  GPOnFire
//
//  Created by dandan on 16/3/18.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPRecommendedController.h"
#import "GPHttpTool.h"
#import "MJExtension.h"
#import "GPFocus.h"
#import "SDCycleScrollView.h"
#import "GPWebViewController.h"
#import "GPNewTableViewCell.h"
#import "GPdata.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "GPDIYHeader.h"
#import "GPDIYFooter.h"
#import "GPPictureTableViewCell.h"

@interface GPRecommendedController ()<SDCycleScrollViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *imageUrlS; // 轮播图片数组
@property (nonatomic, strong) NSMutableArray *titleS; // 轮播标题数组
@property (nonatomic, strong) NSMutableArray *topicArray; // 轮播图模型数组
@property (nonatomic, strong) NSMutableArray *dataS; // 最新模型数组
@property (nonatomic, copy) NSString *nextPage; // 页码

@end

@implementation GPRecommendedController

static NSString * const GPNewCell = @"newCell";

static NSString * const GPPictureCell = @"pictureCell";

#pragma mark - 懒加载
- (NSMutableArray *)imageUrlS
{
    if (!_imageUrlS) {
        
        _imageUrlS = [NSMutableArray array];
    }
    return _imageUrlS;
}

- (NSMutableArray *)titleS
{
    if (!_titleS) {
        
        _titleS = [NSMutableArray array];
    }
    return _titleS;
}
#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化样式
    [self setupTable];
    
    // 添加刷新控件
    [self loadData];

}


// 初始化样式
- (void)setupTable
{
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(GPNavBarBottom + GPTitlesViewH, 0, GPTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.rowHeight = 100;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"GPNewTableViewCell" bundle:nil] forCellReuseIdentifier:GPNewCell];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"GPPictureTableViewCell" bundle:nil] forCellReuseIdentifier:GPPictureCell];
    
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
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"len"] = @"12";
    param[@"fields"] = @"articleid,columnid,ctime,type,comment_total,url,title,summary,thumb,images,images_total";
    param[@"offset"] = self.nextPage;
    GPLog(@"上拉加载数据%@",self.nextPage);
    param[@"focus"] = @"6";
    param[@"columnid"] = @"1,2,3,12,13,14,16,17,18,19,22";
    
    __weak typeof(self) weakSelf = self;
    // 2.发送请求
    [GPHttpTool get:@"http://www.bbonfire.com/api/news/roll" params:param success:^(id responseObj) {
        // 保存下一页的页码
        weakSelf.nextPage = responseObj[@"next_offset"];
        GPLog(@"二二恶%@",weakSelf.nextPage);
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
    [SVProgressHUD showWithStatus:@"正在加载数据"];
    // 1.添加请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"fields"] = @"articleid,columnid,ctime,type,comment_total,url,title,summary,thumb,images,images_total";
    params[@"len"] = @"12";
    params[@"focus"] = @"6";
    params[@"columnid"] = @"1,2,3,12,13,14,16,17,18,19,22";
    params[@"offset"] = @"";

    __weak typeof(self) weakSelf = self;
    
    // 2.发起请求
    [GPHttpTool get:@"http://www.bbonfire.com/api/news/roll" params:params success:^(id responseObj) {
  
        weakSelf.nextPage = responseObj[@"next_offset"];
        GPLog(@"最新数据%@",weakSelf.nextPage);
        
        // 1.轮播图字典数组
        NSArray *focusArray = responseObj[@"focus"];
        // 2.字典转模型
       weakSelf.topicArray = [GPFocus mj_objectArrayWithKeyValuesArray:focusArray];

        for (GPFocus *topic in self.topicArray) {
            // 初始化图片数组和标题数组
            [weakSelf.imageUrlS addObject:topic.thumb];
            [weakSelf.titleS addObject:topic.title];
        }
            // 添加轮播图
            [weakSelf addCycleView];
        
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

// 初始化Cell
- (void)addCycleView
{
    // 创建轮播图
    CGFloat cycleX = 0;
    CGFloat cycleY = GPNavBarBottom + GPTitlesViewH;
    CGFloat cycleW = self.view.width;
    CGFloat cycleH = 200;
    CGRect rect = CGRectMake(cycleX, cycleY, cycleW, cycleH);
    
    SDCycleScrollView *cycleScorllView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:nil];
    cycleScorllView.imageURLStringsGroup = self.imageUrlS;
    
    // 设置轮播图的样式
    cycleScorllView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScorllView.titlesGroup = self.titleS;
    
    self.tableView.tableHeaderView = cycleScorllView;
}
#pragma mark - 轮播图代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    GPFocus *topic = self.topicArray[index];
    GPWebViewController *webViewVc = [[GPWebViewController alloc] init];
    webViewVc.topic = topic;
    [self.navigationController pushViewController:webViewVc animated:YES];
} 

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPdata *roeData = self.dataS[indexPath.row];
    
    if ([roeData.type isEqualToString:@"4"]) {
        
        GPPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GPPictureCell];
        cell.data = roeData;
        return cell;
    }else{
        GPNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GPNewCell];
        cell.data = self.dataS[indexPath.row];
    
        return cell;
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPdata *data = self.dataS[indexPath.row];
    
    GPWebViewController *webViewVc = [[GPWebViewController alloc] init];
    webViewVc.data = data;
    [self.navigationController pushViewController:webViewVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
GPdata *roeData = self.dataS[indexPath.row];
    if ([roeData.type isEqualToString:@"4"]) {
        
        return 200;
    }else{
        
        return 100;
    }

    
    
}
@end
