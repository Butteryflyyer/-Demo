//
//  Kaijiang_Vc.m
//  Caipiao_app
//
//  Created by 信昊 on 17/6/23.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Kaijiang_Vc.h"
#import "kaijiang_Cell.h"
#import "ZoushiDetail_Vc.h"
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
    self.Code = @"sh11x5";
    self.icon_image = @"image0";

  
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
        [self loadData];
}



//sh11x5   bjkl8
-(void)initData{
    self.datasouce = [[NSMutableArray alloc]init];
    
    self.Image_arr = @[@"image0",@"image9",@"image2",@"image3"];
    self.Url_arr = @[@"sh11x5",@"shssl",@"xjssc",@"fjtc31x7"];
    self.Title_arr = @[@"11选5",@"时时乐",@"时时彩",@"体彩"];
//    self.description_arr = @[@"每天81期，08:41起每10分钟一期",@"每天179期，09:05起每5分钟一期",@"每天84期，09:30起每10分钟一期",@"每周一、三、五、日的20:00开奖",@"每天72期，09:44起每10分钟一期",@"每天84期，09:10起每10分钟一期",@"每天84期，09:35起每10分钟一期",@"每天97期，00:05起每10、10分钟一期",@"每天73期，09:45起每10分钟一期",@"每天23期，10:30起每30分钟一期"];
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
    
    [self.tableView.mj_header beginRefreshing];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasouce.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    kaijiang_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"kaijiang_Cell"];
    
    
    if (self.datasouce.count > 0) {
    
        Caipiao_Model *model = self.datasouce[indexPath.row];
        cell.model = model;
        cell.icon_image.image = IMG(self.icon_image);
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZoushiDetail_Vc *vc = [[ZoushiDetail_Vc alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.title_text = self.Title_arr[indexPath.section];
    vc.style_url = self.Url_arr[indexPath.section];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(void)loadData{
        @weakify(self)
        [[NetManager shareManager]postNetWithStyle:ZuiXin_Style Withdic:@{@"code":self.Code} Success:^(NSDictionary *data) {
            
            @strongify(self)
            
            [self.datasouce removeAllObjects];
            
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
