//
//  GPEmtionTool.h
//  GPText
//
//  Created by dandan on 16/9/5.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GPEmotion;
@interface GPEmtionTool : NSObject

+ (NSArray *)defaultEmotions;

+ (NSArray *)emojiEmotions;

+ (NSArray *)lxhEmotions;

+ (NSArray *)recentEmotions;

+ (void)addRecentEmotion:(GPEmotion *)emotion;

+ (NSArray *)regexResultsWithText:(NSString *)text;
+ (GPEmotion *)emotionWithDesc:(NSString *)desc;

@end
