//
//  GPDataTopic.m
//  GPOnFire
//
//  Created by dandan on 16/4/5.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDataTopic.h"
#import "MJExtension.h"
#import "GPCells.h"

@implementation GPDataTopic

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"cells" : [GPCells class]};
}

@end
