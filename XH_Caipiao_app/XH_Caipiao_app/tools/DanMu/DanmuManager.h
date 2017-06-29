//
//  DanmuManager.h
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/28.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanmuManager : NSObject
+(DanmuManager *)shareManager;

-(void)ShowDanmuWithView:(UIView *)myview;
@end
