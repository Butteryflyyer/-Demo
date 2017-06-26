//
//  QDWLoginManager.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/5/3.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "QDWLoginManager.h"

@implementation QDWLoginManager


+(id)shareManager{
   
    static QDWLoginManager *shareManager = nil;
  
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareManager = [[self alloc]init];

    });
    
    return shareManager;

}

-(instancetype)init{
    
    if (self = [super init]) {
        
        self.UserAcount = [NSKeyedUnarchiver unarchiveObjectWithFile:self.accountPath];
    }
    
    return self;
}

//账号信息缓存
-(NSString *)accountPath{
    
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
    
    DLOG(@"%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserAccount.plist"]);
    
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserAccount.plist"];
    
}
//登录

-(void)setUserAcount:(LoginUserModel *)UserAcount{
    _UserAcount = UserAcount;
    
    [QDWUser shareManager].Userid = _UserAcount.id;
    
    [QDWUser shareManager].Username = _UserAcount.name;

    [QDWUser shareManager].UserTelephone = _UserAcount.phone;
    
    [QDWUser shareManager].UserCity = _UserAcount.workcity;
    
    [QDWUser shareManager].UserIntegral = _UserAcount.integral; // 用户积分
    
    
    [QDWUser shareManager].UserAcountMoney = [NSString stringWithFormat:@"%.2f",[_UserAcount.accountbalance floatValue]];// 用户所剩金额
    
    NSUSER_SAVE(_UserAcount.id, QDWSaveUserId);//存用户id
    
    NSUSER_SAVE(_UserAcount.workcity, QDWSaveCity);//存用户id
    
    NSUSER_SAVE(_UserAcount.name, QDWSaveUserName);// 用户姓名
    
//    NSUSERDEFAULTSAVEBOOL(YES, QDWUmengPushSwitchBtn); //登录的时候默认是打开的 推送
    [QDWUser shareManager].UserTelephone = NSUSER_OBJECTFORRKEY(QDWSaveNameAcount);
    [QDWUser shareManager].Userpassword = [SSKeychain passwordForService:KeyChain_Service account:NSUSER_OBJECTFORRKEY(QDWSaveNameAcount)];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
// 退出

-(void)UsrExitLogin{
     DLOG(@"%@",[SSKeychain allAccounts]);
    DLOG(@"%@",[SSKeychain accountsForService:KeyChain_Service]);
  

    NSArray *KeyChain = [SSKeychain accountsForService:KeyChain_Service];
    
    [KeyChain enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        [SSKeychain deletePasswordForService:KeyChain_Service account:dic[@"acct"]];
        
    }];
    
    [QDWUser shareManager].Userid = nil;
    
    [QDWUser shareManager].Username = nil;
    
    [QDWUser shareManager].Userpassword = nil;
    
    [QDWUser shareManager].UserTelephone = nil;
    
    [QDWUser shareManager].UserCity = nil;
    
    [QDWUser shareManager].UserIntegral = nil; // 用户积分
    
    NSUSERE_MOVEOBJECT(QDWSaveNameAcount);
    
    NSUSERE_MOVEOBJECT(QDWSaveUserId);
    NSUSERE_MOVEOBJECT(QDWSaveCity);
    NSUSERE_MOVEOBJECT(QDWSaveUserName);
    NSUSERE_MOVEOBJECT(NowCity);
    NSUSERE_MOVEOBJECT(FirstSelectedCity);
    
//    NSUSEREMOVEOBJECT(QDWUmengPushSwitchBtn);
    
    [[NSUserDefaults standardUserDefaults]synchronize];

    BOOL bRet = [[NSFileManager defaultManager] fileExistsAtPath:self.accountPath];
    if (bRet) {
        //
        NSError *err;
        [[NSFileManager defaultManager] removeItemAtPath:self.accountPath error:&err];
    }
    [[NSURLSession sharedSession] resetWithCompletionHandler:^{}];
}

-(void)UserExitLoginFirstInNewVersion{

    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    if (!NSUSER_OBJECTFORRKEY(currentVersion)) {
        if ([currentVersion isEqual:@"2.78"]) {
            
            NSUSER_SAVE(@"2.78", currentVersion);
            
            [self UsrExitLogin];
            
            
        }
 
    }
    
  
}

@end
