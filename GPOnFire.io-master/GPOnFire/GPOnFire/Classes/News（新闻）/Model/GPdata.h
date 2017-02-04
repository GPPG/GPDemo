//
//  GPdata.h
//  GPOnFire
//
//  Created by dandan on 16/3/24.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GPdata : NSObject
// 标题
@property (nonatomic,copy) NSString *title;
// 图片
@property (nonatomic,copy) NSString *thumb;
// 文章标签
@property (nonatomic,copy) NSString *articleid;
// 评论数
@property (nonatomic,copy) NSString *comment_total;
// 时间
@property (nonatomic,copy) NSString *ctime;
// 内部链接
@property (nonatomic,copy) NSString *url;
// 帖子类型
@property (nonatomic,copy) NSString *type;
// 图片总数
@property (nonatomic,copy) NSString *images_total;
// 高清图图片数组
@property (nonatomic, strong) NSArray *images;

@end
