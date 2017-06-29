//
//  ZoushiDetail_Vc.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "ZoushiDetail_Vc.h"
#import "Zhonglei_zoushi_Cell.h"
@interface ZoushiDetail_Vc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *datasouce;
@end

@implementation ZoushiDetail_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadata];
    [self initData];
    [self initUI];
    [self addNavBarTitle:self.title_text];
    // Do any additional setup after loading the view.
}
-(void)initData{
    self.datasouce = [[NSMutableArray alloc]init];
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"Zhonglei_zoushi_Cell" bundle:nil] forCellReuseIdentifier:@"Zhonglei_zoushi_Cell"];
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self loadata];
        
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasouce.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Zhonglei_zoushi_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"Zhonglei_zoushi_Cell"];
    
    if (self.datasouce.count > 0) {
        Caipiao_Model *model = self.datasouce[indexPath.row];
        
        cell.model = model;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)loadata{
    NSDictionary *dic = @{@"code":self.style_url,@"endTime":[QDWTools getNowTime],@"count":@"10"};
    @weakify(self)
    [[NetManager shareManager]postNetWithStyle:Duoqi_Style Withdic:dic Success:^(NSDictionary *data) {
        @strongify(self)
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
