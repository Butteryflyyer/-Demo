//
//  Main_ViewController.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/27.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "Main_ViewController.h"
#import "main_view.h"
#import "rank_vc.h"
#import "XHReachability.h"
#import "AFNetworking.h"
#import "Personal_vc.h"
#import "FeedBack_vc.h"
#import "setting_vc.h"
#import "Score_vc.h"
#import "aboutus_vc.h"
#import "SnakeNodeViewController.h"
@interface Main_ViewController ()
@property(nonatomic,strong)UIImageView *home_imageview;
@property(nonatomic,strong)main_view *mainview;
@end

@implementation Main_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主菜单";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    @weakify(self)
    [XHReachability XHwithSuccessBlock:^(NSString *status) {
        @strongify(self)
        
        if ([status isEqual:@"无连接"]) {
            [Tools ShowTishiAlertControllerIKnowCanDoSomeThingWithTitle:@"" AndDetial:@"no internet" WithView:self WithBlock:^(id data) {
                
            }];
        }
        if ([status isEqual:@"3G/4G网络"]||[status isEqual:@"wifi状态下"]) {

        }
    }];
    
}
-(void)initUI{
    self.home_imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH)];
    self.home_imageview.transform =  CGAffineTransformRotate(self.home_imageview.transform, M_PI/2);//旋转180;
    //    self.home_imageview.layer.anchorPoint = CGPointMake(0, 0);
    self.home_imageview.image = IMG(@"home_back");
    self.home_imageview.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    [self.view addSubview:self.home_imageview];
    
    
    self.mainview = [[[NSBundle mainBundle]loadNibNamed:@"main_view" owner:self options:nil]firstObject];
   [self.view addSubview:self.mainview];
    
    [self.mainview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SCREEN_WIDTH-20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
         make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    @weakify(self)
    [[self.mainview.playgame rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {@strongify(self)
        SnakeNodeViewController *vc = [[SnakeNodeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    [[self.mainview.sendinfo rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {@strongify(self)
        FeedBack_vc *vc = [[FeedBack_vc alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [[self.mainview.shezhi rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {@strongify(self)
        setting_vc *vc = [[setting_vc alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [[self.mainview.more rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {@strongify(self)
        aboutus_vc *vc = [[aboutus_vc alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [[self.mainview.rank rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {@strongify(self)
        rank_vc *vc = [[rank_vc alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [[self.mainview.myinfo rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {@strongify(self)
        Personal_vc *vc = [[Personal_vc alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    [[self.mainview.guanyuwomen rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        Score_vc *vc = [[Score_vc alloc]init];
              [self.navigationController pushViewController:vc animated:YES];
    }];
    
    UILabel *version = [[UILabel alloc]init];
    version.text = @"version 1.0";
    version.textAlignment = NSTextAlignmentCenter;
    version.font = FontBold(20);
    [self.view addSubview:version];
    [version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.view bringSubviewToFront:version];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

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
