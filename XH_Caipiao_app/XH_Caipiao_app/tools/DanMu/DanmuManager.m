
//
//  DanmuManager.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/28.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "DanmuManager.h"
#import "HLDanMuImage.h"

#import "HLDanMuModel.h"

#import<libkern/OSAtomic.h>
#import "HLDanMuManagerView.h"
@implementation DanmuManager

+(id)shareManager{
    
    static DanmuManager *shareManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareManager = [[self alloc]init];
        
    });
    
    return shareManager;
    
}
-(void)ShowDanmuWithView:(UIView *)myview{
    
   HLDanMuManagerView * danmuView = [[[NSBundle mainBundle]loadNibNamed:@"HLDanMuManagerView" owner:self options:nil]firstObject];
    
    danmuView.frame = CGRectMake(0, 65, SCREEN_WIDTH, 400);
    
    danmuView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    
    [myview addSubview:danmuView];
    
    //    [self.view bringSubviewToFront:self.danmuView];
    
    danmuView.userInteractionEnabled = NO;
    NSMutableArray * danmuDataSources   = [NSMutableArray array];
    
    //预加载数据
    NSString *path      = [[NSBundle mainBundle] pathForResource:@"danmu" ofType:@"plist"];
    NSArray *dataSource = [NSArray arrayWithContentsOfFile:path];
    
    //产生模型
    [dataSource enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HLDanMuModel *model = [[HLDanMuModel alloc] initWithDic:dict];
        
        [danmuDataSources addObject:model];
        
    }];
    
    __block int32_t timeOutCount=15;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        OSAtomicDecrement32(&timeOutCount);
        //随机获取一个模型
        NSInteger index = arc4random_uniform((UInt32)danmuDataSources.count);
        
        //获取模型
        HLDanMuModel *danmuModel = danmuDataSources[index];
        
        //返回实例
        HLDanMuImage *danmuImage = [danmuView imageWithDanMuModel:danmuModel];
        
        danmuImage.x = [UIApplication sharedApplication].keyWindow.bounds.size.width;
        danmuImage.y = arc4random_uniform(345);
        
        //添加弹幕
        [danmuView addDanMuImage:danmuImage];
        
        
        
        if (timeOutCount == 0) {
            NSLog(@"timersource cancel");
            [danmuView removeFromSuperview];
            
            dispatch_source_cancel(timer);
        }
    });
    
    dispatch_source_set_cancel_handler(timer, ^{
        NSLog(@"timersource cancel handle block");
    });
    
    dispatch_resume(timer);
    

    
    
}

@end
