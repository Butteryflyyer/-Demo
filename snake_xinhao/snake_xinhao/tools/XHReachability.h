//
//  WSReachability.h
//  YuLinZhengFeng
//
//  Created by 王帅 on 16/1/12.
//  Copyright © 2016年 shuai. All rights reserved.
//

#import "AFNetworking.h"
//成功回调
typedef void (^successBlock)(NSString *status);




@interface XHReachability : AFNetworkReachabilityManager


//+(instancetype)shareManager;



/**
 *  网络状态
 */
+ (void)XHwithSuccessBlock:(successBlock)success;

@end
