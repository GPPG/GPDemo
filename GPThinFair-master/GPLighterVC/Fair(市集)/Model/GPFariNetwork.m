//
//  GPFariNetwork.m
//  GPHandMade
//
//  Created by dandan on 16/7/12.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFariNetwork.h"
#import "GPHttpBase.h"

#define HomeBaseURl @"http://m.shougongke.com/index.php"

@implementation GPFariNetwork

+ (void)getfariData:(void (^) (GPFariData *fariData))success fail:(GPResponseFail)failBlock
{
    GPFariParmer *parmers = [[GPFariParmer alloc]init];
    parmers.c = @"Shiji";
    parmers.vid = @"18";
    parmers.a = @"product";
    [GPHttpBase getWithUrl:HomeBaseURl param:parmers resultClass:[GPFariData class] success:success failure:failBlock];
}

+(void)fariDataWithParms:(GPFariParmer *)parmer success:(void(^)(GPFariData *fariData))success failuer:(void(^)(NSError *error))failuer
{
    [GPHttpBase getWithUrl:HomeBaseURl param:parmer resultClass:[GPFariData class] success:success failure:failuer];
}

+(void)fariMoreDataWithParms:(GPFariParmer *)parmer success:(void(^)(NSArray *topicDataS))success failuer:(void(^)(NSError *error))failuer
{
    [GPHttpBase getMoreWithUrl:HomeBaseURl param:parmer resultClass:[GPFariTopicData class] success:success failure:failuer];
}


@end
