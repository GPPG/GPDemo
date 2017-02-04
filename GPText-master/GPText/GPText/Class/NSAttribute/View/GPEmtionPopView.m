//
//  GPEmtionPopView.m
//  GPText
//
//  Created by dandan on 16/9/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEmtionPopView.h"
#import "GPEmotionView.h"

@interface GPEmtionPopView()
@property (weak, nonatomic) IBOutlet GPEmotionView *emotionView;
@end

@implementation GPEmtionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GPEmtionPopView" owner:nil options:nil] lastObject];
}

- (void)showFromEmotionView:(GPEmotionView *)fromEmotionView
{
    self.emotionView.emotion = fromEmotionView.emotion;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    CGFloat centerX = fromEmotionView.centerX;
    CGFloat centerY = fromEmotionView.centerY - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"] drawInRect:rect];
}

@end
