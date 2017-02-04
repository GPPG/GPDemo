//
//  GPFairDelegate.m
//  GPLighterVC
//
//  Created by dandan on 16/8/20.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFairDelegate.h"

@implementation GPFairDelegate

#pragma mark - UICollectionView 布局
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    CGFloat W = 0;
    if (indexPath.section == 0) {
        W = SCREEN_WIDTH * 0.2;
        size = CGSizeMake(W, W * 1.4);
    }else if (indexPath.section == 1){
        W = SCREEN_WIDTH * 0.27;
        size = CGSizeMake(W, W * 2);
    }else if (indexPath.section == 2){
        W = SCREEN_WIDTH * 0.27;
        size = CGSizeMake(W, W);
    }else{
        W = SCREEN_WIDTH * 0.94;
        size = CGSizeMake(W, W * 0.6);
    }
    return size;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeZero;
    if (section == 1) {
        size = CGSizeMake(SCREEN_WIDTH, 40);
    }else if (section == 2){
        size = CGSizeMake(SCREEN_WIDTH, 40);
    }
    return size;
}
@end
