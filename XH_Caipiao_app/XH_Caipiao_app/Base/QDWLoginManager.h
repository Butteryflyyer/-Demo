//
//  QDWLoginManager.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/5/3.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginUserModel.h"

@interface QDWLoginManager : NSObject


@property(nonatomic,strong)LoginUserModel *UserAcount;


@property(nonatomic,strong)NSString *accountPath;



+(QDWLoginManager *)shareManager;


/**
     用户退出登录   
 */
-(void)UsrExitLogin;


/**
    用户在2.7.7版本第一次登录程序必须先重新登录一下。目的是为了重新绑定友盟的别名
 */
-(void)UserExitLoginFirstInNewVersion;

@end
