//
//  Tools.m
//  xiaoxinyong_gsd
//
//  Created by 信昊 on 2017/8/24.
//  Copyright © 2017年 xiaoxinyong. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(NSString *)getAppVersion{
    
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}
+(NSString *)getAppBuild{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
+(NSMutableAttributedString *)attrStrFrom:(NSString *)allString colorStr:(NSString *)colorStr color:(UIColor *)color font:(UIFont *)font
{
    NSMutableAttributedString *arrString = [[NSMutableAttributedString alloc]initWithString:allString];
    // 设置前面几个字串的格式:字号字体、颜色
    [arrString addAttributes:@{NSFontAttributeName:font,
                               NSForegroundColorAttributeName:color
                               }
                       range:[allString rangeOfString:colorStr]];
    return arrString;
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}
#pragma 正则匹配用户密码8-16位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{8,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
//  对于alerviewcontroller的封装。  block

+(void)ShowTishiAlertControllerWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view WithCancelTitle:(NSString *)Canceltitle WithMakeSureTitle:(NSString *)MakeSureTitle  CancelActionBlock:(void(^)(id data))CancelBlock MakSureActionBlock:(void(^)(id data))MakeSureBlock{
    
    
    UIAlertAction *Cancel = [UIAlertAction actionWithTitle:Canceltitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CancelBlock(@"cancel");
        
        
    }];
    
    UIAlertAction *MakeSure = [UIAlertAction actionWithTitle:MakeSureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MakeSureBlock(@"makesure");
        
    }];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:detial preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addAction:Cancel];
    [alertController addAction:MakeSure];
    
    [view presentViewController:alertController animated:YES completion:nil];
 
}
+(void)ShowTishiAlertControllerIKnowCanDoSomeThingWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view WithBlock:(void(^)(id data))KnowBlcok{
    
    
    UIAlertAction *BackHomePage = [UIAlertAction actionWithTitle:@"I know" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        KnowBlcok(@"Back");
        
    }];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:detial preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addAction:BackHomePage];
    
    
    [view presentViewController:alertController animated:YES completion:nil];
    

}
///**
// *  各种前往
// *  pageName:控制器名称
// *  param:参数
// *  present:是否是present跳转 TRUE：present FALSE：PUSH
// */
//- (void)forwardPage:(NSString *)pageName :(NSString *)param :(BOOL)present
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSString * pageNameStr = [pageName stringByReplacingOccurrencesOfString:@" " withString:@""];
//        NSString *tmp = @"";
//        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:0];
//
//        @try {
//            //            NSString *str = [param stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//            tmp = [param stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
//            NSData* data=[tmp  dataUsingEncoding:NSUTF8StringEncoding];
//            dict=[NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        } @catch (NSException *exception) {
//
//        } @finally {
//
//        }
//
//        [[HomeAPICenter manager] goToViewControllerWithClassString:pageNameStr viewController:self param:dict present:present];
//    });
//}
//#pragma mark - 各种前往
//- (void)goToViewControllerWithClassString:(NSString *)classStr viewController:(UIViewController *)contentVC param:(NSDictionary *)param present:(BOOL)present{
//    if (classStr != nil && ![classStr isKindOfClass:[NSNull class]]) {
//        UIViewController *vc;
//        if ([classStr hasPrefix:@"http"]) {
//            XXYWebViewController * webVC = [[XXYWebViewController alloc] init];
//            webVC.urlString = classStr;
//            if (param != nil) {
//                [webVC setValuesForKeysWithDictionary:param];
//            }
//            [contentVC.navigationController pushViewController:webVC animated:true];
//
//        }else {
//            vc = [[NSClassFromString(classStr) alloc]init];
//            if (param != nil) {
//                [vc setValuesForKeysWithDictionary:param];
//            }
//        }
//        vc.hidesBottomBarWhenPushed = true;
//        if (present) {
//            [contentVC presentViewController:vc animated:true completion:^{
//
//            }];
//            return;
//        }
//        [contentVC.navigationController pushViewController:vc animated:true];
//    }else{
//        [contentVC showHudInView:contentVC.view hint:@"数据异常"];
//    }
//}
@end
