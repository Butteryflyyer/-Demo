//
//  NSString+Chinese.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/6/24.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "NSString+Chinese.h"

@implementation NSString (Chinese)



//判断是否是纯汉字 - (BOOL)includeChinese;
//判断是否含有汉字 @end NSString+Chinese.m #import "NSString+Chinese.h" @implementation NSString (Chinese)
-(BOOL)isChinese {
    
    
    NSString *match = @"(^[u4e00-u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    
 
    
    return [predicate evaluateWithObject:self];


}
-(BOOL)includeChinese {
    for(int i=0; i< [self length];i++) {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            
            return YES;
        }
        
        
    }
    return NO;
}


@end
