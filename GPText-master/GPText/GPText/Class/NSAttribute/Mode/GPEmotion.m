//
//  GPEmotion.m
//  GPText
//
//  Created by dandan on 16/9/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEmotion.h"
#import <MJExtension.h>

@implementation GPEmotion
MJCodingImplementation

- (void)setCode:(NSString *)code
{
    _code = [code copy];
    
    self.emoji = [NSString emojiWithStringCode:code];
}
@end
