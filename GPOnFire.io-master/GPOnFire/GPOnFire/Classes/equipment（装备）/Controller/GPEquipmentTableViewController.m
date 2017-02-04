//
//  GPEquipmentTableViewController.m
//  GPOnFire
//
//  Created by dandan on 16/3/15.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEquipmentTableViewController.h"
#import "GPEquipmentTableViewCell.h"
#import "GPDIYHeader.h"
#import "MJRefresh.h"
#import "GPHttpTool.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "GPEquipmentData.h"
#import "GPEquipmentCollectionViewController.h"

static NSString * const equipMentCell = @"equipmentCell";

@interface GPEquipmentTableViewController ()<GPEquipmentTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataS; // 最新模型数组
@end

@implementation GPEquipmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化设置
    [self setNav];
    // 加载数据
    [self loadData];
}

-(void)loadData
{
    // 添加下拉刷新控件
    self.tableView.mj_header = [GPDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动调整透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 开始刷新
    [self.tableView.mj_header beginRefreshing];
    
}

// 初始化设置
- (void)setNav
{
    // 设置导航栏标题
    self.navigationItem.title = @"装备";
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GPEquipmentTableViewCell" bundle:nil] forCellReuseIdentifier:equipMentCell];
    
    self.tableView.rowHeight = 200;
}


// 下拉加载数据
- (void)loadNewData
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"正在加载数据"];
    // 1.添加请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"p"] = @"article";
    
    __weak typeof(self) weakSelf = self;
    
    // 2.发起请求
    [GPHttpTool get:@"http://www.bbonfire.com/api/column/equip_news" params:params success:^(id responseObj) {
        
        // 3.新闻字典数组
        NSArray *dataArray = responseObj[@"data"];
        // 4.字典转模型
        weakSelf.dataS = [GPEquipmentData mj_objectArrayWithKeyValuesArray:dataArray];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    GPEquipmentTableViewCell *tbCell = [tableView dequeueReusableCellWithIdentifier:equipMentCell];
    tbCell.data = self.dataS[indexPath.row];
    tbCell.delegate = self;
    return tbCell;
}

#pragma mark - GPEquipmentTableViewCellDelegate
- (void)equiomentCellDidClickMoreButton:(UIButton *)moreBtn
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat W = self.view.width * 0.46;
    layout.itemSize = CGSizeMake(W, 150);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    

    GPEquipmentCollectionViewController *equipVc = [[GPEquipmentCollectionViewController alloc] initWithCollectionViewLayout:layout];
    
    equipVc.Btntag = moreBtn.tag;
    
    [self.navigationController pushViewController:equipVc animated:YES];    
}


@end
