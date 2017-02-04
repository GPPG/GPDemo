//
//  UIImageView+GPExtension.m
//  01-TabBar的文字和图片
//
//  Created by dandan on 15/11/6.
//  Copyright © 2015年 dandan. All rights reserved.
//

#import "UIImageView+GPExtension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GPExtension.h"



@implementation UIImageView (GPExtension)

// 默认图片(以圆形)
- (void)setHeaderWithURL:(NSString *)url
{
    [self setCircleHeaderWithURL:url];
}

// 设置圆形
- (void)setCircleHeaderWithURL:(NSString *)url
{
    UIImage *placedImage = [UIImage circleImageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placedImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return ;
        self.image = [image circleImage];
    }];
    
}
// 设置方形
- (void)setRectHeaderWithURL:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end





