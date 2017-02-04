//
//  GPDataTableViewCell.m
//  GPOnFire
//
//  Created by dandan on 16/4/5.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDataTableViewCell.h"
#import "GPCells.h"

@interface GPDataTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *qiuduiLabel;
@property (weak, nonatomic) IBOutlet UILabel *sucLabel;
@property (weak, nonatomic) IBOutlet UILabel *defuLabel;
@property (weak, nonatomic) IBOutlet UILabel *dotLabel;

@end

@implementation GPDataTableViewCell

- (void)awakeFromNib {


}

- (void)setCelldata:(GPCells *)celldata
{
    _celldata = celldata;
    self.qiuduiLabel.text = celldata.team[@"name"];
    self.sucLabel.text = celldata.data[0];
    self.defuLabel.text = celldata.data[1];
    self.dotLabel.text = celldata.data[2];
    
    
}


@end
