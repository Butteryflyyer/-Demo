//
//  Caipiao_UserManager.h
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Caipiao_UserManager : NSObject

@property(nonatomic,copy)NSString *Account;

@property(nonatomic,copy)NSString *RealName;

+(Caipiao_UserManager *)shareManager;
@end
