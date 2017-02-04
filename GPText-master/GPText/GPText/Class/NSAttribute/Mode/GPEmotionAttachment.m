//
//  GPEmotionAttachment.m
//  GPText
//
//  Created by dandan on 16/9/16.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEmotionAttachment.h"
#import "GPEmotion.h"

@implementation GPEmotionAttachment

- (void)setEmotion:(GPEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png]];
}

@end
