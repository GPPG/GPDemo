//
//  GPFairArrayDataSource.h
//  GPLighterVC
//
//  Created by dandan on 16/8/19.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^CollectionViewCellConfigureBlock)(id cell, id item);

@interface GPFairArrayDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *cellBlockArray;
@property (nonatomic, strong) NSArray *cellModeArray;
@property (nonatomic, strong) NSArray *CellIDArray;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath modeArray:(NSArray *)modeArray;

@end
