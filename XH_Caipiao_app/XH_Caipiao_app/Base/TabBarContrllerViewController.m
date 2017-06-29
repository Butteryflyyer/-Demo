//
//  QDWTabBarContrllerViewController.m
//  钱到位
//
//  Created by dudu on 16/3/31.
//  Copyright © 2016年 zhongyingshengke. All rights reserved.
//

#import "TabBarContrllerViewController.h"
#import "Zoushi_Vc.h"
#import "Mine_Vc.h"
#import "Kaijiang_Base_Vc.h"
#import "Zixun_Vc.h"
#import "Login_Vc.h"
@interface TabBarContrllerViewController ()<UITabBarControllerDelegate>

/** smallCircleImageView */
@property(nullable, nonatomic, weak) UIImageView *smallCircleImageView;
@property(nullable, nonatomic, weak) UIView *smallCircleView;
@end

@implementation TabBarContrllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate   = self;


    // 设置Item属性
    [self setupItem];

    // 添加子控制器
    [self setupChildVcs];



    [self hideTabbarTopWire];
}

-(void)hideTabbarTopWire{


    CGRect rect                                    = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    UIGraphicsBeginImageContext(rect.size);

    CGContextRef context                           = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);

    CGContextFillRect(context, rect);

    UIImage *img                                   = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
   [self.tabBar setBackgroundColor:[UIColor whiteColor]];
}



/**
 *  设置Item属性
 */

- (void)setupItem {

    // UIControlStatueNomal状态下属性
    NSMutableDictionary *normalAttrs               = [NSMutableDictionary dictionary];
    // 设置文字颜色
    normalAttrs[NSForegroundColorAttributeName]    = [UIColor grayColor];
    // 设置文字大小
    normalAttrs[NSFontAttributeName]               = [UIFont systemFontOfSize:10]; //12

    // UIControlStatueSelected状态下属性
    NSMutableDictionary *selectedAttrs             = [NSMutableDictionary dictionary];
    // 文字颜色
    selectedAttrs[NSForegroundColorAttributeName]  = [UIColor orangeColor];

    // 统一给所有UITabBarItem设置文字属性
    UITabBarItem *item                             = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

}



- (void)setupChildVcs {

    // 添加4个子控制器
    [self setupChildVc:[[Zixun_Vc alloc] init] title:@"资讯" image:@"ToolBar首页" selectedImage:@"ToolBar首页-状态"];
    [self setupChildVc:[[Zoushi_Vc alloc] init] title:@"彩票种类" image:@"ToolBar发单" selectedImage:@"ToolBar发单-状态"];
    [self setupChildVc:[[Kaijiang_Base_Vc alloc] init] title:@"开奖" image:@"ToolBar找单" selectedImage:@"ToolBar找单-状态"];

    [self setupChildVc:[[Mine_Vc alloc] init] title:@"我的" image:@"ToolBar我的" selectedImage:@"ToolBar我的-状态"];

}

/**
 *  添加子控制器
 *  @param title        文字
 *  @param imge         图片
 *  @param selectedName 选中时图片
 */

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {

    // 包装一个导航控制器
    UINavigationController *nav                    = [[UINavigationController alloc] initWithRootViewController:vc];



    // 设置子控制器的tabBarItem
    vc.tabBarItem.title                            = title;
    //    vc.tabBarItem.image = [UIImage imageNamed:image];
    //    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];

    // 对tabbar上的图片重新绘制
    UIImage * normalImage                          = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage                          = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem                                  = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectImage];


    //    // 对tabbar上的文字重新绘制
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : _COLOR_RGB(0xe72a2d)} forState:UIControlStateSelected];
    //


    UIImageView *ShaowView                         = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"投影tabbar"]];

    ShaowView.frame                                = CGRectMake(0, SCREEN_HEIGHT - 59, SCREEN_WIDTH, 10);



    [vc.view addSubview:ShaowView];


    [self addChildViewController:nav];

}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
        Login_Vc *Login   = [[Login_Vc alloc]init];
    if ([viewController.childViewControllers[0] isKindOfClass:[Mine_Vc class]] ||[viewController.childViewControllers[0] isKindOfClass:[Kaijiang_Base_Vc class]] ) {
        
        if (![QDWUser shareManager].Userid.length) {
            Login.hidesBottomBarWhenPushed = YES;
            
            [(UINavigationController *)[tabBarController.viewControllers objectAtIndex:tabBarController.selectedIndex] pushViewController:Login animated:YES];
            
            return NO;
        }else{
            return YES;
       }
    }else{
        return YES;
    }


}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animationWithIndex:index];//动画
}
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
}



@end
