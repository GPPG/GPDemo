//
//  GPEquipmentData.h
//  GPOnFire
//
//  Created by dandan on 16/4/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GPEquipmentData : NSObject

// 标题
@property (nonatomic,copy) NSString *name;
// 标题图片
@property (nonatomic,copy) NSString *thumb;
// 更多按钮
@property (nonatomic,copy) NSString *columnid;
// 细节
@property (nonatomic, strong) NSArray *latestNews;

@end
