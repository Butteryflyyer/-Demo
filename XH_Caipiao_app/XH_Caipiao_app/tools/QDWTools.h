//
//  QDWTools.h
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDWTools : NSObject
+(NSString *)getNowTime;
/**
 *  去除逗号 获取 字符串数组
 */

+(NSArray *)GetArrDeletedouhaoWithStr:(NSString *)str;
@end
