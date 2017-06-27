//
//  Kaijiang_Vc.m
//  Caipiao_app
//
//  Created by 信昊 on 17/6/23.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Kaijiang_Vc.h"
#import "kaijiang_Cell.h"
#import "Fujing_Vc.h"
@interface Kaijiang_Vc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,retain)NSArray *Image_arr;
@property(nonatomic,retain)NSArray *Url_arr;
@property(nonatomic,retain)NSArray *Title_arr;
@property(nonatomic,retain)NSArray *description_arr;
@property(nonatomic,retain)NSMutableArray *datasouce;
@end

@implementation Kaijiang_Vc
/*
 071800 生活服务;彩票彩券销售点;彩票彩券销售点
 071801 生活服务;彩票彩券销售点;马会投注站
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBarTitle:@"开奖"];
    //    [self loadata];
    [self initData];
    [self initUI];
    [self loadData];
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


//sh11x5   bjkl8
-(void)initData{
    self.datasouce = [[NSMutableArray alloc]init];
    
    self.Image_arr = @[@"image0",@"image12",@"image2",@"image3",@"image4",@"image5",@"image6",@"image7",@"image11",@"image9"];
    self.Url_arr = @[@"sh11x5",@"pl3",@"xjssc",@"fjtc31x7",@"thffc5",@"hunxysc",@"cqklsf",@"shssl",@"hebk3",@"shssl"];
    self.Title_arr = @[@"11选5",@"排列三",@"时时彩",@"体彩",@"时时彩",@"幸运赛车",@"快乐十分",@"幸运农场",@"快三",@"时时乐"];
    self.description_arr = @[@"每天81期，08:41起每10分钟一期",@"每天179期，09:05起每5分钟一期",@"每天84期，09:30起每10分钟一期",@"每周一、三、五、日的20:00开奖",@"每天72期，09:44起每10分钟一期",@"每天84期，09:10起每10分钟一期",@"每天84期，09:35起每10分钟一期",@"每天97期，00:05起每10、10分钟一期",@"每天73期，09:45起每10分钟一期",@"每天23期，10:30起每30分钟一期"];
}
-(void)initUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 10) style:UITableViewStylePlain];
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //    self.QDWTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    
    [self.tableView setSeparatorColor:_COLOR_RGB(0xf1f1f1)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"kaijiang_Cell" bundle:nil] forCellReuseIdentifier:@"kaijiang_Cell"];
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self loadData];
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    kaijiang_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"kaijiang_Cell"];
    
    if (self.datasouce.count > 0) {
        
        cell.name_label.text = self.Title_arr[indexPath.row];
        cell.icon_image.image = IMG(self.Image_arr[indexPath.row]);
        Caipiao_Model *model = self.datasouce[indexPath.row];
        
        cell.model = model;
        
    }
    
    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ZoushiDetail_Vc *vc = [[ZoushiDetail_Vc alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    
//    vc.title_text = self.Title_arr[indexPath.section];
//    vc.style_url = self.Url_arr[indexPath.section];
//    
//    [self.navigationController pushViewController:vc animated:YES];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

-(void)loadData{
        @weakify(self)
        [[NetManager shareManager]postNetWithStyle:Duoqi_Style Withdic:@{@"code":@"pl3",@"endTime":[QDWTools getNowTime],@"count":@"10"} Success:^(NSDictionary *data) {
            
            @strongify(self)
            [self.tableView.mj_header endRefreshing];
            [ self.tableView.mj_header endRefreshing];
            
            if ([[NSString stringWithFormat:@"%@",data[@"showapi_res_code"]] isEqual:@"0"]) {
                NSDictionary *result_dic = data[@"showapi_res_body"];
                self.datasouce = [Caipiao_Model mj_objectArrayWithKeyValuesArray:result_dic[@"result"]];
                
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
