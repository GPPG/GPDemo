//
//  GPEmotionListView.m
//  GPText
//
//  Created by dandan on 16/9/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEmotionListView.h"
#import "GPEmottionGridView.h"

@interface GPEmotionListView()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation GPEmotionListView
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addScrollView];
        [self addPageView];
    }
    return self;
}
- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}
- (void)addPageView
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}
#pragma mark - 数据处理
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSInteger totlas = (emotions.count + GPEmotionMaxCountPerPage - 1) / GPEmotionMaxCountPerPage;
    NSInteger currrentGridViewCount = self.scrollView.subviews.count;
    
    self.pageControl.numberOfPages = totlas;
    self.pageControl.currentPage = 0;
    GPEmottionGridView *gridView = nil;
    
    for (NSInteger i = 0; i < totlas; i ++) {
        if (i >= currrentGridViewCount) {
            gridView = [[GPEmottionGridView alloc]init];
            [self.scrollView addSubview:gridView];
        } else {
            gridView = self.scrollView.subviews[i];
        }

        NSInteger loc = i * GPEmotionMaxCountPerPage;
        NSInteger len = GPEmotionMaxCountPerPage;
        if (loc + len > emotions.count) {
            len = emotions.count - loc;
        }

        NSRange range = NSMakeRange(loc, len);
        NSArray *gridViewemotionS = [emotions subarrayWithRange:range];
        gridView.emotions = gridViewemotionS;
        
        gridView.hidden = NO;
    }
    
    for (NSInteger i = totlas; i<currrentGridViewCount; i++) {
        GPEmottionGridView *gridView = self.scrollView.subviews[i];
        gridView.hidden = YES;
    }
       [self setNeedsLayout];
    self.scrollView.contentOffset = CGPointZero;

}
#pragma mark - 内部方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    NSInteger count = self.pageControl.numberOfPages;
    CGFloat gridW = self.scrollView.width;
    CGFloat gridH = self.scrollView.height;
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    for (int i = 0; i<count; i++) {
        GPEmottionGridView *gridView = self.scrollView.subviews[i];
        gridView.width = gridW;
        gridView.height = gridH;
        gridView.x = i * gridW;
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
}

@end
