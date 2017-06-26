//
//  QDWUser.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/5/3.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDWUser : NSObject


STRING(Userid);// 用户id

STRING(Username);//姓名

STRING(Userpassword);// 密码

STRING(UserTelephone); //电话号码

STRING(UserCity); // 所在城市

STRING(UserIntegral); // 积分

STRING(UserAcountMoney); // 用户支付成功

STRING(PayOrderId); // 微信 订单支付的id

STRING(AliOrderId); // 支付宝 订单支付的id



+(QDWUser *)shareManager;
/**
 苹果审核id判断，是否为苹果审核,如果是苹果审核则关闭相应功能
 */
+(BOOL)AppReview;

/**
 *  根据版本号判断 versionId   判断是否大于当前版本号。这个版本号在项目中写死。每次提交版本更新。初始值为0   逐渐递增
 *
 *  @param success
 */

+(void)QDWVersionUpDataSuccess:(void(^)(id data))success;
/**
 *
 *   获取app在appstore中的 路径
 *
 */

+(void)GetAppStoreUrlSuccess:(void(^)(id data))success;

/**
 *  获取验证码 手机
 *
 *  @param url     <#url description#>
 *  @param dic     <#dic description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */

+(void)SendSMSWithURL:(NSString *)url WithDic:(NSDictionary *)dic AndBlockSendSMS:(void(^)(id data))success andFailure:(void(^)(id data))failure;

/**
 *  修改密码
 *
 *  @param url     <#url description#>
 *  @param dic     <#dic description#>
 *  @param success <#success description#>
 *  @param failue  <#failue description#>
 */


+(void)RechargePassWordWith:(NSString *)url WithDic:(NSDictionary *)dic AndBlockSuccess:(void(^)(id data))success andfailure:(void(^)(id data))failue;


/**
 *  移动端注册
 */
+(void)MobileRegiseterWithUrl:(NSString *)url andImage:(UIImage *)image andDic:(NSDictionary *)dic AndSuccess:(void(^)(id data))success andfailure:(void(^)(id data))failue;

/**
 *  新的移动端注册的
 *
 *  @param dic     <#dic description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)MobileRegiseterWithDic:(NSDictionary *)dic Success:(void(^)(id data))success andfailure:(void(^)(id data))failure;
/**
 *  认证
 *
 *  @param dic     <#dic description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)CertifyWithDic:(NSDictionary *)dic Success:(void(^)(id data))success andfailure:(void(^)(id data))failure;
@end
