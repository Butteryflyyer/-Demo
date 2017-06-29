//
//  XinwenChild_second.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/28.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "XinwenChild_second.h"


@interface XinwenChild_second ()

@end

@implementation XinwenChild_second

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.category = @"篮球";
    [self loadData];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.category = @"篮球";
    [self loadData];;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
