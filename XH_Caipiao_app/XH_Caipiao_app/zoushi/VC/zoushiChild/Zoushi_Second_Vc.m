//
//  Zoushi_Second_Vc.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/30.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Zoushi_Second_Vc.h"

@interface Zoushi_Second_Vc ()

@end

@implementation Zoushi_Second_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.Time_Date = 24 * 2 * 60 *60;
    [self loadata];
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