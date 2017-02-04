//
//  GPPictureCollectionViewCell.m
//  GPOnFire
//
//  Created by dandan on 16/4/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPPictureCollectionViewCell.h"
#import "GPEquipmentLates.h"
#import "UIImageView+WebCache.h"

@interface GPPictureCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *mainImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;

@end

@implementation GPPictureCollectionViewCell

- (void)awakeFromNib {
}


- (void)setLates:(GPEquipmentLates *)lates
{
    _lates = lates;
    
    [self.mainImageVIew sd_setImageWithURL:[NSURL URLWithString:lates.thumb] placeholderImage:[UIImage imageNamed:@"defa"]];
    self.mainTitle.text = lates.title;
    
}

@end
