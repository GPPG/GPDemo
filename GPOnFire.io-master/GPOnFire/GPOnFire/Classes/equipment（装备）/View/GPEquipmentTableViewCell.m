//
//  GPEquipmentTableViewCell.m
//  GPOnFire
//
//  Created by dandan on 16/4/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEquipmentTableViewCell.h"
#import "GPEquipmentData.h"
#import "UIImageView+WebCache.h"
#import "GPPictureCollectionViewCell.h"
#import "GPNewsViewController.h"
#import "GPdata.h"
#import "GPWebViewController.h"

static NSString * const pictureCell = @"collCell";

@interface GPEquipmentTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
// 上图片
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
// 上标题
@property (weak, nonatomic) IBOutlet UILabel *topTitle;
// 更多按钮
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
// 图片浏览器
@property (weak, nonatomic) IBOutlet UICollectionView *PictureCollectionView;

// 模型数组
@property (nonatomic, strong) NSArray *latesArray;

@end

@implementation GPEquipmentTableViewCell

- (void)awakeFromNib
{
    // 初始化collectionView
    [self setCollView];
    

}
#pragma mark - 初始化设置
-(void)setCollView
{
    // 按钮
    [self.moreBtn addTarget:self action:@selector(moreBtnCiclk:) forControlEvents:UIControlEventTouchUpInside];
    
    self.PictureCollectionView.delegate = self;
    self.PictureCollectionView.dataSource = self;
    
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(250, 150);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.PictureCollectionView.collectionViewLayout = layout;
    self.PictureCollectionView.showsHorizontalScrollIndicator = NO;
    // 注册
    [self.PictureCollectionView registerNib:[UINib nibWithNibName:@"GPPictureCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:pictureCell];
    
}

#pragma mark - 私有方法
// 点击按钮的回调
- (void)moreBtnCiclk:(UIButton *)moreBtn
{
    if ([self.delegate respondsToSelector:@selector(equiomentCellDidClickMoreButton:)])
    {
        [self.delegate equiomentCellDidClickMoreButton:moreBtn];
    }
    
}

#pragma mark - 公共方法
- (void)setData:(GPEquipmentData *)data
{
    _data = data;

    self.latesArray = data.latestNews;
    self.moreBtn.tag = [data.columnid integerValue];
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:data.thumb]];
    self.topTitle.text = data.name;
}
#pragma mark - CollectionView 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.latesArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GPPictureCollectionViewCell *collCell = [self.PictureCollectionView dequeueReusableCellWithReuseIdentifier:pictureCell forIndexPath:indexPath];

    collCell.lates = self.latesArray[indexPath.row];
    
    return collCell;
}

#pragma mark - CollectionView代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GPEquipmentLates *lates = self.latesArray[indexPath.row];
    
    GPWebViewController *webViewVc = [[GPWebViewController alloc] init];
    webViewVc.lates = lates;
    
    UITabBarController *root = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = root.selectedViewController;

    [nav pushViewController:webViewVc animated:YES];
}

@end
