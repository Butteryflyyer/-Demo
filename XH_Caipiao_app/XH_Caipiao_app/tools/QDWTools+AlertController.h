//
//  QDWTools+AlertController.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/12/9.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "QDWTools.h"

@interface QDWTools (AlertController)
/**
 *  提示 alertviewcontroller
 *
 *  @param title  <#title description#>
 *  @param detial <#detial description#>
 *  @param view   <#view description#>
 */

+(void)ShowTishiAlertControllerWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view;
/**
 *  提示alertviewcontroller 点击我知道了 返回前一页
 *
 *  @param title  <#title description#>
 *  @param detial <#detial description#>
 *  @param view   <#view description#>
 */
+(void)ShowTishiAlertControllerIKnowCanDoSomeThingWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view;
//  对于alerviewcontroller的封装。  block

+(void)ShowTishiAlertControllerWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view WithCancelTitle:(NSString *)Canceltitle WithMakeSureTitle:(NSString *)MakeSureTitle  CancelActionBlock:(void(^)(id data))CancelBlock MakSureActionBlock:(void(^)(id data))MakeSureBlock;
/**
 *  点击我知道了，进行相应的操作
 *
 *  @param title     <#title description#>
 *  @param detial    <#detial description#>
 *  @param view      <#view description#>
 *  @param KnowBlcok <#KnowBlcok description#>
 */
+(void)ShowTishiAlertControllerIKnowCanDoSomeThingWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view WithBlock:(void(^)(id data))KnowBlcok;

//  对于版本升级alerviewcontroller的封装。  block

+(void)ShowVersionHelpAlertControllerWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view WithCancelTitle:(NSString *)Canceltitle WithMakeSureTitle:(NSString *)MakeSureTitle Withstyle:(NSTextAlignment)style  CancelActionBlock:(void(^)(id data))CancelBlock MakSureActionBlock:(void(^)(id data))MakeSureBlock;

@end
