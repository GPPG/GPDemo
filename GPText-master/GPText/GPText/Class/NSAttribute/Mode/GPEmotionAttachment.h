//
//  GPEmotionAttachment.h
//  GPText
//
//  Created by dandan on 16/9/16.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPEmotion;

@interface GPEmotionAttachment : NSTextAttachment
@property (nonatomic, strong) GPEmotion *emotion;

@end
