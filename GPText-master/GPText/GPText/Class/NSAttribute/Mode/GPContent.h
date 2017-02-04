//
//  GPContent.h
//  GPText
//
//  Created by dandan on 16/9/16.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPContent : NSObject
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSAttributedString *arrtext;
+ (instancetype)shopWithStr:(NSString *)str;

@end
