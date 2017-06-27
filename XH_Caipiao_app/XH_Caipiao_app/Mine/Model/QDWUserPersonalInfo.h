//
//  QDWUserPersonalInfo.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginUserModel.h"
@interface QDWUserPersonalInfo : NSObject

@property(nonatomic,copy)NSString *onWayMoney;//预到金额

@property(nonatomic,copy)NSString *messageNum;// 未读消息


@property(nonatomic,copy)NSString *billRelease;//发单客户

@property(nonatomic,copy)NSString *billBuy;//抢单客户

@property(nonatomic,copy)NSString *birthYear;//年龄

@property(nonatomic,strong)LoginUserModel *userInfo;


@end
