//
//  XHTabBarContrller.m
//  XhTuqiTabBar
//
//  Created by 信昊 on 17/3/3.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "XHTabBarContrller.h"
#import "XhTabBar.h"
#import "firstViewController.h"
#import "secondViewController.h"
#import "thirdViewController.h"
#import "fourthViewController.h"
#import "MidViewController.h"
#import "XHNavigationController.h"
@interface XHTabBarContrller ()<XHTabBarDelegate>

@end

@implementation XHTabBarContrller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildVc];
    
    XhTabBar *tabBar = [[XhTabBar alloc]init];
    tabBar.myDelegate = self;
    
    [self setValue:tabBar forKeyPath:@"tabBar"];
    // Do any additional setup after loading the view.
}
- (void)setUpAllChildVc
{
    
    
    firstViewController *HomeVC = [[firstViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"home_normal" selectedImage:@"home_highlight" title:@"首页"];
    
    secondViewController *FishVC = [[secondViewController alloc] init];
    [self setUpOneChildVcWithVc:FishVC Image:@"fish_normal" selectedImage:@"fish_highlight" title:@"鱼塘"];
    
    thirdViewController *MessageVC = [[thirdViewController alloc] init];
    [self setUpOneChildVcWithVc:MessageVC Image:@"message_normal" selectedImage:@"message_highlight" title:@"消息"];
    
    fourthViewController *MineVC = [[fourthViewController alloc] init];
    [self setUpOneChildVcWithVc:MineVC Image:@"account_normal" selectedImage:@"account_highlight" title:@"我的"];
    
    
}
#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    XHNavigationController *nav = [[XHNavigationController alloc] initWithRootViewController:Vc];
    
    
    Vc.view.backgroundColor = [self randomColor];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;
    
    Vc.navigationItem.title = title;
    
    [self addChildViewController:nav];
    
}

#pragma mark - ------------------------------------------------------------------
#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarMidBtnClick:(XhTabBar *)tabBar
{
    
    
    MidViewController *plusVC = [[MidViewController alloc] init];
    plusVC.view.backgroundColor = [self randomColor];
    
    XHNavigationController *navVc = [[XHNavigationController alloc] initWithRootViewController:plusVC];
    
    [self presentViewController:navVc animated:YES completion:nil];
    
    
    
}


- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
