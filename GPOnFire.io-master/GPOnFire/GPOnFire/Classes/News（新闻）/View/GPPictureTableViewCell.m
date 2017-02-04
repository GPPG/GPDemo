//
//  GPPictureTableViewCell.m
//  GPOnFire
//
//  Created by dandan on 16/3/30.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPPictureTableViewCell.h"
#import "GPdata.h"
#import "UIImageView+WebCache.h"

@interface GPPictureTableViewCell()
// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// 右图
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
// 左图
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
// 评论
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
// 时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
// 提示
@property (weak, nonatomic) IBOutlet UIButton *TipsBtn;

@end
@implementation GPPictureTableViewCell

- (void)setData:(GPdata *)data
{
    _data = data;    
    self.titleLabel.text = data.title;
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:data.thumb] placeholderImage:[UIImage imageNamed:@"defa"]];
    NSString *rightString = data.images[2][@"url"];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightString] placeholderImage:[UIImage imageNamed:@"defa"]];
    self.timeLabel.text = data.ctime;
    self.commentLabel.text = [NSString stringWithFormat:@"评论(%@)",data.comment_total];
    [self.TipsBtn setTitle:data.images_total forState:UIControlStateNormal];
    
}
@end
