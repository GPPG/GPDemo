//
//  GPHeightViewController.m
//  GPText
//
//  Created by dandan on 16/8/31.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHeightViewController.h"
#import "GPHegihtTextStorage.h"

@interface GPHeightViewController ()<NSLayoutManagerDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) GPHegihtTextStorage *hegihtStorage;
@end

@implementation GPHeightViewController
#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];

    self.hegihtStorage = [[GPHegihtTextStorage alloc]init];
    [self.hegihtStorage addLayoutManager:self.textView.layoutManager];
    self.textView.layoutManager.delegate = self;
    [ self.hegihtStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"Height" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
}
#pragma mark - 布局代理
- (BOOL)layoutManager:(NSLayoutManager *)layoutManager shouldBreakLineByWordBeforeCharacterAtIndex:(NSUInteger)charIndex
{
    NSRange range;
    NSURL *linkURL = [layoutManager.textStorage attribute:NSLinkAttributeName atIndex:charIndex effectiveRange:&range];
    
    if (linkURL && charIndex > range.location && charIndex <= NSMaxRange(range))
        return NO;
    else
        return YES;
}

#pragma mark - UItextView 代理
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
@end
