//
//  Zoushi_Vc.m
//  Caipiao_app
//
//  Created by 信昊 on 17/6/23.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Zoushi_Vc.h"
#import "Zhonglei_Cell.h"
#import "ZoushiDetail_Vc.h"
@interface Zoushi_Vc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,retain)NSArray *Image_arr;
@property(nonatomic,retain)NSArray *Url_arr;
@property(nonatomic,retain)NSArray *Title_arr;
@property(nonatomic,retain)NSMutableArray *datasouce;



@end

@implementation Zoushi_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBarTitle:@"彩票种类"];
//    [self loadata];
    [self initData];
    [self initUI];

    // Do any additional setup after loading the view.
}
//sh11x5   bjkl8
-(void)initData{
    self.datasouce = [[NSMutableArray alloc]init];
    
    self.Image_arr = @[@"image0",@"image1",@"image2",@"image3",@"image4",@"image5",@"image6",@"image7",@"image11",@"image9"];
    self.Url_arr = @[@"sh11x5",@"bjkl8",@"xjssc",@"fjtc31x7",@"thffc5",@"hunxysc",@"cqklsf",@"shssl",@"hebk3",@"shssl"];
    self.Title_arr = @[@"11选5",@"快乐8",@"时时彩",@"体彩",@"时时彩",@"幸运赛车",@"快乐十分",@"幸运农场",@"快三",@"时时乐"];
    
}
-(void)initUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT - 10) style:UITableViewStylePlain];
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //    self.QDWTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    
    [self.tableView setSeparatorColor:_COLOR_RGB(0xf1f1f1)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"Zhonglei_Cell" bundle:nil] forCellReuseIdentifier:@"Zhonglei_Cell"];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Zhonglei_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"Zhonglei_Cell"];
    
    cell.Title.text = self.Title_arr[indexPath.section];
    cell.IconView.image = IMG(self.Image_arr[indexPath.section]);

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
    return 50;
}
//-(void)loadata{
//    NSDictionary *dic = @{@"code":@"hubk3",@"endTime":@"2017-5-09 21:21:40",@"count":@"10"};
//    @weakify(self)
//    [[NetManager shareManager]postNetWithStyle:Duoqi_Style Withdic:dic Success:^(NSDictionary *data) {
//        @strongify(self)
//        if ([[NSString stringWithFormat:@"%@",data[@"showapi_res_code"]] isEqual:@"0"]) {
//            NSDictionary *result_dic = data[@"showapi_res_body"];
//            self.datasouce = [Caipiao_Model mj_objectArrayWithKeyValuesArray:result_dic[@"result"]];
//            
//            [self.tableView reloadData];
//        }else{
//            
//        }
//
//        
//    }];
//    
//}
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
