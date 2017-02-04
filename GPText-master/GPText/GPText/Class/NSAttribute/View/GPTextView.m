//
//  GPTextView.m
//  GPText
//
//  Created by dandan on 16/9/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTextView.h"
#import "UIView+SDAutoLayout.h"
#import "GPEmotion.h"

@interface GPTextView()<UITextViewDelegate>
@property (nonatomic, weak) UILabel *placeLabel;
@end

@implementation GPTextView
#pragma mark - 生命周期
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupPlaceLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 初始化方法
- (void)setupPlaceLabel
{
    UILabel *placeLabel = [[UILabel alloc]init];
    placeLabel.numberOfLines = 0;
    placeLabel.backgroundColor = [UIColor clearColor];
    placeLabel.font = [UIFont systemFontOfSize:15];
    placeLabel.textColor = [UIColor lightGrayColor];
    placeLabel.text = @"快来说说你的开心事吧";
    [self addSubview:placeLabel];
    self.placeLabel = placeLabel;
    [self setAutoSize];
}

- (void)setAutoSize
{
    self.placeLabel.sd_layout
    .leftSpaceToView(self,5)
    .topSpaceToView(self,8)
    .heightIs(20);
    [self.placeLabel setSingleLineAutoResizeWithMaxWidth:200];

}
#pragma mark - 公共方法
- (void)appendEmotion:(GPEmotion *)emotion
{
    
    if (emotion.emoji) { // emoji表情
        [self insertText:emotion.emoji];
        
    } else {
        
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        
        attach.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png]];
        attach.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
        
        NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
        
        NSInteger insertIndex = self.selectedRange.location;
        
        [attributedText insertAttributedString:attachString atIndex:insertIndex];
        
        [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        
        self.attributedText = attributedText;
        
        self.selectedRange = NSMakeRange(insertIndex + 1, 0);
    }
}

#pragma mark - 事件处理
- (void)textDidChange
{
    self.placeLabel.hidden = (self.text.length != 0);
}
#pragma mark - set,get
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

@end
