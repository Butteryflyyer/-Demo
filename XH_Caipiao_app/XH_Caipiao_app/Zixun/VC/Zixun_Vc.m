
//
//  Zixun_Vc.m
//  Caipiao_app
//
//  Created by 信昊 on 17/6/23.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Zixun_Vc.h"
#import "CycleScrollView.h"
#import "Zixun_Web.h"
#import "MenuView.h"
#import "WSReachability.h"
#import "Shouye_Cell.h"
#import "Zhuanpan_Vc.h"
#import "HomeBottom_View.h"
#import "ZoushiDetail_Vc.h"
#import "ADRollView.h"
#import "ADRollModel.h"
#import "UIColor+ColorHelper.h"
#import "Xinwen_base_Vc.h"


@interface Zixun_Vc ()<CycleScrollViewDelegate>

@property(nonatomic,strong)CycleScrollView *Cycle_View;

@property(nonatomic,strong)MenuView *HomeMenuView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,retain)NSArray *dataSource;

@property (nonatomic, strong) ADRollView *adRollView;
@property (nonatomic, strong) NSMutableArray *adsArray;

@property(nonatomic,strong)UIScrollView *BackScrollView;



@property (nonatomic, strong) NSMutableArray *danmuDataSources;
@end

@implementation Zixun_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self addNavBarTitle:@"资讯"];
    [self.view addSubview:self.BackScrollView];
    [self initUI];
    [self buildUI];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [WSReachability WSwithSuccessBlock:^(NSString *status) {
            
            
            if ([status isEqual:@"无连接"]) {
                [QDWTools ShowTishiAlertControllerWithTitle:@"温馨提示" AndDetial:@"当前没有网络" WithView:self];
                
            }else if ([status isEqual:@"3G/4G网络"]){
                
                
            }else if ([status isEqual:@"wifi状态下"]){
            };
            
        }];
        
        
    });
    
    [[DanmuManager shareManager]ShowDanmuWithView:self.view];
    
       // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.adRollView start];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
      self.navigationController.navigationBar.hidden = NO;
    [self.adRollView stopTimer];
    
}
- (void)buildUI {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, MaxY(self.Cycle_View)+5, SCREEN_WIDTH, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5;
    [self.BackScrollView addSubview:bgView];
    
    //公告image
    UIImageView *adImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AD"]];
    [bgView addSubview:adImage];
    [adImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY);
        make.left.equalTo(bgView.mas_left).offset(7);
    }];
    
    //分割线
    CALayer *line = [CALayer layer];
    line.backgroundColor = [UIColor colorWithHexString:@"ececec" alpha:1.0].CGColor;
    line.frame = CGRectMake(47, 5, 1, 30);
    [bgView.layer addSublayer:line];
    
    //ADRollView
    self.adRollView = [[ADRollView alloc] initWithFrame:CGRectMake(48, 0, SCREEN_WIDTH-30-48, 40)];
    [self.adRollView setVerticalShowDataArr:[self getData]];
    NSLog(@"%@",[self getData]);
    
    //点击公告内容
    __weak __typeof(self)weakSelf = self;
    self.adRollView.clickBlock = ^(NSInteger index) {
        ADRollModel *model = weakSelf.adsArray[index];
    };
    
    [bgView addSubview:self.adRollView];
    
      [self.adRollView start];
}
- (NSMutableArray *)getData {
    
     self.adsArray = [NSMutableArray array];
    NSArray *adTypeArray = @[@"福利", @"公告", @"通告"];
    NSArray *titleArray = @[@"下版app将会加入更多福利功能", @"彩票1.0上线，请大家继续支持", @"彩票详情了解，看我就够了。"];
    NSArray *timeArray = @[@"2017-6-28", @"2017-06-28", @"2017-06-28"];
    NSArray *urlArray = @[@"http://www.cocoachina.com/programmer/20170315/18892.html", @"http://www.cocoachina.com/ios/20170315/18890.html", @"http://www.cocoachina.com/design/20170315/18884.html"];
    
    for (int i = 0; i < adTypeArray.count; i++) {
        ADRollModel *model = [[ADRollModel alloc] init];
        model.noticeType = adTypeArray[i];
        model.noticeTitle = titleArray[i];
        model.addTime = timeArray[i];
        model.urlString = urlArray[i];
        [self.adsArray addObject:model];
    }
    
    return self.adsArray;
}

-(void)initUI{
    self.Cycle_View = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, QDWRealValue(300))];
    NSArray *ary = @[@"彩票banner1",@"彩票banner2",@"彩票banner3"];
    self.Cycle_View.imgArray = ary;
    [self.BackScrollView addSubview:self.Cycle_View];
     self.Cycle_View.delegate = self;

    self.HomeMenuView = [[MenuView alloc]initWithFrame:CGRectMake(0, MaxY(self.Cycle_View)+50, SCREEN_WIDTH, 100)];
    
    [self.BackScrollView addSubview:self.HomeMenuView];
    @weakify(self)
    [[self.HomeMenuView.FindOrderView.SelectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        if ([QDWUser shareManager].Userid.length > 0) {
            Zhuanpan_Vc *vc = [[Zhuanpan_Vc alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self pushIntoLoginVc];
        }
    }];
    [[self.HomeMenuView.FireOrderView.SelectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
         [self.tabBarController setSelectedIndex:1];
        
    }];
    [[self.HomeMenuView.ActivityView.SelectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        Xinwen_base_Vc *vc = [[Xinwen_base_Vc alloc]init];

        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    [[self.HomeMenuView.ServeView.SelectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)

        [QDWTools ShowTishiAlertControllerWithTitle:@"温馨提示" AndDetial:@"当前模块正在建设中，敬请期待" WithView:self];
        
    }];
    
    HomeBottom_View *home_View = [[[NSBundle mainBundle]loadNibNamed:@"HomeBottom_View" owner:self options:nil]firstObject];
    home_View.frame = CGRectMake(0, MaxY(self.HomeMenuView)+10, SCREEN_WIDTH, 230);
    
    [self.BackScrollView addSubview:home_View];
    
    NSArray *url_arr = @[@"sh11x5",@"pl3",@"xjssc",@"fjtc31x7",@"thffc5",@"hunxysc",@"cqklsf",@"shssl",@"hebk3",@"shssl"];
   NSArray *title_arr = @[@"11选5",@"排列3",@"时时彩",@"体彩",@"时时彩",@"幸运赛车",@"快乐十分",@"幸运农场",@"快三",@"时时乐"];

    
    [[home_View.firstbtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
      @strongify(self)
        [self goWithtitle:title_arr[0] withurl:url_arr[0]];
    }];
    [[home_View.secondbtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
          [self goWithtitle:title_arr[1] withurl:url_arr[1]];
    }];
    [[home_View.thirdbtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
          [self goWithtitle:title_arr[2] withurl:url_arr[2]];
    }];
    [[home_View.fourbtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
          [self goWithtitle:title_arr[3] withurl:url_arr[3]];
    }];
    [[home_View.fivebtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
          [self goWithtitle:title_arr[4] withurl:url_arr[4]];
    }];
    [[home_View.sixbtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
          [self goWithtitle:title_arr[5] withurl:url_arr[5]];
    }];
    [[home_View.sevenbtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
          [self goWithtitle:title_arr[6] withurl:url_arr[6]];
    }];
    [[home_View.eightbtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
          [self goWithtitle:title_arr[7] withurl:url_arr[7]];
    }];
    [[home_View.ninebtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
          [self goWithtitle:title_arr[8] withurl:url_arr[8]];
    }];
    
 }
-(void)goWithtitle:(NSString *)title withurl:(NSString *)url{
    ZoushiDetail_Vc *vc = [[ZoushiDetail_Vc alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.title_text = title;
    vc.style_url =  url;
    
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)clickImgAtIndex:(NSInteger)index{
    Zixun_Web *web = [[Zixun_Web alloc]init];
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:NO];
    
}

-(UIScrollView *)BackScrollView{
    if (!_BackScrollView) {
        _BackScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _BackScrollView.backgroundColor = _COLOR_RGB(0xf5f5f5);
        if (SCREEN_HEIGHT < IPHONE6) {
            _BackScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT *1.2);
        }else{
            _BackScrollView.contentSize = CGSizeMake(0, 1.1 *SCREEN_HEIGHT);
        }
        
    }
    return _BackScrollView;
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
