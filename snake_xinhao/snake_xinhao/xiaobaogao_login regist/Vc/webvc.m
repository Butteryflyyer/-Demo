//
//  webvc.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/29.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "webvc.h"

@interface webvc ()<UIWebViewDelegate>

@end

@implementation webvc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://weiheng.appwcp.com/wan1.php"]]];
    web.delegate = self;
    [self.view addSubview:web];
    
    // Do any additional setup after loading the view.
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
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
