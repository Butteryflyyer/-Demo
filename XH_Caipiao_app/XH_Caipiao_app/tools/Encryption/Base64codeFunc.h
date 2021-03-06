//
//  Base64codeFunc.h
//  GymStudent
//
//  Created by Li Zhijie on 15-8-1.
//  Copyright (c) 2015年 Li Zhijie. All rights reserved.
//

#ifndef GymStudent_Base64codeFunc_h
#define GymStudent_Base64codeFunc_h

#import <Foundation/Foundation.h>

/******字符串转base64（包括DES加密）******/
#define __BASE64( text )        [Base64codeFunc base64StringFromText:text]

/******base64（通过DES解密）转字符串******/
#define __TEXT( base64 )        [Base64codeFunc textFromBase64String:base64]

@interface Base64codeFunc : NSObject

/************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 **********************************************************/
+ (NSString *)base64StringFromText:(NSString *)text;

/************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 **********************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64;


+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

+ (NSString *)base64EncodedStringFrom:(NSData *)data;




@end

#endif
