//
//  MinePageManager.h
//  QianDaoWeiApp
//
//  Created by 融联 on 16/5/9.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QDWUserPersonalInfo.h"

@interface MinePageManager : NSObject

+(MinePageManager *)shareManager;

/** UnReadNews */
@property(nonatomic, assign) NSInteger unReadNewsCount;


/**
 个人中心我的银行卡
 
 @param success <#success description#>
 */
+ (void)getPersonalUserBankInfoWithSuccessBlock:(void(^)(id data))success;
/**
 个人中心第一页获取个人信息的接口
 
 @param success <#success description#>
 */
+ (void)getMySelfInfoWithSuccessBlock:(void(^)(id data))success;
/**
 *  获取用户信息
 */
+ (void)GetUserInfoDataWithUrl:(NSString *)url SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;


/**
 *  查询预到金额
 */
+ (void)GetOnWayMoneyWithUrl:(NSString *)url SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;


/**
 *  用户反馈
 */
+(void)FeedbackDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  编辑个人信息
 */
+(void)EditInfoWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  用户充值记录
 *
 */
+(void)GetRechargeRecordDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  用户提现记录
 */
+(void)WithdrawalsDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  充值提现纪录里当前余额
 */

+(void)GetAccountRecordDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  重置登录密码
 *
 */
+(void)ResetLoginPasswordDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  重置支付密码
 *
 */
+(void)ResetPaymentPasswordDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  单子交易记录（收入）
 */
+(void)GetSoldOffBillsDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  单子交易记录（支出）
 */
+(void)GetBuyBillsDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  单子交易记录 收入与支出总额
 */
+(void)TransactionAmountWithUrl:(NSString *)url SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  全部消息
 */
+(void)AllNewsDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;




/**
 *  读取一条消息
 */
+(void)ReadOneNewsDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  删除消息
 */
+(void)DeleteNewsDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;



/**
 *  未读取消息个数
 */
+(void)UnReadNewsDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  生成二维码
 */
+(void)CreatQRCodeWithUrl:(NSString *)url SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  我的中奖纪录
 */
+(void)MyWinWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;
/**
 *  资金提现
 */
+(void)WithdrawMoneyWithDict:(NSDictionary *)dict SuccessBlock:(void (^)(id))success FailureBlock:(void (^)(id))failure;

/**
 *  是否有支付密码
 */
+(void)IfHasPayPasswordWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  邀请好友数
 */
+(void)InviteFriendUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;



/**
 *  个人中心（包含银行卡信息）
 */
+ (void)GetMineInfoDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  绑定银行卡1（身份信息）
 */
+(void)BindCardInfoUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  绑定银行卡2 (上传图片)
 */
+(void)UpdataWithDic:(NSDictionary *)dic SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  获取照片信息
 */
+(void)GetCountInfoCardPhtotoSuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  修改银行卡
 */
+(void)ModifyBankCardUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  用户提取现金
 */
+(void)ApplyForWithdrawUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;

/**
 *  提现分享查询
 */
+(void)SearchWithdrawWithDic:(NSDictionary *)dic Success:(void(^)(id data))Success Failure:(void(^)(id data))Failure;
/**
 检测银行卡接口
 
 @param dic     <#dic description#>
 @param Success <#Success description#>
 @param Failure <#Failure description#>
 */
+(void)CheckBackCardWithDic:(NSDictionary *)dic Success:(void(^)(id data))Success Failure:(void(^)(id data))Failure;

/**
 余额充值
 
 @param dic     <#dic description#>
 @param Success <#Success description#>
 @param failure <#failure description#>
 */
+(void)PersonalMoneyWithDic:(NSDictionary *)dic Success:(void(^)(id data))Success Failure:(void(^)(id data))failure;



/**
 消息接口查询
 
 @param Success <#Success description#>
 */
+(void)FindUserAppMsgSettingSuccess:(void(^)(id data))Success;


/**
 设置消息接收接口
 
 @param msgEnable <#msgEnable description#>
 @param Success   <#Success description#>
 */
+(void)AppSettingPushMsgWithmsgEnable:(NSString *)msgEnable Success:(void(^)(id data))Success;
/**
 检测是否设置支付密码
 
 @param success <#success description#>
 */
+ (void)getPersonalPayPasswordWithSuccessBlock:(void(^)(id data))success;
/**
 这个是我的页面，我的余额，预到金额，积分的接口   需要传 userId  和 accountType（0 :余额,1：积分, 2：预到） 这是列表  还需要 page 和pageSize
 
 @param success <#success description#>
 */
+ (void)getPersonalQueryConstWithDic:(NSDictionary *)dic WithSuccessBlock:(void(^)(id data))success;
/**
 我的页面  交易明细
 
 @return <#return value description#>
 */
+ (void)getPersonalQueryDetailWithDic:(NSDictionary *)dic WithSuccessBlock:(void(^)(id data))success;
/**
 我的页面  消息列表
 
 @return <#return value description#>
 */
+ (void)getPersonalQueryMessListWithDic:(NSDictionary *)dic WithSuccessBlock:(void(^)(id data))success;
/**
 我的页面  订单消息未读个数
 
 @return <#return value description#>
 */
+ (void)getPersonalQueryMessCountWithSuccessBlock:(void(^)(id data))success;
/**
 我的页面  消息列表 删除全部消息
 
 @return <#return value description#>
 */
+ (void)getPersonalDeleteMessListWithDic:(NSDictionary *)dic WithSuccessBlock:(void(^)(id data))success;

/**
 我的页面 客户列表  三合一接口
 
 @param url     <#url description#>
 @param dic     <#dic description#>
 @param success <#success description#>
 */
+(void)getPersonalCustomListWithDic:(NSDictionary *)dic SuccessBlock:(void(^)(id data))success;
/**
 验证支付密码是否正确
 
 @param dic     <#dic description#>
 @param success <#success description#>
 */
+(void)CheckPayPasswordWithDic:(NSDictionary *)dic SuccessBlock:(void(^)(id data))success;
/**
 更新客户进度
 
 @param dic     <#dic description#>
 @param success <#success description#>
 */
+(void)BillBuyedProgressWithDic:(NSDictionary *)dic SuccessBlock:(void(^)(id data))success;
/**
 我的客户 从个人中心我的客户点进去。
 
 @param dic     <#dic description#>
 @param success <#success description#>
 */
+(void)PersonalCenter_MessListSuccessBlock:(void(^)(id data))success;
@end
