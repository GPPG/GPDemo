//
//  GPWebViewController.h
//  GPOnFire
//
//  Created by dandan on 16/3/24.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPFocus;
@class GPdata;
@class GPEquipmentLates;

@interface GPWebViewController : UIViewController

@property (nonatomic, strong) GPFocus *topic;
@property (nonatomic, strong)  GPdata*data;
@property (nonatomic, strong) GPEquipmentLates *lates;
@end
