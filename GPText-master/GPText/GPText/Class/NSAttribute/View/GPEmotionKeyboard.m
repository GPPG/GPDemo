//
//  GPEmotionKeyboard.m
//  GPText
//
//  Created by dandan on 16/9/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEmotionKeyboard.h"
#import "GPEmotionToolbar.h"
#import "GPEmotion.h"
#import "GPEmotionListView.h"
#import "GPEmtionTool.h"

@interface GPEmotionKeyboard()
@property (nonatomic, weak) GPEmotionToolbar *toollbar;
@property (nonatomic, weak) GPEmotionListView *listView;
@end

@implementation GPEmotionKeyboard

#pragma mark - 初始化
+ (instancetype)keyboard
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addListView];
        [self addToolbar];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
    }
    return self;
}
- (void)addToolbar
{
    __weak typeof(self) weakSelf = self;
    GPEmotionToolbar *toollbar = [[GPEmotionToolbar alloc] init];
    [self addSubview:toollbar];
    toollbar.emtiontypeBlock = ^(GPEmtionType type){
        [weakSelf setEmtiontype:type];
    };
    self.toollbar = toollbar;
}
- (void)addListView
{
    GPEmotionListView *listView = [[GPEmotionListView alloc] init];
    [self addSubview:listView];
    self.listView = listView;
}
#pragma mark - 事件响应
- (void)setEmtiontype:(GPEmtionType)type
{
    switch (type) {
        case GPEmotionTypeRecent: {
            self.listView.emotions = [GPEmtionTool recentEmotions];
            break;
        }
        case GPEmotionTypeDefault: {
            self.listView.emotions = [GPEmtionTool defaultEmotions];
            
            break;
        }
        case GPEmotionTypeEmoji: {
            self.listView.emotions = [GPEmtionTool emojiEmotions];
            break;
        }
        case GPEmotionTypeLxh: {
            self.listView.emotions = [GPEmtionTool lxhEmotions];
            break;
        }
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.toollbar.width = self.width;
    self.toollbar.height = 35;
    self.toollbar.y = self.height - self.toollbar.height;

    self.listView.width = self.width;
    self.listView.height = self.toollbar.y;
}

#pragma mark - set,get

@end
