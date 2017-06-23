//
//  BaseViewController.m
//  Caipiao_app
//
//  Created by 信昊 on 17/6/23.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = _COLOR_RGB(0xf5f5f5);
    // Do any additional setup after loading the view.
    

    
    
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
