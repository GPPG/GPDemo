//
//  GPEmtionPopView.h
//  GPText
//
//  Created by dandan on 16/9/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPEmotionView;
@interface GPEmtionPopView : UIView
+ (instancetype)popView;

- (void)showFromEmotionView:(GPEmotionView *)fromEmotionView;
- (void)dismiss;
@end
