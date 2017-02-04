//
//  GPEquipmentCollectionViewController.m
//  GPOnFire
//
//  Created by dandan on 16/4/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEquipmentCollectionViewController.h"
#import "GPCollectionViewCell.h"
#import "MJRefresh.h"
#import "GPDIYHeader.h"
#import "GPHttpTool.h"
#import "GPdata.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "GPWebViewController.h"

@interface GPEquipmentCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *dataS; // 最新模型数组
@property (nonatomic, copy) NSString *nextPage; // 页码
@end

@implementation GPEquipmentCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
    [self setCollectionView];
    // 添加刷新控件
    [self addloader];
    
}

// 初始化
- (void)setCollectionView
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"GPCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    if (self.Btntag == 33) {
        self.navigationItem.title = @"新品速递";
    }else if (self.Btntag == 37){
        self.navigationItem.title = @"人人爱剧透";
    }else if (self.Btntag == 36){
        self.navigationItem.title = @"女神爱篮球";
    }else if (self.Btntag == 34){
        self.navigationItem.title = @"测试拆解";
    }else{
       self.navigationItem.title = @"懂鞋帝";
    }
    
}

#pragma mark - 数据处理
// 添加刷新控件
- (void)addloader
{
    
    // 添加下拉刷新控件
    self.collectionView.mj_header = [GPDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动调整透明度
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    // 开始刷新
    [self.collectionView.mj_header beginRefreshing];
    
    //    // 添加上拉刷新控件
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.mj_footer.alpha = 0.01;
    
}
// 上拉加载数据
- (void)loadMoreData
{
    
    self.collectionView.mj_footer.alpha = 1;
    
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
   
    params[@"len"] = @"12";
    NSString *colStr = [NSString stringWithFormat:@"%ld",(long)self.Btntag];
    params[@"columnid"] = colStr;
    params[@"columnid"] = colStr;
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
        
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
    
}

// 下拉加载数据
- (void)loadNewData
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"正在加载数据"];
    // 1.添加请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
   
    params[@"len"] = @"12";
    
    NSString *colStr = [NSString stringWithFormat:@"%ld",self.Btntag];
    
    params[@"columnid"] = colStr;
    params[@"offset"] = @"";
    GPLog(@"%ld",self.Btntag);

    __weak typeof(self) weakSelf = self;
    
    // 2.发起请求
    [GPHttpTool get:@"http://www.bbonfire.com/api/news/roll" params:params success:^(id responseObj) {
        
        weakSelf.nextPage = responseObj[@"next_offset"];
        // 3.新闻字典数组
        NSArray *dataArray = responseObj[@"data"];
        // 4.字典转模型
        
        weakSelf.dataS = [GPdata mj_objectArrayWithKeyValuesArray:dataArray];
        
        [self.collectionView reloadData];
        
        [SVProgressHUD dismiss];
        [weakSelf.collectionView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
    
}




#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataS.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.data = self.dataS[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GPdata *data = self.dataS[indexPath.row];
    
    GPWebViewController *webViewVc = [[GPWebViewController alloc] init];
    webViewVc.data = data;
    [self.navigationController pushViewController:webViewVc animated:YES];
    
    
}


@end
