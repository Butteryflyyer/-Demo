//
//  BaseViewController.h
//  Caipiao_app
//
//  Created by 信昊 on 17/6/23.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**
 *  返回的button。可以在viewcontroll中用rac来接收回调
 */
@property(nonatomic,strong)UIButton *BackButton;
// 设置导航条的title
-(void)addNavBarTitle:(NSString *)title;
-(void)pushIntoLoginVc;
@end
