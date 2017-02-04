//
//  GPEmottionGridView.m
//  GPText
//
//  Created by dandan on 16/9/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEmottionGridView.h"
#import "GPEmotion.h"
#import "GPEmotionView.h"
#import "GPEmtionPopView.h"
#import "GPEmtionTool.h"

@interface GPEmottionGridView()
@property (nonatomic, weak) UIButton *deleteButton;

@property (nonatomic, strong) NSMutableArray *emotionViews;
@property (nonatomic, strong) GPEmtionPopView *popView;

@end
@implementation GPEmottionGridView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addDeletView];
    }
    return self;
}
- (void)addDeletView
{
    [self addSubview:({
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton = deleteButton;
        deleteButton;
    })];
    
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] init];
    [recognizer addTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:recognizer];
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSInteger count = emotions.count;
    NSInteger currentEmotionViewCount = self.emotionViews.count;
    for (int i = 0; i<count; i++) {
        GPEmotionView *emotionView = nil;
        
        if (i >= currentEmotionViewCount) {
            emotionView = [[GPEmotionView alloc] init];
            [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        } else {
            emotionView = self.emotionViews[i];
        }
        // 传递模型数据
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
    }
    for (NSInteger i = count; i<currentEmotionViewCount; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    
    NSInteger count = self.emotionViews.count;
    CGFloat emotionViewW = (self.width - 2 * leftInset) / GPEmotionMaxCols;
    CGFloat emotionViewH = (self.height - topInset) / GPEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.x = leftInset + (i % GPEmotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / GPEmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
    
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - leftInset - self.deleteButton.width;
    self.deleteButton.y = self.height - self.deleteButton.height;

}
#pragma mark - 事件响应
- (void)emotionClick:(GPEmotionView *)emotionView
{
    [self.popView showFromEmotionView:emotionView];
    [self selecteEmotion:emotionView.emotion];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismiss];
    });
}



- (void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:recognizer.view];
    
    GPEmotionView *emotionView = [self emotionViewWithPoint:point];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self.popView dismiss];
        
        [self selecteEmotion:emotionView.emotion];
    } else {
        [self.popView showFromEmotionView:emotionView];
    }
}
- (GPEmotionView *)emotionViewWithPoint:(CGPoint)point
{
    __block GPEmotionView *foundEmotionView = nil;
    
    [self.emotionViews enumerateObjectsUsingBlock:^(GPEmotionView *emotionView, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(emotionView.frame, point)) {
            foundEmotionView = emotionView;
            *stop = YES;
        }
    }];
    return foundEmotionView;
}

- (void)selecteEmotion:(GPEmotion *)emotion
{
    if (emotion == nil) return;
    
    [GPEmtionTool addRecentEmotion:emotion];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GPEmotionDidSelectedNotification object:nil userInfo:@{GPSelectedEmotion : emotion}];
}


- (void)deleteClick
{
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:GPEmotionDidDeletedNotification object:nil userInfo:nil];
}
#pragma mark - set,get
- (NSMutableArray *)emotionViews
{
    if (!_emotionViews) {
        self.emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}
- (GPEmtionPopView *)popView
{
    if (!_popView) {
        self.popView = [GPEmtionPopView popView];
    }
    return _popView;
}

@end
