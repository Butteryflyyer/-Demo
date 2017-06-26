//
//  Mine_Vc.m
//  Caipiao_app
//
//  Created by 信昊 on 17/6/23.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Mine_Vc.h"
#import "JSHeaderView.h"
#import "MineNormal_Cell.h"
@interface Mine_Vc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) JSHeaderView *headerView;

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation Mine_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBarTitle:@"我的"];
     [self initUI];
    self.headerView = [[JSHeaderView alloc] initWithImage:[UIImage imageNamed:@"个人中心头像默认"]];

    
    [self.headerView reloadSizeWithScrollView:self.tableView];
    self.navigationItem.titleView = self.headerView;
    
    [self.headerView handleClickActionWithBlock:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您点击了头像" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }];

   
    
    
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MineNormal_Cell" bundle:nil] forCellReuseIdentifier:@"MineNormal_Cell"];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineNormal_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"MineNormal_Cell"];
    
    cell.NowRow = indexPath.row;
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    header.backgroundColor = _COLOR_RGB(0xf5f5f5);
    UILabel *label = [QDWTools initLabelWithText:@"" WithTextColor:[UIColor blackColor] Withfont:17 WithFrame:CGRectMake(20, 10, 60, 30) WithTextAlit:NSTextAlignmentCenter];
    label.centerX = header.centerX;
    label.text = [QDWUser shareManager].UserTelephone;
    [header addSubview:label];
    return header;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
