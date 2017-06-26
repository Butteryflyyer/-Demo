//
//  LoginUserModel.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/5/3.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "LoginUserModel.h"

@interface LoginUserModel ()<NSCoding>




@end

@implementation LoginUserModel


-(void)encodeWithCoder:(NSCoder *)aCoder{//归档
       [aCoder encodeObject:self.id forKey:@"id"];
       [aCoder encodeObject:self.name forKey:@"name"];
       [aCoder encodeObject:self.password forKey:@"password"];
       [aCoder encodeObject:self.avatarpath forKey:@"avatarpath"];
       [aCoder encodeObject:self.cardnum forKey:@"cardnum"];
       [aCoder encodeObject:self.birthday forKey:@"birthday"];
       [aCoder encodeObject:self.phone forKey:@"phone"];
       [aCoder encodeObject:self.email forKey:@"email"];
       [aCoder encodeObject:self.workcity forKey:@"workcity"];
       [aCoder encodeObject:self.accountbalance forKey:@"accountbalance"];
       [aCoder encodeObject:self.integral forKey:@"integral"];
    [aCoder encodeObject:self.userCount forKey:@"userCount"];
    [aCoder encodeObject:self.userpassword forKey:@"userpassword"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder{//解档
  
    if (self = [super init]) {
        
        self.id = [aDecoder decodeObjectForKey:@"id"];
         self.name = [aDecoder decodeObjectForKey:@"name"];
         self.password = [aDecoder decodeObjectForKey:@"password"];
         self.avatarpath = [aDecoder decodeObjectForKey:@"avatarpath"];
         self.cardnum = [aDecoder decodeObjectForKey:@"cardnum"];
         self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
         self.phone = [aDecoder decodeObjectForKey:@"phone"];
          self.email = [aDecoder decodeObjectForKey:@"email"];
          self.workcity = [aDecoder decodeObjectForKey:@"workcity"];
        self.accountbalance = [aDecoder decodeObjectForKey:@"accountbalance"];
        self.integral = [aDecoder decodeObjectForKey:@"integral"];
        self.userCount = [aDecoder decodeObjectForKey:@"userCount"];
        self.userpassword = [aDecoder decodeObjectForKey:@"userpassword"];
        
    }
    
    return self;
}



+(void)LoginQDWWithUrl:(NSString *)url AndDic:(NSDictionary *)dic BlockSuccess:(void(^)(id data))success WithBlockFail:(void(^)(id data))failure{
    
    [XHNetWorking postWithUrl:url params:dic success:^(id response) {
        
        
        
        if (response) {
            
            NSString *ifRtstate = [NSString stringWithFormat:@"%@",response[QDWrtState] ];
            if ([ifRtstate isEqual:@"1"]) {
                
                
                success([self getResponseObjectHead:response]);
                
                
            }else{
                
                if ([[NSString stringWithFormat:@"%@",response[QDWrtData]] isEqual:@"0"]) {
                    [SVProgressHUD showErrorWithStatus:response[QDWrtMsg]];
                    
                }
                if ([[NSString stringWithFormat:@"%@",response[QDWrtData]] isEqual:@"1"]) {
                    
                    [SVProgressHUD showErrorWithStatus:@"手机号密码错误"];
                    
                }
                
                
                success(nil);
                
            }
            
        }
        
        DLOG(@"%@",response);
        
        DLOG(@"%@",[QDWUser shareManager].Userid);

        
        
    } fail:^(NSError *error) {
        
        failure(error);
        
   //error	NSError *	domain: @"kCFErrorDomainCFNetwork" - code: 310	0x000060000024dfb0
    }];
    
    
}
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



@end
