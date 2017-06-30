//
//  XinwenChild_first.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/28.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "XinwenChild_first.h"
#import "XinwenSub_Cell.h"
#import "Xinwen_Model.h"
#import "Zixun_Web.h"
@interface XinwenChild_first ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *datasource;
@end

@implementation XinwenChild_first

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
   
    self.category = @"足球";
 
     [self loadData];
    // Do any additional setup after loading the view.
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XinwenSub_Cell" bundle:nil] forCellReuseIdentifier:@"XinwenSub_Cell"];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XinwenSub_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"XinwenSub_Cell"];
    
    if (self.datasource.count>0) {
        Xinwen_Model *model = self.datasource[indexPath.section];
        cell.Title_Label.text = model.title;
        cell.Detail_label.text = model.desc;
        cell.time_label.text = model.pubDate;
    }

    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     Xinwen_Model *model = self.datasource[indexPath.row];
    Zixun_Web *vc = [[Zixun_Web alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.url = model.link;
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.transform = CGAffineTransformMakeTranslation(self.view.bounds.size.width, 0);
    [UIView animateWithDuration:1.0 delay:0.05*indexPath.section usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        cell.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        
    }];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(void)loadData{
    @weakify(self)
    [[NetManager shareManager]postNetWithStyle:Xinwen_Style Withdic:@{@"channelId":@"",@"channelName":@"",@"title":self.category,@"page":@"1",@"needContent":@"0",@"needHtml":@"0",@"needAllList":@"0",@"maxResult":@"20"} Success:^(NSDictionary *data) {
         @strongify(self)
           self.datasource = [[NSMutableArray alloc]init];
       
                if ([[NSString stringWithFormat:@"%@",data[@"showapi_res_code"]] isEqual:@"0"]) {
                    NSDictionary *result_dic = data[@"showapi_res_body"];
                    NSDictionary *result = result_dic[@"pagebean"];
                    self.datasource = [Xinwen_Model mj_objectArrayWithKeyValuesArray:result[@"contentlist"]];
        
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
