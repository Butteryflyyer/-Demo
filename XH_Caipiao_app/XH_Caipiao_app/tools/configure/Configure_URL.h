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

#define Umeng_AppKey @"59536445734be4241f0003a6" //推送

#define Umeng_master @"3msulclxpakhpmm2vxesndcr0pijtkvv" //推送

#define KeyChain_Service @"com.caipiao_app.www"//keychain  service

#define QDWFormal_URL @"https://app.qiandaowei.com/qdw/"//正式服务器

#define Bobm_Application_ID @"4fdcd85f77b45484bb416ab5e239812e"

#define Bobm_REST_API_Key @"f403af169e1d19a8380002bf109c353e"

#define Bobm_Secret_key @"e4cad396fed571ec"

#define Bobm_Master_key @"1ae9c898ae6854086a00653a02c177b4"





#define QDWLogin_URL  @"UserController/mobileLogin.act?" // 登录接口

#define QDWRechargePassword_URL  @"UserController/WXPasswordReset.act?"//移动端 忘记密码接口


#define QDWsendSms_URL @"UserController/sendSms.act?"// 获取短信接口



#define QDWwxUserRegister_URL @"UserController/wxUserRegister.act?"//  新的注册接口

/**
 *                                  编辑个人信息
 */
#define QDWEditInfo_URL            @"PersonalCenter/MobileEditInfo.act?"

/**
 *  邀请好友数
 */
#define QDWInviteFriend_URL @"UserController/userInvitationNum.act?"

/**
 个人中心第一页。
 
 @return <#return value description#>
 */
#define QDWgetMySelfInfo_URL         @"PersonalCenter/getMySelfInfo.act?"
/**
 *  生成二维码
 */
#define QDWCreatQRCode_URL @"UserController/phoneEncrypt.act?"
#define QDWselfCenter_URL  @"weixinNew/selfCenter/register.html?" //分享二维码
#endif /* Configure_URL_h */
