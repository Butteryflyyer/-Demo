//
//  NetManager.h
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/23.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ZuiXin_Style,
    Duoqi_Style,
    Danqi_Style,
} Selet_enum;

@interface NetManager : NSObject
+(NetManager *)shareManager;
-(void)postNetWithStyle:(Selet_enum)my_enum Withdic:(NSDictionary *)dic Success:(void(^)(NSDictionary * data))success;
@end
