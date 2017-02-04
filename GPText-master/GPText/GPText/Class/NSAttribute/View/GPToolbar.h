//
//  GPToolbar.h
//  GPText
//
//  Created by dandan on 16/9/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,GPTollsBtnType){
    GPComposeToolbarButtonTypeCamera,
    GPComposeToolbarButtonTypePicture,
    GPComposeToolbarButtonTypeMention,
    GPComposeToolbarButtonTypeTrend,
    GPComposeToolbarButtonTypeEmotion
};


typedef void(^btnClickBlock)(GPTollsBtnType);
@interface GPToolbar : UIView

@property (nonatomic,copy)btnClickBlock btnClickBlock;
@property (nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;

@end
