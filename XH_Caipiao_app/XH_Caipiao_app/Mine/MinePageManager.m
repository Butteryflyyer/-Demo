             //
//  MinePageManager.m
//  QianDaoWeiApp
//
//  Created by 融联 on 16/5/9.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "MinePageManager.h"

@implementation MinePageManager

+(id)shareManager{
    
    static MinePageManager *shareManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareManager = [[self alloc]init];
        shareManager.unReadNewsCount = 0;
    });
    
    
    return shareManager;
    
}

/**
 *  获取用户信息
 *

 */
+(void)GetUserInfoDataWithUrl:(NSString *)url SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure {
    
    [XHNetWorking postWithUrl:url params:nil success:^(id response) {
        
        if (response) {
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[QDWrtState]];
            if ([ifRtstate isEqual:@"1"]) {
                success(response[QDWrtData]);
                
            }else{
                
                success(nil);
            }
        }
        
    } fail:^(NSError *error) {
        failure(error);
        
        
    }];
    
}
/**
 个人中心第一页获取个人信息的接口
 
 @param success <#success description#>
 */
+ (void)getMySelfInfoWithSuccessBlock:(void(^)(id data))success{
    
    [XHNetWorking postWithUrl:QDWgetMySelfInfo_URL params:@{@"userId":[QDWUser shareManager].Userid} success:^(id response) {
        if (response) {
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[QDWrtState]];
            if ([ifRtstate isEqual:@"1"]) {
                success(response[QDWrtData]);
            }else{
                success(nil);
            }
        }
        
    } fail:^(NSError *error) {
        DLOG(@"请求失败");
        
    }];
}

/**
 *  编辑个人信息
 *

 */
+(void)EditInfoWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure {
    
    //  NSDictionary *dict = @{@"userId":userid};
    
    [XHNetWorking postWithUrl:url params:dict success:^(id response) {
        
        if (response) {
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[QDWrtState]];
            if ([ifRtstate isEqual:@"1"]) {
                success(response[QDWrtData]);
                
            }else{
                success(nil);
            }
        }
        
    } fail:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  重置登录密码
 *

 */
+(void)ResetLoginPasswordDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure {
    
    [XHNetWorking postWithUrl:url params:dict success:^(id response) {
        
        DLOG(@"%@", response);
       
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
        failure(error);
        
        
    }];
    
}



/**
 *  个人中心（包含银行卡信息）
 */
+ (void)GetMineInfoDataWithUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure {
    
    //  NSDictionary *dict = @{@"userId":userid};
    
    [XHNetWorking postWithUrl:url params:dict success:^(id response) {
        
        if (response) {
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[QDWrtState]];
            if ([ifRtstate isEqual:@"1"]) {
                success(response[QDWrtData]);
                
            }else{
                
                success(nil);
            }
        }
        
    } fail:^(NSError *error) {
        failure(error);
    }];
}
/**
 *  邀请好友数
 */
+(void)InviteFriendUrl:(NSString *)url WithDict:(NSDictionary *)dict SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure {
    
    [XHNetWorking postWithUrl:url params:dict success:^(id response) {
        
        DLOG(@"%@", response);
        if (response) {
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[QDWrtState]];
            if ([ifRtstate isEqual:@"1"]) {
                success(response[QDWrtData]);
                
            }else{
                
                success(nil);
            }
        }
        
    } fail:^(NSError *error) {
        failure(error);
        
        
    }];
    
}

/**
 *  生成二维码
 *
 *  @param url
 *  @param dic
 *  @param success
 *  @param failure
 */
+(void)CreatQRCodeWithUrl:(NSString *)url SuccessBlock:(void(^)(id data))success FailureBlock:(void(^)(id data))failure {
    
    [XHNetWorking postWithUrl:url params:nil success:^(id response) {
        
        //        DLOG(@"%@", response);
        if (response) {
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[QDWrtState]];
            if ([ifRtstate isEqual:@"1"]) {
                success(response[QDWrtData]);
                
            }else{
                
                success(nil);
            }
        }
        
    } fail:^(NSError *error) {
        failure(error);
        
        
    }];
    
}


@end
