//
//  UIImage+GPExtension.m
//  01-TabBar的文字和图片
//
//  Created by dandan on 15/11/6.
//  Copyright © 2015年 dandan. All rights reserved.
//

#import "UIImage+GPExtension.h"
@implementation UIImage (GPExtension)

- (instancetype)circleImage
{
    
    // 1.开启上下文
    UIGraphicsBeginImageContext(self.size);
    // 2.获得当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 3.添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    // 4.超出部分都被裁剪
    CGContextClip(context);
    // 5.绘制图片到上下文
    [self drawInRect:rect];
    // 6.从上下文中获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 7.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)circleImageNamed:(NSString *)name
{
  return [[self imageNamed:name]circleImage];
}
@end
