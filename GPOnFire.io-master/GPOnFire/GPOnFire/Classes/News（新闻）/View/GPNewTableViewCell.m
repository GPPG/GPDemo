//  GPNewTableViewCell.m
//  GPOnFire
//
//  Created by dandan on 16/3/24.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPNewTableViewCell.h"
#import "GPdata.h"
#import <UIImageView+WebCache.h>

#define margin 10
@interface GPNewTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageVIew;// 头像
@property (weak, nonatomic) IBOutlet UILabel *texLabel; // 正文
@property (weak, nonatomic) IBOutlet UIButton *commetBtn; // 评论
@property (weak, nonatomic) IBOutlet UIButton *timeBtn; // 时间
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLayoutConstraint; // 正文宽度约束
@end
@implementation GPNewTableViewCell

- (void)setData:(GPdata *)data
{
    _data = data;
    [self.headImageVIew sd_setImageWithURL:[NSURL URLWithString:data.thumb] placeholderImage:[UIImage imageNamed:@"defa"]];
    self.texLabel.text = data.title;
    [self.commetBtn setTitle:data.comment_total forState:UIControlStateNormal];
    [self.timeBtn setTitle:data.ctime forState:UIControlStateNormal];
}

-(void)layoutSubviews
{
    CGFloat headX = CGRectGetMaxX(self.headImageVIew.frame);
    self.textLayoutConstraint.constant = [UIScreen mainScreen].bounds.size.width - headX - 20;
}
@end
