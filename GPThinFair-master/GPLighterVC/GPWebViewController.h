//
//  GPWebViewController.h
//  GPHandMade
//
//  Created by dandan on 16/5/21.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPFariHotData;
@interface GPWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *loadWebView;
@property (nonatomic, strong) GPFariHotData *hotData;

@end
