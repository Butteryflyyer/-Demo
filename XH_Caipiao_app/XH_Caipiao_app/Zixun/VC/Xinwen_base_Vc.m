//
//  Xinwen_base_Vc.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/28.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Xinwen_base_Vc.h"
#import "XinwenChild_first.h"
#import "XinwenChild_second.h"
#import "XinwenChild_third.h"
#import "XinwenChild_fourth.h"
#import "Xinwen_Vc.h"
@interface Xinwen_base_Vc ()<SGPageTitleViewDelegate, SGPageContentViewDelegare>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@end

@implementation Xinwen_base_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageView];
    [self addNavBarTitle:@"最新资讯"];
    // Do any additional setup after loading the view.
}
- (void)setupPageView {
    XinwenChild_first *oneVC = [[XinwenChild_first alloc] init];
    XinwenChild_second *twoVC = [[XinwenChild_second alloc] init];
    XinwenChild_third *threeVC = [[XinwenChild_third alloc] init];
    XinwenChild_fourth *fourVC = [[XinwenChild_fourth alloc] init];
    Xinwen_Vc *fiveVc = [[Xinwen_Vc alloc]init];
    NSArray *childArr = @[oneVC, twoVC, threeVC, fourVC,fiveVc];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height - 108;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *titleArr = @[@"足球", @"篮球", @"国内", @"国外",@"杂记"];
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44) delegate:self titleNames:titleArr];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.isIndicatorScroll = NO;
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeSpecial;
    _pageTitleView.selectedIndex = 0;
    _pageTitleView.isNeedBounces = NO;
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
