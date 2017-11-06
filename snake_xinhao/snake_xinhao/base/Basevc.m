//
//  Basevc.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "Basevc.h"

@interface Basevc ()

@end

@implementation Basevc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self)
    self.navigationItem.leftBarButtonItem = [self BackbarItem:^{
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.view.backgroundColor =_COLOR_RGB(0xf5f5f5);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden = NO;
}
-(UIBarButtonItem *)BackbarItem:(void(^)(void))back{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 23, 23);
    [btn setImage:IMG(@"back_btn") forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        back();
    }];
    UIBarButtonItem *leftbarItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return leftbarItem;
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
