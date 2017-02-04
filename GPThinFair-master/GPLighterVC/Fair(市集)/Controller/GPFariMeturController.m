//
//  GPFariMeturController.m
//  GPHandMade
//
//  Created by dandan on 16/7/12.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFariMeturController.h"
#import "GPJianDaoHeader.h"
#import "GPAutoFooter.h"
#import "GPFairHotCell.h"
#import "GPFairBestCell.h"
#import "GPFariTopicCell.h"
#import "GPFariTopicBestCell.h"
#import "GPFariParmer.h"
#import "GPFariData.h"
#import "GPFariHotData.h"
#import "GPFariBestData.h"
#import "GPFariTopicData.h"
#import "GPFariNetwork.h"
#import <SVProgressHUD.h>
#import "GPFairSectionHeadView.h"
#import "GPWebViewController.h"
#import "GPFairArrayDataSource.h"
#import "GPFairDelegate.h"



static NSString * const fariId = @"FariCell";
static NSString * const fariBestId = @"FairBestCell";
static NSString * const fariTopicBestId = @"FariTopicBestCell";
static NSString * const fariTopicId = @"FariTopicCell";
static NSString * const fairHeadID = @"FairHeadView";

@interface GPFariMeturController ()
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *bestArray;
@property (nonatomic, strong) NSMutableArray *topicBestArray;
@property (nonatomic, strong) NSMutableArray *topicArray;
@property (nonatomic, copy) NSString *lastId;
@property (nonatomic, strong) GPFairArrayDataSource *fairDataSource;
@property (nonatomic, strong) GPFairDelegate *fairDelegate;

@end



@implementation GPFariMeturController

#pragma mark - 生命周期
- (instancetype)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setView];
    [self loadData];
    [self regisCell];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - 初始化方法
- (void)setView
{
    self.fairDelegate = [[GPFairDelegate alloc]init];
    self.collectionView.delegate = self.fairDelegate;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
}
- (void)setupCollectionView
{
    CollectionViewCellConfigureBlock configureHotCell = ^(GPFairHotCell *hotCell,GPFariHotData *hotData){
        [hotCell configureForData:hotData];
    };
    CollectionViewCellConfigureBlock configureBestCell = ^(GPFairBestCell *bestCell,GPFariBestData *BestData){
        [bestCell configureForData:BestData];
    };
    CollectionViewCellConfigureBlock configureTopicBestCell = ^(GPFariTopicBestCell *TopicBestCell,NSString *picStr){
        [TopicBestCell configureForData:picStr];
    };
    CollectionViewCellConfigureBlock configureTopicCell = ^(GPFariTopicCell *topicCell,GPFariTopicData *topicData){
        [topicCell configureForData:topicData];
    };
    self.fairDataSource = [[GPFairArrayDataSource alloc]init];
    self.fairDataSource.cellModeArray = @[self.hotArray,self.bestArray,self.topicBestArray,self.topicArray];
    self.fairDataSource.CellIDArray = @[fariId,fariBestId,fariTopicBestId,fariTopicId];
    self.fairDataSource.cellBlockArray = @[configureHotCell,configureBestCell,configureTopicBestCell,configureTopicCell];
    self.collectionView.dataSource = self.fairDataSource;
    
}

- (void)regisCell
{
    SBRegis(GPFairHotCell, fariId);
    SBRegis(GPFairBestCell, fariBestId);
    SBRegis(GPFariTopicBestCell, fariTopicBestId);
    SBRegis(GPFariTopicCell, fariTopicId);
    SBRegisHead(GPFairSectionHeadView,fairHeadID);
}
#pragma mark - 数据处理
- (void)loadData
{
    // 添加下拉刷新
    GPJianDaoHeader *Header = [self addRefreshHead];
    self.collectionView.mj_header = Header;
    // 添加上拉刷新
    self.collectionView.mj_footer = [GPAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
- (GPJianDaoHeader *)addRefreshHead
{
    // 添加下拉刷新
    GPJianDaoHeader *header = [GPJianDaoHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [header beginRefreshing];
    return  header;
}
- (void)loadNewData
{
    __weak typeof(self) weakSelf = self;
    GPFariParmer *parmers = [[GPFariParmer alloc]init];
    parmers.c = @"Shiji";
    parmers.vid = @"18";
    parmers.a = self.product;
    [GPFariNetwork fariDataWithParms:parmers success:^(GPFariData *fariData) {
        weakSelf.hotArray = [NSMutableArray arrayWithArray:fariData.hot];
        weakSelf.bestArray = [NSMutableArray arrayWithArray:fariData.best];
        weakSelf.topicBestArray = [NSMutableArray arrayWithArray:fariData.topicBest];
        weakSelf.topicArray = [NSMutableArray arrayWithArray:fariData.topic];
        GPFariTopicData *topicData = weakSelf.topicArray.lastObject;
        weakSelf.lastId = topicData.last_id;
        [weakSelf setupCollectionView];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    } failuer:^(NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        NSString *errors = [NSString stringWithFormat:@"%@",error];
        NSLog(@"%@",errors);
        [SVProgressHUD showErrorWithStatus:errors];
    }];
}

- (void)loadMoreData
{
    GPFariParmer *parmers = [[GPFariParmer alloc]init];
    parmers.c = @"Shiji";
    parmers.vid = @"18";
    parmers.last_id = self.lastId;
    parmers.a = @"topicList";
    parmers.page = self.page;
    __weak typeof(self) weakSelf = self;
    [GPFariNetwork fariMoreDataWithParms:parmers success:^(NSArray *topicDataS) {
        [weakSelf.topicArray addObjectsFromArray:topicDataS];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_footer endRefreshing];
    } failuer:^(NSError *error) {
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}


@end
