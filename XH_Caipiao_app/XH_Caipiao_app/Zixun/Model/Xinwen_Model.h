//
//  Xinwen_Model.h
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/28.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Xinwen_Model : NSObject
STRING(pubDate);

STRING(title);

STRING(desc);

STRING(link);

@property(nonatomic,retain)NSMutableArray *imageurls;

@end
