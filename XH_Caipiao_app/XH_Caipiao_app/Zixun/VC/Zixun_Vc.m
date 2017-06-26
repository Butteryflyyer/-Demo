
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
@interface Zixun_Vc ()<CycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)CycleScrollView *Cycle_View;

@property(nonatomic,strong)MenuView *HomeMenuView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,retain)NSArray *dataSource;
@end

@implementation Zixun_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self addNavBarTitle:@"资讯"];
    [self initUI];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [WSReachability WSwithSuccessBlock:^(NSString *status) {
            
            
            if ([status isEqual:@"无连接"]) {
                [QDWTools ShowTishiAlertControllerWithTitle:@"温馨提示" AndDetial:@"当前没有网络" WithView:self];
                
            }else if ([status isEqual:@"3G/4G网络"]){
                
                
            }else if ([status isEqual:@"wifi状态下"]){
            };
            
        }];
        
        
    });

    // Do any additional setup after loading the view.
}
-(void)initUI{
    self.Cycle_View = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    NSArray *ary = @[@"彩票banner2",@"彩票banner3",@"彩票banner5"];
    self.Cycle_View.imgArray = ary;
    [self.view addSubview:self.Cycle_View];
     self.Cycle_View.delegate = self;

    self.HomeMenuView = [[MenuView alloc]initWithFrame:CGRectMake(0, MaxY(self.Cycle_View), SCREEN_WIDTH, 100)];
    
    [self.view addSubview:self.HomeMenuView];
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

        
    }];
    [[self.HomeMenuView.ServeView.SelectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)

        
        
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MaxY(self.HomeMenuView), SCREEN_WIDTH, SCREEN_HEIGHT - MaxY(self.HomeMenuView)-49) style:UITableViewStylePlain];
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    //    self.QDWTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    
    [self.tableView setSeparatorColor:_COLOR_RGB(0xf1f1f1)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"Shouye_Cell" bundle:nil] forCellReuseIdentifier:@"Shouye_Cell"];
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Shouye_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Shouye_Cell"];
    if (self.dataSource.count > 0) {
        Caipiao_Model *model = self.dataSource[indexPath.row];
        
        cell.model =model;
    }

    return cell;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    header.backgroundColor = _COLOR_RGB(0xf5f5f5);
    UILabel *label = [QDWTools initLabelWithText:@"双色球" WithTextColor:[UIColor blackColor] Withfont:17 WithFrame:CGRectMake(20, 10, 60, 30) WithTextAlit:NSTextAlignmentCenter];
    
    [header addSubview:label];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (void)clickImgAtIndex:(NSInteger)index{
    Zixun_Web *web = [[Zixun_Web alloc]init];
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:NO];
    
}
-(void)loadData{
    
    NSDictionary *dic = @{@"code":@"ssq",@"endTime":[QDWTools getNowTime],@"count":@"10"};
    @weakify(self)
    [[NetManager shareManager] postNetWithStyle:Duoqi_Style Withdic:dic Success:^(NSDictionary *data) {
      @strongify(self)
        if ([[NSString stringWithFormat:@"%@",data[@"showapi_res_code"]] isEqual:@"0"]) {
            NSDictionary *result_dic = data[@"showapi_res_body"];
            self.dataSource = [Caipiao_Model mj_objectArrayWithKeyValuesArray:result_dic[@"result"]];
            
            [self.tableView reloadData];
        }else{
            
        }
        
    }];
    
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
