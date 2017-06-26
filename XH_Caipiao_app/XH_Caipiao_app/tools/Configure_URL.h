//
//  Configure_URL.h
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#ifndef Configure_URL_h
#define Configure_URL_h


#define QDWrtMsg @"rtMsg"

#define QDWrtState @"rtState"

#define QDWrtData @"rtData"

#define QDWBASE_URL            QDWFormal_URL               //

#define KeyChain_Service @"com.qiandaowei.www"//keychain  service

#define QDWFormal_URL @"https://app.qiandaowei.com/qdw/"//正式服务器

#define QDWLogin_URL  @"UserController/mobileLogin.act?" // 登录接口

#define QDWRechargePassword_URL  @"UserController/WXPasswordReset.act?"//移动端 忘记密码接口


#define QDWsendSms_URL @"UserController/sendSms.act?"// 获取短信接口



#define QDWwxUserRegister_URL @"UserController/wxUserRegister.act?"//  新的注册接口
#endif /* Configure_URL_h */
