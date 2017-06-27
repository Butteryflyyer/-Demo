

//
//  Xinwen_Vc.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/27.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Xinwen_Vc.h"
#import "Xinwen_Cell.h"
#import "Zixun_Web.h"
@interface Xinwen_Vc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,retain)NSArray *datasouce;
@property(nonatomic,retain)NSArray *imgUrl_Arr;
@property(nonatomic,retain)NSArray *title_Arr;
@property(nonatomic,retain)NSArray *web_url;
@property(nonatomic,retain)NSArray *time_arr;

@end

@implementation Xinwen_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadata];
    [self initData];
    [self initUI];
    [self addNavBarTitle:@"新闻资讯"];

    // Do any additional setup after loading the view.
}
-(void)initData{
     self.title_Arr = @[@"历史上的今天",@"买彩票的烦恼",@"竞猜单场固定奖",@"5亿一等奖",@"内蒙古体彩",@"大乐透再次井喷"];
     self.imgUrl_Arr = @[@"双色球",@"职业病",@"竞猜网",@"5亿",@"中国体彩",@"大乐透"];
    self.datasouce = @[@"双色球第2017074期历史数据汇编",@"对于广大网名来说，买彩票可能变为职业病哦。",@"世界杯年中国体育彩票精彩不断，经财政部批准，自2014年10月21日起，竞彩游戏返奖率整体提高至73%，同时竞彩足球胜平负、让球胜平负、半全场胜平负、总进球游戏和竞彩篮球胜负、让分胜负、大小分游戏取消单场浮动奖",@"中国福利彩票双色球5亿元派奖活动即将开始",@"内蒙古体彩拓展新渠道 包头体彩走进23家超市",@"大乐透再次井喷10注头奖 奖池金仍达1.02亿高位"];
    self.web_url = @[@"http://news.50018.com/n/Pm0PlE.html",
                     @"http://news.50018.com/n/qqE6Mu.html",
                     @"http://news.50018.com/n/kOq02z.html",
                     @"http://news.50018.com/n/ILf13V.html",
                     @"http://news.50018.com/n/yq1lud.html",
                     @"http://news.50018.com/n/flTm8W.html"];
    self.time_arr = @[@"2017-6-27",@"2017-6-26",@"2017-6-26",@"2017-6-26",@"2017-6-25",@"2017.6-25"];
    
}
-(void)initUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT ) style:UITableViewStylePlain];
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //    self.QDWTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    
    [self.tableView setSeparatorColor:_COLOR_RGB(0xf1f1f1)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"Xinwen_Cell" bundle:nil] forCellReuseIdentifier:@"Xinwen_Cell"];
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self loadata];
        
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Xinwen_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"Xinwen_Cell"];
    
    cell.time_label.text = self.time_arr[indexPath.section];
    cell.icon_Image.image = IMG(self.imgUrl_Arr[indexPath.section]);
    cell.Detai_label.text = self.datasouce[indexPath.section];
    cell.title_label.text = self.title_Arr[indexPath.section];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Zixun_Web *vc = [[Zixun_Web alloc]init];
    vc.url = self.web_url[indexPath.section];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)loadata{
    NSDictionary *dic = @{@"code":@"ssq",@"endTime":[QDWTools getNowTime],@"count":@"10"};
    @weakify(self)
    [[NetManager shareManager]postNetWithStyle:Duoqi_Style Withdic:dic Success:^(NSDictionary *data) {
        @strongify(self)
        [ self.tableView.mj_header endRefreshing];
        
        if ([[NSString stringWithFormat:@"%@",data[@"showapi_res_code"]] isEqual:@"0"]) {
            NSDictionary *result_dic = data[@"showapi_res_body"];

            
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
