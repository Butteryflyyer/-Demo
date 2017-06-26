//
//  WSReachability.m
//  YuLinZhengFeng
//
//  Created by 信昊 on 16/1/12.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "WSReachability.h"

@implementation WSReachability

+ (void)WSwithSuccessBlock:(successBlock)success
{
    [[self sharedManager]startMonitoring];
    
    [[self sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == 0) {
            success(@"无连接");
        }else if (status == 1){
            
            success(@"3G/4G网络");
        }else if (status == 2){
            success(@"wifi状态下");
        }
    }];
}

@end
