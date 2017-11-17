//
//  LoginUserModel.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/5/3.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginUserModel : NSObject

@property(nonatomic,copy)NSString *id; //用户id

@property(nonatomic,copy)NSString *name; //
@property(nonatomic,copy)NSString *password; // 用户密码
@property(nonatomic,copy)NSString *avatarpath; // 用户头像
@property(nonatomic,copy)NSString *cardnum; // 用户证件号
@property(nonatomic,copy)NSString *sex; //
@property(nonatomic,copy)NSString *birthday; //生日
@property(nonatomic,copy)NSString *phone; //手机号
@property(nonatomic,copy)NSString *email; // 邮箱
@property(nonatomic,copy)NSString *workcity; // 工作区域
@property(nonatomic,copy)NSString *address; //用户详细地址
@property(nonatomic,copy)NSString *workunit; //用户详细地址
@property(nonatomic,copy)NSString *position; // 用户职位
@property(nonatomic,copy)NSString *workexperience; //
@property(nonatomic,copy)NSString *cardphotopath; //
@property(nonatomic,copy)NSString *billBuy; //   用户购买单子
@property(nonatomic,copy)NSString *billRelease; //  用户发布单子
@property(nonatomic,copy)NSString *billCollection; //用户收藏单子
@property(nonatomic,copy)NSString *integral; // 用户账户积分
@property(nonatomic,assign)float accountbalance; //用户账户余额
@property(nonatomic,copy)NSString *registerstatus; //用户注册状态
@property(nonatomic,copy)NSString *updatetime; //用户更新时间
@property(nonatomic,copy)NSString *lastlogintime; //最后登录时间
@property(nonatomic,copy)NSString *loginCount; //连续登录次数
@property(nonatomic,copy)NSString *refereeid; //邀请人id
@property(nonatomic,copy)NSString *inviteRewardStatus; //邀请积分状态
@property(nonatomic,copy)NSString *administrator; //审核人
@property(nonatomic,copy)NSString *loginerror; //连续登录记录

@property(nonatomic,copy)NSString *loginerrortime; //登录错误时间
@property(nonatomic,copy)NSString *version; //版本


@property (nonatomic, assign) BOOL hasChecked;//身份证信息是否已经校验


+(void)LoginQDWWithUrl:(NSString *)url AndDic:(NSDictionary *)dic BlockSuccess:(void(^)(id data))success WithBlockFail:(void(^)(id data))failure;

+(void)GetReleaseBillTopTenWithurl:(NSString *)url Withuserid:(NSString *)userid SuccessBlock:(void(^)(id data))success Failure:(void(^)(id data))failure;

+(void)SignDateWithurl:(NSString *)url WithUserid:(NSString *)userid SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure;
+(void)MobileRegiseterWithDic:(NSDictionary *)dic Success:(void(^)(id data))success andfailure:(void(^)(id data))failure;
@end
