//
//  GPBLankViewController.m
//  GPText
//
//  Created by dandan on 16/9/12.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPBLankViewController.h"

@interface GPBLankViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation GPBLankViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTextKit];
    [self setupImage];
    
}
- (void)setupTextKit
{
    NSURL *contentUrl = [[NSBundle mainBundle]URLForResource:@"content" withExtension:@"txt"];
    self.textView.scrollEnabled = NO;
[self.textView.textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:contentUrl usedEncoding:NULL error:NULL]];
}
- (void)setupImage
{

    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"5"]];
    imageView.center = self.view.center;
    CGRect ofram = [self.textView convertRect:imageView.bounds fromView:imageView];
    ofram.origin.y = ofram.origin.y - 64;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:ofram];
    
    self.textView.textContainer.exclusionPaths = @[path];
    
    [self.view addSubview:imageView];
}
@end
