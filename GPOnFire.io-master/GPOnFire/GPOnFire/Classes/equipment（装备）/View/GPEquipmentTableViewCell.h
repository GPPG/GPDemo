//
//  GPEquipmentTableViewCell.h
//  GPOnFire
//
//  Created by dandan on 16/4/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPEquipmentData;

@protocol GPEquipmentTableViewCellDelegate <NSObject>

@optional

- (void)equiomentCellDidClickMoreButton:(UIButton *)moreBtn;

@end


@interface GPEquipmentTableViewCell : UITableViewCell
// 代理对象
@property (nonatomic, weak) id<GPEquipmentTableViewCellDelegate> delegate;
@property (nonatomic, strong) GPEquipmentData *data;

@end
