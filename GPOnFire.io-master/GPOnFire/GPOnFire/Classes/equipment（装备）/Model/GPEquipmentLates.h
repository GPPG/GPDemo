//
//  GPEquipmentLates.h
//  GPOnFire
//
//  Created by dandan on 16/4/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPEquipmentLates : NSObject
// 文章
@property (nonatomic,copy) NSString *articleid;
// 时间
@property (nonatomic,copy) NSString *ctime;
// 类型
@property (nonatomic,copy) NSString *type;
// 吊毛
@property (nonatomic,copy) NSString *columnid;
// 下标题
@property (nonatomic,copy) NSString *title;
// 图片
@property (nonatomic,copy) NSString *thumb;

@end
