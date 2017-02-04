//
//  GPPageViewController.m
//  GPText
//
//  Created by dandan on 16/9/8.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPPageViewController.h"

@interface GPPageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *pageScrollView;

@property (nonatomic,strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSLayoutManager *layoutManager;

@end

@implementation GPPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 初始化 textKit
    [self setupTextKit];
    // 渲染
    [self layoutconter];
}
- (void)setupTextKit
{
    NSURL *contentUrl = [[NSBundle mainBundle]URLForResource:@"content" withExtension:@"txt"];
    self.textStorage = [[NSTextStorage alloc]initWithFileURL:contentUrl options:[NSDictionary dictionary] documentAttributes:nil error:nil];
    self.layoutManager = [[NSLayoutManager alloc]init];
    [self.textStorage addLayoutManager:self.layoutManager];
}

- (void)layoutconter
{
    NSInteger totlaGlyph = 0;
    CGFloat X = 0;
    while (totlaGlyph < self.layoutManager.numberOfGlyphs) {
    
        NSTextContainer *textContainer = [[NSTextContainer alloc]initWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.layoutManager addTextContainer:textContainer];
        
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(X, 0, SCREEN_WIDTH, self.pageScrollView.height) textContainer:textContainer];
        textView.scrollEnabled = NO;
        textView.font = [UIFont systemFontOfSize:20];
        [self.pageScrollView addSubview:textView];
        
        X += SCREEN_WIDTH;
        
        totlaGlyph = NSMaxRange([self.layoutManager glyphRangeForTextContainer:textContainer]);
    }
    
    CGSize contentSize = CGSizeMake(X, self.pageScrollView.height);
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.contentSize = contentSize;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    
}
@end
