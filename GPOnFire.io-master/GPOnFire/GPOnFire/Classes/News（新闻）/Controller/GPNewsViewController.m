//
//  GPNewsTableViewController.m
//  GPOnFire
//
//  Created by dandan on 16/3/15.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPNewsViewController.h"
#import "GPRecommendedController.h"
#import "GPColumnController.h"
#import "GPTranslationController.h"
#import "GPPictureController.h"
#import "GPVideoController.h"
#import "GPProjectController.h"
#import "GPTitleBtn.h"

@interface GPNewsViewController ()<UIScrollViewDelegate>

/** 当前被选中的标题按钮 */
@property (nonatomic, weak) GPTitleBtn *selectedTitleButton;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *titleBtnArray;
@property (nonatomic, weak) UIView *titleIndicatorView;
@end

@implementation GPNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    [self addChildVc];
    // 初始化导航栏
    [self setupNav];
    // 添加UIScrollview
    [self setupScrollView];
    // 添加标题栏
    [self setupTitleView];
    
    // 添加子控制器的View
    [self addChildView];
}
#pragma mark - 懒加载
- (NSMutableArray *)titleBtnArray
{
    if (!_titleBtnArray) {
        
        _titleBtnArray = [[NSMutableArray alloc] init];
    }
    return _titleBtnArray;
}

#pragma mark - 初始化方法
// 添加子控制器
- (void)addChildVc
{
    
    GPRecommendedController *recomment = [[GPRecommendedController alloc] init];
    recomment.title = @"推荐";
    [self addChildViewController:recomment];

    
    GPColumnController *column = [[GPColumnController alloc] init];
    column.title = @"专栏";
    [self addChildViewController:column];
    
    GPTranslationController *translation = [[GPTranslationController alloc] init];
    translation.title = @"精译";
    [self addChildViewController:translation];
    
    GPProjectController *project = [[GPProjectController alloc] init];
    project.title = @"专题";
    [self addChildViewController:project];
    
    GPVideoController *video = [[GPVideoController alloc] init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    GPPictureController *picture = [[GPPictureController alloc] init];
    picture.title = @"高清图";
    [self addChildViewController:picture];
    
    
    
}

// 初始化导航栏
- (void)setupNav
{
    self.navigationItem.title = @"新闻";
}

// 添加UIScrollview
- (void)setupScrollView
{
    
    UIScrollView *newScrollView = [[UIScrollView alloc]init];
    newScrollView.contentSize = CGSizeMake(self.childViewControllers.count * SCREEN_WIDTH, 0);
    newScrollView.showsHorizontalScrollIndicator = NO;
    newScrollView.showsVerticalScrollIndicator = NO;
    newScrollView.frame = self.view.bounds;
    newScrollView.backgroundColor = GPRandomColor;
    newScrollView.pagingEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    newScrollView.delegate = self;
    self.scrollView = newScrollView;
    [self.view addSubview:newScrollView];
    
}
// 添加标题栏
- (void)setupTitleView
{
    // 添加标题
   
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, GPNavBarBottom, self.view.width, GPTitlesViewH);
    titleView.backgroundColor = GPCommonBgColor;
    [self.view addSubview:titleView];
    
    // 添加标题按钮
    NSInteger Btncount = self.childViewControllers.count;
    CGFloat BtnW = self.view.bounds.size.width / Btncount;
    CGFloat BtnH = titleView.height;
    for (int i = 0; i < Btncount; i ++) {
        GPTitleBtn *titleBtn = [[GPTitleBtn alloc] init];
        titleBtn.tag = i;
         [self.titleBtnArray addObject:titleBtn];
        
        [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [titleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [titleBtn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.frame = CGRectMake(i *BtnW, 0, BtnW, BtnH);
       
        
        [titleView addSubview:titleBtn];
    }
    
    GPTitleBtn *firstBtn = titleView.subviews.firstObject;
    // 添加指示器
    UIView *titleIndicatorView = [[UIView alloc] init];
    titleIndicatorView.backgroundColor = [UIColor blueColor];
    titleIndicatorView.height = 2;
    titleIndicatorView.bottom = titleView.height;
    self.titleIndicatorView = titleIndicatorView;
    [firstBtn.titleLabel sizeToFit];
    
    
    titleIndicatorView.width = firstBtn.titleLabel.width;
    titleIndicatorView.centerX = firstBtn.centerX;
    [titleView addSubview:titleIndicatorView];
    // 默认选选中按钮
    firstBtn.selected = YES;
    self.selectedTitleButton = firstBtn;

}

#pragma mark - UIScrollview的代理方法
// 停止拖拽的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = self.scrollView.contentOffset.x / self.scrollView.width;
    GPTitleBtn *titleBtn = self.titleBtnArray[index];
    [self titleBtnClick:titleBtn];
    
    [self addChildView];
}
// 点击按钮切换时调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildView];
    
}

#pragma mark - 内部方法
- (void)titleBtnClick:(GPTitleBtn *)titleBtn
{
   
    // 切换按钮的状态
    self.selectedTitleButton.selected = NO;
    titleBtn.selected = YES;
    self.selectedTitleButton = titleBtn;
    // 移动指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.titleIndicatorView.width = titleBtn.width;
        self.titleIndicatorView.centerX = titleBtn.centerX;
    }];
    // 切换控制器的View
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleBtn.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)addChildView
{
    UIScrollView *scrollView = self.scrollView;
    int index = scrollView.contentOffset.x / self.view.width;
    
    UIViewController *willShowVc = self.childViewControllers[index];
 
    [scrollView addSubview:willShowVc.view];
    
    willShowVc.view.frame = scrollView.bounds;
    static int i = 0;
    GPLog(@"%d",i);
    i ++;
}

@end
