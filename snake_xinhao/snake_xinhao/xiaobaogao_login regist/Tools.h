//
//  Tools.h
//  xiaoxinyong_gsd
//
//  Created by 信昊 on 2017/8/24.
//  Copyright © 2017年 xiaoxinyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
//获取version号
+(NSString *)getAppVersion;
//获取build号
+(NSString *)getAppBuild;
//设置label  不同的颜色  不同的大小
+(NSMutableAttributedString *)attrStrFrom:(NSString *)allString colorStr:(NSString *)colorStr color:(UIColor *)color font:(UIFont *)font;
// 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
//正则匹配用户密码8-16位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;
+(void)ShowTishiAlertControllerWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view WithCancelTitle:(NSString *)Canceltitle WithMakeSureTitle:(NSString *)MakeSureTitle  CancelActionBlock:(void(^)(id data))CancelBlock MakSureActionBlock:(void(^)(id data))MakeSureBlock;
+(void)ShowTishiAlertControllerIKnowCanDoSomeThingWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view WithBlock:(void(^)(id data))KnowBlcok;
@end
