


//
//  UserModel.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+(instancetype)user{
    static UserModel *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[UserModel alloc]init];
    });
    return user;
}

@end
