//
//  GPFariTopicBestCell.m
//  GPHandMade
//
//  Created by dandan on 16/7/12.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFariTopicBestCell.h"
#import "UIImageView+WebCache.h"

@interface GPFariTopicBestCell()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@end
@implementation GPFariTopicBestCell
- (void)configureForData:(NSString *)picStr
{
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:[UIImage imageNamed:@"001"]];
}
@end
