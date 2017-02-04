//
//  GPdata.m
//  GPOnFire
//
//  Created by dandan on 16/3/24.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPdata.h"

@implementation GPdata
/**
 *  服务器返回的时间
 */
- (NSString *)ctime
{
    // 1.服务器返回的时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
#warning 真机调试的时候，必须加上这句
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *createdAtDate = [fmt dateFromString:_ctime];
  
    // 2: 当前时间
    NSDate *nowDate = [NSDate date];
  
   //  3: 日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 4:年
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:nowDate];
    NSInteger createdAtYear = [calendar component:NSCalendarUnitYear fromDate:createdAtDate];
    // 5:逻辑处理
    if (nowYear == createdAtYear) { // 今年
        if ([calendar isDateInToday:createdAtDate]) { // 今天
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar components:unit fromDate:createdAtDate toDate:nowDate options:0];
            if (cmps.hour >= 1) { // 时间间隔 >= 1个小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1个小时 > 时间间隔 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if ([calendar isDateInYesterday:createdAtDate]) { // 昨天
            fmt.dateFormat = @"昨天";
            return [fmt stringFromDate:createdAtDate];
        } else { // 其他
            fmt.dateFormat = @"MM-dd";
            return [fmt stringFromDate:createdAtDate];
        }
    } else { // 非今年
        return _ctime;
    }

}
@end
