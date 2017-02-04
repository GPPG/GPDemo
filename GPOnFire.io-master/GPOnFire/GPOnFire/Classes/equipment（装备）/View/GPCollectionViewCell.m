//
//  GPCollectionViewCell.m
//  GPOnFire
//
//  Created by dandan on 16/4/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPCollectionViewCell.h"
#import "GPdata.h"
#import "UIImageView+WebCache.h"

@interface GPCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageVIew;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation GPCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setData:(GPdata *)data
{
    _data = data;
    
    [self.pictureImageVIew sd_setImageWithURL:[NSURL URLWithString:data.thumb] placeholderImage:[UIImage imageNamed:@"defa"]];
    self.titleLabel.text = data.title;

}

@end
