//
//  GPEquipmentData.m
//  GPOnFire
//
//  Created by dandan on 16/4/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEquipmentData.h"
#import "GPEquipmentLates.h"
#import "MJExtension.h"

@implementation GPEquipmentData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"latestNews" : [GPEquipmentLates class]};
}

@end
