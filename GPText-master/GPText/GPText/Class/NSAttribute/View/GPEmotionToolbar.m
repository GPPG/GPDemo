//
//  GPEmotionToolbar.m
//  GPText
//
//  Created by dandan on 16/9/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEmotionToolbar.h"

@interface GPEmotionToolbar()
@property (nonatomic, weak) UIButton *selectedButton;
@end

@implementation GPEmotionToolbar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton:@"最近" tag:GPEmotionTypeRecent];
        [self setupButton:@"默认" tag:GPEmotionTypeDefault];
        [self setupButton:@"Emoji" tag:GPEmotionTypeEmoji];
        [self setupButton:@"呵呵哒" tag:GPEmotionTypeLxh];
    }
    return self;
}

- (UIButton *)setupButton:(NSString *)title tag:(GPEmtionType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:button];
    
    NSInteger count = self.subviews.count;
    if (count == 1) {
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    } else if (count == GPEmotionToolbarButtonMaxCount) { // 最后一个按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    } else {
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    
    return button;
}

- (void)setEmtiontypeBlock:(emtionTypeBlock)emtiontypeBlock
{
    _emtiontypeBlock = emtiontypeBlock;
    UIButton *defaultButton = (UIButton *)[self viewWithTag:GPEmotionTypeDefault];
    [self buttonClick:defaultButton];
}

- (void)buttonClick:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    if (self.emtiontypeBlock) {
        self.emtiontypeBlock(button.tag);
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.width / GPEmotionToolbarButtonMaxCount;
    CGFloat buttonH = self.height;
    for (int i = 0; i<GPEmotionToolbarButtonMaxCount; i++) {
        UIButton *button = self.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}
@end
