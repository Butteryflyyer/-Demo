//
//  LoginUserModel.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/5/3.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "LoginUserModel.h"

@implementation LoginUserModel

//-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//
//    if ([key isEqualToString:@"id"]) {
//
//        self.idd = value;
//
//    }
//
//
//}

+(void)LoginQDWWithUrl:(NSString *)url AndDic:(NSDictionary *)dic BlockSuccess:(void(^)(id data))success WithBlockFail:(void(^)(id data))failure{
    
    [WSNetWorking postWithUrl:url params:dic success:^(id response) {
        
        
        
        if (response) {
            
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[@"rtState"] ];
            if ([ifRtstate isEqual:@"1"]) {
                
                
                success([self getResponseObjectHead:response]);
                
                
            }else{
                
                if ([[NSString stringWithFormat:@"%@",response[@"rtData"]] isEqual:@"0"]) {
                    [SVProgressHUD showErrorWithStatus:response[@"rtMsg"]];
                    
//                     success(nil);
                }
                if ([[NSString stringWithFormat:@"%@",response[@"rtData"]] isEqual:@"1"]) {
//                       success(nil);
//                    [SVProgressHUD showErrorWithStatus:@"手机号密码错误"];
                    
                }
                
                
                success(nil);
                
            }
            
        }
  
        
        
    } fail:^(NSError *error) {
        
        failure(error);
        
        
    }];
    
    
}
//[4]    (null)    @"NSErrorFailingURLKey" : @"https://www.zyskcn.com/qdw/UserController/mobileLogin.act?"
+(id)getResponseObjectHead:(id)responseObject{
    
    if(!responseObject){
        return nil;
    }
    
    NSDictionary *head  = nil;
    
    if([responseObject objectForKey:@"rtData"]){
        head = [responseObject objectForKey:@"rtData"];
    }else{
        return nil;
    }
    return head;
    
    
    
}

- (void)setCardnum:(NSString *)cardnum {
    _cardnum = cardnum;
    if (cardnum) {
        _hasChecked = YES;
    }
}
/**
 *  微信端个人发单、TOP10排行
 *
 *  @param url     <#url description#>
 *  @param userid  <#userid description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)GetReleaseBillTopTenWithurl:(NSString *)url Withuserid:(NSString *)userid SuccessBlock:(void(^)(id data))success Failure:(void(^)(id data))failure{
    
    
    NSDictionary *dic = @{@"userId":userid};
    
    [WSNetWorking postWithUrl:url params:dic success:^(id response) {
        if (response) {
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[@"rtState"]];
            if ([ifRtstate isEqual:@"1"]) {
                success(response[@"rtData"]);
                
                
                
            }else{
                
                success(nil);
            }
        }
        
        
    } fail:^(NSError *error) {
        

        
    }];
    
}
/**
 *  查询签到日期
 *
 *  @param url     <#url description#>
 *  @param userid  <#userid description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)SignDateWithurl:(NSString *)url WithUserid:(NSString *)userid SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure{
    NSDictionary *dic;
    if (userid) {
        
        dic = @{@"userId":userid};
    }
    
    
    
    [WSNetWorking postWithUrl:url params:dic success:^(id response) {
        
        if (response) {
            
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[@"rtState"]];
            if ([ifRtstate isEqual:@"1"]) {
//                DLOG(@"%@",response);
                success(response[@"rtData"]);
                
                
            }else{
                
                success(nil);
            }
            
        }
        
    } fail:^(NSError *error) {
        
    }];
}

+(void)MobileRegiseterWithDic:(NSDictionary *)dic Success:(void(^)(id data))success andfailure:(void(^)(id data))failure{
    
    [WSNetWorking postWithUrl:QDWwxUserRegister_URL params:dic success:^(id response) {
        if (response) {
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[@"rtState"]];
            if ([ifRtstate isEqual:@"1"]) {
                success(response);
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:response[@"rtMsg"]];
                success(nil);
            }
            
        }
        
    } fail:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        

    }];
    
    
    
}


@end
