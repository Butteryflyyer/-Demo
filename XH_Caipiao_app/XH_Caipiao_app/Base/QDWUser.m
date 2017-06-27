///
//  QDWUser.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/5/3.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "QDWUser.h"

@implementation QDWUser

+(id)shareManager{
    
    static QDWUser *shareManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareManager = [[self alloc]init];
        
        shareManager.longitude = 0;
        shareManager.latitude = 0;
        
    });
    
    
    return shareManager;
    
}
///**
//    苹果审核id判断，是否为苹果审核
// */
//+(BOOL)AppReview{
//
//
//        if ([AppShenheUserId_Review isEqual:[QDWUser shareManager].Userid]) {
//            
//            return YES;
//        }else{
//            
//            return NO;
//        }
//  
//}
//
//
///**
// *  根据版本号判断 versionId   判断是否大于当前版本号。这个版本号在项目中写死。每次提交版本更新。初始值为0   逐渐递增
// *
// *  @param success
// */
//
//+(void)QDWVersionUpDataSuccess:(void(^)(id data))success{
//    
//        [XHNetWorking postWithUrl:QDWVersionUpData_URL params:nil success:^(id response) {
//            if (response) {
//                if ([response[QDWrtData] isKindOfClass:[NSNull class]]) {
//                    success(nil);
//                }else{
//                
//                 success(response[QDWrtData]);
//                }
//                
//                
//               
//                
//            }else{
//            
//                success(nil);
//            }
//            
//            
//        } fail:^(NSError *error) {
//           
//            
//        }];
//
//
//}
///**
// *
// *   获取app在appstore中的 路径
// *
// */
////#define QDWVersionOnitunUrl @"http://itunes.apple.com/lookup?id=1071221196"
//
////#define kVersionOnitunUrl @"http://itunes.apple.com/lookup?id=1071221196"
//+(void)GetAppStoreUrlSuccess:(void(^)(id data))success{
//
//      [XHNetWorking getWithUrl:QDWVersionOnitunUrl params:nil success:^(id response){
//          
//          if ([[response objectForKey:@"resultCount"]intValue]==1) {
//              NSDictionary *releaseInfo=[[response objectForKey:@"results"]objectAtIndex:0];
//              
////              NSString *lastVersion = [releaseInfo objectForKey:@"version"];
////              NSString *trackViewUrl = [releaseInfo objectForKey:@"trackViewUrl"];
//              
//              
//              
//              success(releaseInfo);
//          }else{
//              
//              success(nil);
//          }
//          
//      } fail:^(NSError *error) {
//         
//          
//      }];
//
//
//
//}

/**
 *  发送验证码
 *
 *  @param url     <#url description#>
 *  @param dic     <#dic description#>
 *  @param SendSms <#SendSms description#>
 */
+(void)SendSMSWithURL:(NSString *)url WithDic:(NSDictionary *)dic AndBlockSendSMS:(void(^)(id data))success andFailure:(void(^)(id data))failure{

   
    [XHNetWorking postWithUrl:url params:dic success:^(id response) {
        
        DLOG(@"%@",response);
        
        if (response) {
            
            NSString *str = [[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
            
            
            DLOG(@"%@",str);
            
            if (str) {
                if ([str isEqual:@"0000"]) {
                    
                    [SVProgressHUD showErrorWithStatus:@"获取失败"];
                    
                    success(nil);
                }else{
                
                    if ([str isEqual:@"-1"]) {
                        [SVProgressHUD showErrorWithStatus:@"手机号码格式错误"];
                        success(nil);
                        
                    }else if ([str isEqual:@"-2"]) {
                        [SVProgressHUD showErrorWithStatus:@"发送过于频繁，请稍后再试"];
                           success(nil);
                        
                    }else{
                       success(str);
                    
                    }
                    
                    
                 
                }
                
               
            }
            
        }
         
    } fail:^(NSError *error) {
        
        failure(error);
        
        NSLog(@"%@",error);
        
    }];
    

}
/**
 *  用户修改密码
 */

+(void)RechargePassWordWith:(NSString *)url WithDic:(NSDictionary *)dic AndBlockSuccess:(void(^)(id data))success andfailure:(void(^)(id data))failue{
    [XHNetWorking postWithUrl:url params:dic success:^(id response) {
        
        NSLog(@"%@",response);
        
        if (response) {
           
      
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[QDWrtState]];
            if ([ifRtstate isEqual:@"1"]) {
              success(response);
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"密码修改失败"];
              success(nil);
            }
   
        }
        
        
    } fail:^(NSError *error) {
        
        failue(error);
        DLOG(@"%@",error);
    
        
    }];



}

/**
 *  移动端注册认证
 */

+(void)MobileRegiseterWithUrl:(NSString *)url andImage:(UIImage *)image andDic:(NSDictionary *)dic AndSuccess:(void(^)(id data))success andfailure:(void(^)(id data))failue{
//
      [XHNetWorking uploadWithImage:image url:url filename:@"portrait.png" name:@"portrait" mimiType:@"image/png" parameters:dic progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
          
      } success:^(id response) {
          if (response) {
              NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[QDWrtState]];
              if ([ifRtstate isEqual:@"1"]) {
                  success(@"0");
                  [SVProgressHUD showErrorWithStatus:response[QDWrtMsg]];
              }else{
                  [SVProgressHUD showSuccessWithStatus:response[QDWrtMsg]];
                  success(@"1");
              }
   
          }
          
      } fail:^(NSError *error) {
          
          failue(error);
          DLOG(@"%@",error);
      }];

}

/**
 *  新的移动端注册的
 *
 *  @param dic     <#dic description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)MobileRegiseterWithDic:(NSDictionary *)dic Success:(void(^)(id data))success andfailure:(void(^)(id data))failure{

    [XHNetWorking postWithUrl:QDWwxUserRegister_URL params:dic success:^(id response) {
        if (response) {
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[QDWrtState]];
            if ([ifRtstate isEqual:@"1"]) {
                success(response);
                
            }else{
              
                [SVProgressHUD showErrorWithStatus:response[QDWrtMsg]];
                success(nil);
            }
            
        }
      
    } fail:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        
        
        DLOG(@"%@",error);
    }];



}
///**
// *  认证
// */
//+(void)CertifyWithDic:(NSDictionary *)dic Success:(void(^)(id data))success andfailure:(void(^)(id data))failure{
//    
//    [XHNetWorking postWithUrl:QDWwxUserAuthentication_URL params:dic success:^(id response) {
//        if (response) {
//            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[QDWrtState]];
//            if ([ifRtstate isEqual:@"1"]) {
//                success(response);
//                
//            }else{
//                
//                [SVProgressHUD showErrorWithStatus:response[QDWrtMsg]];
//                success(nil);
//            }
//            
//        }
//        
//    } fail:^(NSError *error) {
//        
//        failure(nil);
//        
//        DLOG(@"%@",error);
//    }];
//    
//    
//    
//}
//



@end
