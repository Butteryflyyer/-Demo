//
//  ViewController.m
//  HybridPreLoading
//
//  Created by 魏诗豪 on 16/3/13.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ViewController.h"
#import "HybridPreLoading.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [NSURLProtocol registerClass:[HybridPreLoading class]];
    
//    [NSURLProtocol unregisterClass:[HybridPreLoading class]];
    
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:urlCache];
    
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    
//    NSURL *url = [NSURL URLWithString:@"http://m.58.com/"];
    NSURL *url = [NSURL URLWithString:@"http://wap.3g.net.cn/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}


@end
