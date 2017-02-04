//
//  GPProjectTableViewCell.m
//  GPOnFire
//
//  Created by dandan on 16/3/30.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPProjectTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GPdata.h"

@interface GPProjectTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *projectImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;

@end

@implementation GPProjectTableViewCell


- (void)setData:(GPdata *)data
{
    _data = data;
    
   [self.projectImageVIew sd_setImageWithURL:[NSURL URLWithString:data.thumb] placeholderImage:[UIImage imageNamed:@"defa"]];
    self.projectLabel.text = data.title;
    
    self.autoresizesSubviews = NO;
}


@end
