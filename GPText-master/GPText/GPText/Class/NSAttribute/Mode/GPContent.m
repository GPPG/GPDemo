//
//  GPContent.m
//  GPText
//
//  Created by dandan on 16/9/16.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPContent.h"
#import "GPEmotionAttachment.h"

@implementation GPContent

- (instancetype)initWithStr:(NSString *)str
{
    if (self = [super init]) {
        
        self.text = str;
        
    }
    return self;
    
}
+ (instancetype)shopWithStr:(NSString *)str
{
    
    return [[self alloc] initWithStr:str];
}
- (void)setText:(NSString *)text
{
    _text = text;
    
    self.arrtext = [self creatArrtext:text];
}

- (NSAttributedString *)creatArrtext:(NSString *)text
{
    NSArray *regexResults = [GPEmtionTool regexResultsWithText:text];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    // 遍历
    [regexResults enumerateObjectsUsingBlock:^(GPRegexResult *result, NSUInteger idx, BOOL *stop) {
        GPEmotion *emotion = nil;
        if (result.isEmotion) { // 表情
            emotion = [GPEmtionTool emotionWithDesc:result.string];
        }
        
        if (emotion) { // 如果有表情
            // 创建附件对象
            GPEmotionAttachment *attach = [[GPEmotionAttachment alloc] init];
            
            // 传递表情
            attach.emotion = emotion;
            attach.bounds = CGRectMake(0, -3, GPStatusOrginalTextFont.lineHeight, GPStatusOrginalTextFont.lineHeight);
            
            // 将附件包装成富文本
            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
            [attributedString appendAttributedString:attachString];
        } else { // 非表情（直接拼接普通文本）
            NSMutableAttributedString *substr = [[NSMutableAttributedString alloc] initWithString:result.string];
        
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [result.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:*capturedRanges];
                
                // 绑定一个key
                [substr addAttribute:GPLinkText value:*capturedStrings range:*capturedRanges];
                NSLog(@"%@----%@",NSStringFromRange(*capturedRanges),*capturedStrings);
            }];
            
            [attributedString appendAttributedString:substr];
        }
    }];
    
    // 设置字体
    [attributedString addAttribute:NSFontAttributeName value:GPStatusOrginalTextFont range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;


}
@end
