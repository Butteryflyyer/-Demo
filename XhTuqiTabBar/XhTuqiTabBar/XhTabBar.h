//
//  XhTabBar.h
//  XhTuqiTabBar
//
//  Created by 信昊 on 17/3/3.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XhTabBar;
@protocol XHTabBarDelegate <NSObject>
@optional
-(void)tabBarMidBtnClick:(XhTabBar *)tabBar;

@end


@interface XhTabBar : UITabBar

@property(nonatomic, weak)id <XHTabBarDelegate>myDelegate;

@end
