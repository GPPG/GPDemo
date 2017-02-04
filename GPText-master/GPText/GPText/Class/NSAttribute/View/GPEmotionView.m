//
//  GPEmotionView.m
//  GPText
//
//  Created by dandan on 16/9/2.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEmotionView.h"
#import "GPEmotion.h"

@implementation GPEmotionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(GPEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.code) {
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    } else { // 图片表情
        NSString *icon = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
        UIImage *image = [UIImage imageNamed:icon];
        [self setImage: [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
