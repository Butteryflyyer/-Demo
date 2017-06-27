//
//  QDWConst.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/8/30.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDWConst : NSObject
//************************************ 发送通知 ************************************************//
extern NSString * const QDWCenterShareFireOrder; //分享发单

extern NSString * const QDWCenterShareBuyOrder;//分享买单

extern NSString * const QDWCommentRefresh;// 客户详情  评论刷新

extern NSString * const QDWSuccessPay;//客户支付成功跳转

extern NSString * const QDWGoFireOrderIntoZancun;// 从暂存页面进入发单页面。发单之后返回首页。在暂存页面增加通知

extern NSString * const QDWCleanFirstData;//发单结束之后清理数据

extern NSString * const QDWCleanStudentLoan;//发单结束清理第一页学历贷数据

extern NSString * const QDWGoMinePage;//进入到我的页面



//************************************ 发送通知 ************************************************//

//************************************ 数据缓存 ************************************************//
extern NSString * const QDWSaveNameAcount; //存储账号

extern NSString * const QDWSavePassWord; //存储密码

extern NSString * const QDWSaveUserName; // 存储用户姓名

extern NSString * const QDWSaveUserId;

extern NSString * const QDWSaveCity;

extern NSString * const NowCity; //当前定位，用户所在的城市

extern NSString * const FirstSelectedCity; //用户第一次进入选择的城市


extern NSString * const MyNowCity;//记住当前城市,用来保证退出当前账户。定位的城市还在。


extern NSString * const QDWUmengPushSwitchBtn;//友盟push开关

//************************************ 数据缓存 ************************************************//

//************************************  整点抢单 *************************************************//

extern  NSString *const QDWQiangdanHourOrder;//整点抢单通知

extern  NSString *const QDWQiangdanFirstChild;//整点抢单 字控制器 通知

extern  NSString *const QDWQiangdanBanner_tableFrame;//根据改变tableview的frame

@end
