//
//  UIImageView+GPExtension.h
//  01-TabBar的文字和图片
//
//  Created by dandan on 15/11/6.
//  Copyright © 2015年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GPExtension)
/**
 *  用默认的方式设置头像(默认是圆形)
 */
- (void)setHeaderWithURL:(NSString *)url;

/**
 *  设置圆形头像
 */
- (void)setCircleHeaderWithURL:(NSString *)url;

/**
 *  设置方形头像
 */
- (void)setRectHeaderWithURL:(NSString *)url;

@end

