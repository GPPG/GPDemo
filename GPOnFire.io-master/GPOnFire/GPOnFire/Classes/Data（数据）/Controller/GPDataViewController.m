//
//  GPDataViewController.m
//  GPOnFire
//
//  Created by dandan on 16/4/2.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDataViewController.h"
#import "GPHttpTool.h"
#import "GPDIYHeader.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "GPCells.h"
#import "GPDataTopic.h"
#import "GPDataTableViewCell.h"

@interface GPDataViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *bgView;
// 上标题
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
// 标题按钮内容
@property (nonatomic, strong) NSMutableArray *titleArray;
// 标题最大的X
@property (nonatomic, assign) CGFloat titleBtnMaxX;
// 上一次的按钮
@property (nonatomic, strong) UIButton *lastBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 手势数字
@property (nonatomic, assign) int gestureIndex;

// 放模型是数组
@property (nonatomic, strong) NSArray *cellsArray;
@property (nonatomic, strong) NSArray *firstArray;

@end

@implementation GPDataViewController

#pragma mark - 懒加载
- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        
        _titleArray = [NSMutableArray arrayWithObjects:@"战绩",@"净胜分",@"得分",@"篮板",@"助攻",@"抢断",@"盖帽",@"命中率",@"三分命中率",@"罚球命中率", nil];
    }
    return _titleArray;
}

#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    [self setupView];
    
    // 添加上标题
    [self addTitleView];
    
    // 数据处理
    [self loadData];
    
    
}
// 初始化View
- (void)setupView
{
    // 设置导航栏标题
    self.navigationItem.title = @"球队";
    self.view.backgroundColor = GPCommonBgColor;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDataTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cccc"];
    
    // 添加右滑手势
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:swipeRightGesture];
    // 添加左滑手势
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
       self.gestureIndex = 0;
    [self.tableView addGestureRecognizer:swipeLeftGesture];
    
    
}
// 添加上标题
- (void)addTitleView
{
    NSInteger titleCoutn = self.titleArray.count;
    CGFloat titleBtnH = self.bgView.height;
    self.topScrollView.frame = CGRectMake(64, 0, self.bgView.width, self.bgView.height);
    for (int i = 0; i < titleCoutn; i ++) {
        
        // 按钮的初始化
        UIButton *titleBtn = [[UIButton alloc] init];
        [titleBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        titleBtn.tag = i;
        // 按钮设置背景色
        [titleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [titleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        // 点击按钮
        [titleBtn addTarget:self action:@selector(dataBtnCiclk:) forControlEvents:UIControlEventTouchUpInside];

        [titleBtn sizeToFit];
        if (i == 0) {
            // 第一次点击按钮
            self.lastBtn = titleBtn;
            titleBtn.selected = YES;
            titleBtn.frame = CGRectMake(-30, -64, titleBtn.width, titleBtnH);
            self.titleBtnMaxX = CGRectGetMaxX(titleBtn.frame);
        }
        
        titleBtn.frame = CGRectMake(self.titleBtnMaxX + 20, -64, titleBtn.width, titleBtnH);
        self.titleBtnMaxX = CGRectGetMaxX(titleBtn.frame);
        [self.topScrollView addSubview:titleBtn];
        
    }
    
     self.topScrollView.contentSize = CGSizeMake(920, -75);
}
#pragma mark - 内部方法
- (void)dataBtnCiclk:(UIButton *)titleBtn
{
    // 改变按钮的状态
    self.lastBtn.selected = NO;
    titleBtn.selected = YES;
    self.lastBtn = titleBtn;

}
// 手势回调
- (void)swipeGesture:(UISwipeGestureRecognizer *)swipeGesture
{
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self.gestureIndex < self.titleArray.count) {
            self.gestureIndex ++;
            GPLog(@"左滑%d",self.gestureIndex);

        }
        
    }else{
        if (self.gestureIndex > 0) {
            self.gestureIndex --;
            GPLog(@"右滑%d",self.gestureIndex);
        }
    }
}

#pragma mark - 数据处理
- (void)loadData
{
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"v"] = @"1459844660.871419";
    [GPHttpTool get:@"http://oss.bbonfire.com/stats/v1/data/qdzj.json" params:parms success:^(id responder) {
        
        // 字典转模型
        self.cellsArray = [GPDataTopic mj_objectArrayWithKeyValuesArray:responder[@"data"]];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellsArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GPDataTopic *data = self.cellsArray[section];
    return data.cells.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cccc"];
    GPDataTopic *data = self.cellsArray[indexPath.section];
    cell.celldata = data.cells[indexPath.row];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    GPDataTopic *data = self.cellsArray[section];
    NSArray *sectionS = data.sectionHeaders;
    NSString *sectionStr = [NSString stringWithFormat:@"%@                     %@               %@                     %@",sectionS[0],sectionS[1],sectionS[2],sectionS[3]];
    return sectionStr;
}



@end
