//
//  ZoushiAll_Vc.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/30.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "ZoushiAll_Vc.h"
#import "ZoushiBaseDetail_Vc.h"
#import "Zoushi_first_VcViewController.h"
#import "zoushi_Third_Vc.h"
#import "Zoushi_Second_Vc.h"
#import "Zoushi_Four_Vc.h"
#import "Zoushi_five_Vc.h"
#import "SGPageView.h"
@interface ZoushiAll_Vc ()<SGPageTitleViewDelegate, SGPageContentViewDelegare>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@end

@implementation ZoushiAll_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageView];
    [self addNavBarTitle:self.title_text];
    // Do any additional setup after loading the view.
}

- (void)setupPageView {
    ZoushiBaseDetail_Vc *oneVC = [[ZoushiBaseDetail_Vc alloc] init];
    oneVC.style_url = self.style_url;
    Zoushi_first_VcViewController *twoVC = [[Zoushi_first_VcViewController alloc] init];
    twoVC.style_url = self.style_url;
    zoushi_Third_Vc *threeVC = [[zoushi_Third_Vc alloc] init];
    threeVC.style_url = self.style_url;
    Zoushi_Second_Vc *fourVC = [[Zoushi_Second_Vc alloc] init];
    Zoushi_Four_Vc *fiveVC = [[Zoushi_Four_Vc alloc] init];
    Zoushi_five_Vc *sixVC = [[Zoushi_five_Vc alloc] init];

    fourVC.style_url = self.style_url;
    fiveVC.style_url = self.style_url;
    sixVC.style_url = self.style_url;
    
    
    NSArray *childArr = @[oneVC, twoVC, threeVC, fourVC, fiveVC, sixVC];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height - 108;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *titleArr = @[@"第一天", @"第二天", @"第三天", @"第四天", @"第五天", @"第六天"];
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44) delegate:self titleNames:titleArr];
    self.pageTitleView.selectedIndex = 0;
    [self.view addSubview:_pageTitleView];
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeEqual;
}

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
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
