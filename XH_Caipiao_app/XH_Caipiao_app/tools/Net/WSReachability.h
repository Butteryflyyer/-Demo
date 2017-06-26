//
//  WSReachability.h
//  YuLinZhengFeng
//
//  Created by 信昊 on 16/1/12.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "AFNetworking.h"
//成功回调
typedef void (^successBlock)(NSString *status);

@interface WSReachability : AFNetworkReachabilityManager

/**
 *  网络状态
 */
+ (void)WSwithSuccessBlock:(successBlock)success;

@end
