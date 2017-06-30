


//
//  Kaijiang_Base_Vc.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/28.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Kaijiang_Base_Vc.h"
#import "kaijiangChildfirst_Vc.h"
#import "kaijiangChildThird_Vc.h"
#import "kaijiangChildSecond_Vc.h"
#import "Kaijiang_Vc.h"
#import "Fujing_Vc.h"
@interface Kaijiang_Base_Vc () <SGPageTitleViewDelegate, SGPageContentViewDelegare>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@end

@implementation Kaijiang_Base_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageView];
    [self addNavBarTitle:@"开奖"];
    UIBarButtonItem *SearchBtn = [QDWTools initBarButtonItemWithText:@"附近的彩票站" Withfont:15 WithTextColor:_COLOR_RGB(0xffffff) WithBackColor:nil WithImg:nil WithBackImage:nil WithFrame:CGRectMake(0, 0, 100, 20) WithTarget:self WithAction:@selector(SearchAction)];
    UIBarButtonItem *fixspace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[SearchBtn,fixspace];
    
    
    
   

    // Do any additional setup after loading the view.
}
-(void)SearchAction{
    Fujing_Vc *vc = [[Fujing_Vc alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)setupPageView {
    Kaijiang_Vc *oneVC = [[Kaijiang_Vc alloc] init];
    
    kaijiangChildfirst_Vc *twoVC = [[kaijiangChildfirst_Vc alloc] init];
    kaijiangChildSecond_Vc *threeVC = [[kaijiangChildSecond_Vc alloc] init];
    kaijiangChildThird_Vc *fourVC = [[kaijiangChildThird_Vc alloc] init];
    
    oneVC.now_title = @"11选5";
    twoVC.now_title = @"时时乐";
    threeVC.now_title = @"时时彩";
    fourVC.now_title = @"体彩";
    
    
    
    NSArray *childArr = @[oneVC, twoVC, threeVC, fourVC];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height - 108;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *titleArr = @[@"11选5", @"时时乐", @"时时彩", @"体彩"];
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
