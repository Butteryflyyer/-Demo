//
//  Zixun_Web.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Zixun_Web.h"

@interface Zixun_Web ()<UIWebViewDelegate>

@end

@implementation Zixun_Web

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavBarTitle:@"资讯中心"];
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    webView.scalesPageToFit = YES;// 适应手机
    webView.delegate = self;
    [self.view addSubview:webView];
    
    [[NSURLCache sharedURLCache]removeAllCachedResponses];
    // 加载网页
    NSURL * url = [NSURL URLWithString:@"http://www.zhcw.com/xinwen/caizhongxinwen-ssq/11678892.shtml"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

    
    
    
    
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
