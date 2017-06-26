//
//  Caipiao_UserManager.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Caipiao_UserManager.h"

@implementation Caipiao_UserManager

+(id)shareManager{
    
    static Caipiao_UserManager *shareManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareManager = [[self alloc]init];
        
        
        
    });
    
    
    return shareManager;
    
}
@end
