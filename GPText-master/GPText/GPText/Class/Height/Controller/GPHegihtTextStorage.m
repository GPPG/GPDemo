//
//  GPHegihtTextStorage.m
//  GPText
//
//  Created by dandan on 16/9/10.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHegihtTextStorage.h"

@implementation GPHegihtTextStorage
{
    NSMutableAttributedString *_imp;
}
#pragma mark - 初始化
- (id)init
{
    self = [super init];
    
    if (self) {
        _imp = [NSMutableAttributedString new];
    }
    
    return self;
}
#pragma mark - 内部方法
- (void)processEditing
{
    
    NSRegularExpression *expression = [[NSRegularExpression alloc]initWithPattern:@"a[\\b{Alphabetic}&&\\b{Uppercase}][\\br{Alphabetic}]+" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSRange paragaphRange = [self.string paragraphRangeForRange: self.editedRange];
    [self removeAttribute:NSForegroundColorAttributeName range:paragaphRange];

    [expression enumerateMatchesInString:self.string options:0 range:paragaphRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        	[self addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:result.range];
    }];
    [super processEditing];
}

#pragma mark - set,get
- (NSString *)string
{
    return _imp.string;
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    return [_imp attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    [_imp replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:(NSInteger)str.length - (NSInteger)range.length];
    
    NSDataDetector *datector = [[NSDataDetector alloc]initWithTypes:NSTextCheckingTypeLink error:nil];
    
    NSRange paragaphRange = [self.string paragraphRangeForRange: NSMakeRange(range.location, str.length)];
    
    [self removeAttribute:NSLinkAttributeName range:paragaphRange];
    [self removeAttribute:NSForegroundColorAttributeName range:paragaphRange];
    
    [datector enumerateMatchesInString:self.string options:0 range:paragaphRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        [self addAttribute:NSLinkAttributeName value:result.URL range:result.range];
        [self addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:result.range];
    }];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
{
    [_imp setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}


@end
