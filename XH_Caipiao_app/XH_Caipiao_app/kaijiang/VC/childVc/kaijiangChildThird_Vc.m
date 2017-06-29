
//
//  kaijiangChildThird_Vc.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/28.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "kaijiangChildThird_Vc.h"

@interface kaijiangChildThird_Vc ()

@end

@implementation kaijiangChildThird_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Code = @"fjtc31x7";
    self.icon_image = @"image3";
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    [self loadData];
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
