//
//  GPFairArrayDataSource.m
//  GPLighterVC
//
//  Created by dandan on 16/8/19.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFairArrayDataSource.h"
#import "GPFairSectionHeadView.h"
#define SectionCount 4
@interface GPFairArrayDataSource()

@property (nonatomic, copy) CollectionViewCellConfigureBlock configureCellBlock;
@end


@implementation GPFairArrayDataSource

- (id)itemAtIndexPath:(NSIndexPath *)indexPath modeArray:(NSMutableArray *)modeArray
{
    return modeArray[indexPath.row];
}
#pragma mark - UIColltionView 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.cellModeArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *rowArrayCount = self.cellModeArray[section];
    return rowArrayCount.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    NSString *cellIdentifier = self.CellIDArray[indexPath.section];
    NSArray *dataArray = self.cellModeArray[indexPath.section];
    CollectionViewCellConfigureBlock block = self.cellBlockArray[indexPath.section];
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath modeArray:dataArray];
    block(cell,item);
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    GPFairSectionHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FairHeadView" forIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        headView.titleStr = @"每日特价";
        headView.subtitleStr = @"每日10:00更新";
    }else if (indexPath.section == 2){
        headView.titleStr = @"精选专题";
        headView.subtitleStr = @"更多";
    }
    return headView;
}

@end
