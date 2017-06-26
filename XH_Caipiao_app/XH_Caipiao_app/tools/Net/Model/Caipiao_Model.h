//
//  Caipiao_Model.h
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import <Foundation/Foundation.h>

//
//"showapi_res_code": 0,
//"showapi_res_error": "",
//"showapi_res_body": {
//    "result": [
//               {
//                   "timestamp": 1470748900,
//                   "expect": "2016092",
//                   "time": "2016-08-09 21:21:40",
//                   "name": "双色球",
//                   "code": "ssq",
//                   "openCode": "02,13,15,23,24,29+06"
//               },
//               }]

@interface Caipiao_Model : NSObject

@property(nonatomic,copy)NSString *timestamp;

@property(nonatomic,copy)NSString *expect;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy)NSString *openCode;





@end
