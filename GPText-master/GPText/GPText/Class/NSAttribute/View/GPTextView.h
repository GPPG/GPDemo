//
//  GPTextView.h
//  GPText
//
//  Created by dandan on 16/9/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPEmotion;
@interface GPTextView : UITextView
- (void)appendEmotion:(GPEmotion *)emotion;
@end
