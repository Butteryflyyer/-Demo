//
//  NetManager.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/23.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager
+(id)shareManager{
        
        static NetManager *shareManager = nil;
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            shareManager = [[self alloc]init];
            
        });
        
        return shareManager;
        
}
/*
 result	开奖信息		开彩信息
 - name	String	双色球	彩票名称
 - code	String	ssq	彩票类型编码
 - expect	String	2015022743	多少区开奖编号
 - time	String	2015-02-27 15:41:30	开奖时间字符串
 - timestamp	Number	1425022890000	开奖时间戳
 - openCode	String	03,04,11,09,05	中将号码
 error	String	找不到对应彩票类型	出错或异常信息
 */
-(void)postNetWithStyle:(Selet_enum)my_enum Withdic:(NSDictionary *)dic Success:(void(^)(NSDictionary * data))success{
    
    ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:Caipiao_appId andSign:Caipiao_appSecret_post];
    
    NSString *url = @"";
    switch (my_enum) {
        case ZuiXin_Style:
            url = @"https://route.showapi.com/44-1";
            break;
        case Duoqi_Style:
            url = @"https://route.showapi.com/44-2";
            break;
        case Danqi_Style:
            url = @"https://route.showapi.com/44-3";
            break;
        
        default:
            break;
    }
    
    
    //调用彩票开奖查询api
    
    [request post:url//最新开奖接入点的接口url，注意您需要先订购该接口免费套餐才能测试
          timeout:20000//超时设置为20秒
           params:dic//传入特定参数查询双色球最新开奖信息
   withCompletion:^(NSDictionary<NSString *,id> *result) {
       //打印返回结果
       
       NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
       // NSData转为NSString
       NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
       
       NSLog(@"返回结果为：%@",jsonStr);
    
       NSDictionary *jsondic = [jsonStr mj_JSONObject];
       
       success(jsondic);
       
       
   }];

}


@end
