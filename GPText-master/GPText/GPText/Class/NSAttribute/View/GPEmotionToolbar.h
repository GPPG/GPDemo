//
//  GPEmotionToolbar.h
//  GPText
//
//  Created by dandan on 16/9/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,GPEmtionType){
    GPEmotionTypeRecent,
    GPEmotionTypeDefault,
    GPEmotionTypeEmoji,
    GPEmotionTypeLxh
};
typedef void(^emtionTypeBlock)(GPEmtionType);
@interface GPEmotionToolbar : UIView
@property (nonatomic,copy) emtionTypeBlock emtiontypeBlock;
@end
