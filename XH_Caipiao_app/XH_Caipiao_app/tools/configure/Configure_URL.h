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

#define Gaode_appkey @"b6dc28baa31ce271c72b3b742aef8ba6"

#define Umeng_AppKey @"59521e1f677baa5fd9001cad" //推送

#define Umeng_master @"jq0h332jpn4pblqxvldi1zl2joigfobg" //推送

#define KeyChain_Service @"com.caipiao_app.www"//keychain  service

#define QDWFormal_URL @"https://app.qiandaowei.com/qdw/"//正式服务器

#define QDWLogin_URL  @"UserController/mobileLogin.act?" // 登录接口

#define QDWRechargePassword_URL  @"UserController/WXPasswordReset.act?"//移动端 忘记密码接口


#define QDWsendSms_URL @"UserController/sendSms.act?"// 获取短信接口



#define QDWwxUserRegister_URL @"UserController/wxUserRegister.act?"//  新的注册接口

/**
 *                                  编辑个人信息
 */
#define QDWEditInfo_URL            @"PersonalCenter/MobileEditInfo.act?"

/**
 个人中心第一页。
 
 @return <#return value description#>
 */
#define QDWgetMySelfInfo_URL         @"PersonalCenter/getMySelfInfo.act?"
#endif /* Configure_URL_h */
