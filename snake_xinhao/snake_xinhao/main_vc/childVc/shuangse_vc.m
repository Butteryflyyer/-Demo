//
//  shuangse_vc.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/11/12.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "shuangse_vc.h"
#import "TanShe.h"
@interface shuangse_vc ()

@end

@implementation shuangse_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    TanShe *sheview = [[TanShe alloc]init];
    sheview.backgroundColor = _COLOR_RGB(0xf5f5f5);
    sheview.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    [self.view addSubview:sheview];
    self.view.backgroundColor = _COLOR_RGB(0xf5f5f5);
    // Do any additional setup after loading the view.
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
