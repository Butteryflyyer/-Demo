//
//  BaseViewController.m
//  Caipiao_app
//
//  Created by 信昊 on 17/6/23.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "BaseViewController.h"
#import "UINavigationBar+BackgroundColor.h"
#import "Login_Vc.h"
@interface BaseViewController ()
{
    
    UIImageView *navBarHairlineImageView;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = _COLOR_RGB(0xf5f5f5);
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;

    [self.navigationController.navigationBar KPSetBackgroundColor:_COLOR_RGB(0xe72a2d)];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }

    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:FontBold(QDWRealValue(18)),//[UIFont systemFontOfSize:QDWRealValue(18)],//17
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

        navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    if ([self.tabBarItem.title isEqual:@"资讯"]|| [self.tabBarItem.title isEqual:@"彩票种类"]||[self.tabBarItem.title isEqual:@"开奖"]||[self.tabBarItem.title isEqual:@"我的"]) {
        
        DLOG(@"");
        
        
    }else{
        self.BackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.BackButton.frame = CGRectMake(0, 5, QDWRealValue(27), QDWRealValue(27));
        
        [self.BackButton setImage:[UIImage imageNamed:@"个人信息返回"] forState:UIControlStateNormal];
        [self.BackButton addTarget:self action:@selector(backFirst) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backbtn = [[UIBarButtonItem alloc]initWithCustomView:self.BackButton];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
        
        negativeSpacer.width = -5;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer,backbtn];
        
    }

}
/**
 *  返回按钮
 */
-(void)backFirst{
  
        [self.navigationController popViewControllerAnimated:YES];
        

}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        navBarHairlineImageView.hidden = YES;
     [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[NSString stringWithFormat:@"%@",[obj class]] isEqual:@"UINavigationItemButtonView"]) {
            [obj setHidden:YES];
        }
        
    }];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    navBarHairlineImageView.hidden = NO;

}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
// 设置导航条的title
-(void)addNavBarTitle:(NSString *)title
{
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLabel.text = title;
    titleLabel.font = FontBold(QDWRealValue(18));//FontSystem(QDWRealValue(19));
    titleLabel.textColor = _COLOR_RGB(0xffffff);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = titleLabel;
}
#pragma mark --- 进入登录界面

-(void)pushIntoLoginVc{
    
    Login_Vc *loginvc = [[Login_Vc alloc]init];
    loginvc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:loginvc animated:YES];
    
    
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
