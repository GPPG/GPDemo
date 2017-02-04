//
//  GPContentView.m
//  GPText
//
//  Created by dandan on 16/9/16.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPContentView.h"
#import "GPLink.h"

@interface GPContentView()

@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, strong) NSMutableArray *links;
@end

@implementation GPContentView

#pragma mark - 初始化
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.textView.frame = CGRectMake(20, 100, SCREEN_WIDTH - 40, 500);
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:({
            UITextView *textView = [[UITextView alloc] init];
            textView.editable = NO;
            textView.userInteractionEnabled = NO;
            textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
            textView.backgroundColor = [UIColor clearColor];
            self.textView = textView;
            textView;
        })];
    }
    return self;
}
#pragma mark - 事件处理

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    CGPoint pp = [self convertPoint:point toView:self.textView];
    GPLink *touchingLink = [self touchingLinkWithPoint:pp];

    if (touchingLink) {
        [[NSNotificationCenter defaultCenter] postNotificationName:GPLinkDidSelectedNotification object:nil userInfo:@{GPLinkText : touchingLink.text}];
    }
    
    [self touchesCancelled:touches withEvent:event];
}

#pragma mark - 内部方法
- (GPLink *)touchingLinkWithPoint:(CGPoint)point
{
    __block GPLink *touchingLink = nil;
    [self.links enumerateObjectsUsingBlock:^(GPLink *link, NSUInteger idx, BOOL *stop) {
        for (UITextSelectionRect *selectionRect in link.rects) {
            if (CGRectContainsPoint(selectionRect.rect, point)) {
                NSLog(@"选中%@",NSStringFromCGRect(selectionRect.rect));
                touchingLink = link;
                break;
            }
        }
    }];
    return touchingLink;
}


#pragma mark - set,get
- (NSMutableArray *)links
{
    if (!_links) {
        
        NSMutableArray *links = [NSMutableArray array];
        
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
            
            NSString *linkText = attrs[GPLinkText];
            if (linkText == nil) return;
            
            GPLink *link = [[GPLink alloc] init];
            link.text = linkText;
            link.range = range;
            NSMutableArray *rects = [NSMutableArray array];
            self.textView.selectedRange = range;

            NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
            for (UITextSelectionRect *selectionRect in selectionRects) {
                if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) continue;
                [rects addObject:selectionRect];
            }
            link.rects = rects;
            
            [links addObject:link];
        }];
            self.links = links;
    }
    return _links;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    
    self.textView.attributedText = attributedText;
    self.links = nil;
}
@end
