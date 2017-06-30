//
//  QDWTools.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "QDWTools.h"

@implementation QDWTools


+(NSString *)getNowTimeWith:(NSTimeInterval)time{

    NSDate *senddate= [NSDate date];
    NSDate *lastDay = [NSDate dateWithTimeInterval:-time sinceDate:senddate];//前一天
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: lastDay];
    NSDate *localDate = [lastDay dateByAddingTimeInterval: interval];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *locationString=[dateformatter stringFromDate:localDate];

    return locationString;
}
+(NSString *)getNowTime{
    
    NSDate *senddate= [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: senddate];
    NSDate *localDate = [senddate dateByAddingTimeInterval: interval];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *locationString=[dateformatter stringFromDate:localDate];
    
    return locationString;
}
/**
 *  去除逗号 获取 字符串数组
 */

+(NSArray *)GetArrDeletedouhaoWithStr:(NSString *)str{
    
    if (![str isKindOfClass:[NSNull class]]) {
        NSArray *arr = [str componentsSeparatedByString:@","];
        
        
        return arr;
    }

    return nil;
    
}
@end
