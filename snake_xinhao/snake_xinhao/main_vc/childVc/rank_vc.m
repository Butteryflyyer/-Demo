//
//  rank_vc.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "rank_vc.h"
#import "XHReachability.h"
@interface rank_vc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSMutableArray *source;
@property(nonatomic,strong)UITableView *TableView;
@end

@implementation rank_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self creatTableView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         [self loadData];
    });
   
    self.title = @"rank";
    @weakify(self)
    [XHReachability XHwithSuccessBlock:^(NSString *status) {
        @strongify(self)
        
        if ([status isEqual:@"无连接"]) {
            [SVProgressHUD showErrorWithStatus:@"no internet"];
        }
        if ([status isEqual:@"3G/4G网络"]||[status isEqual:@"wifi状态下"]) {
            
        }
    }];
    // Do any additional setup after loading the view.
}
-(void)initData{
    self.source = [[NSMutableArray alloc]init];

}

-(void)creatTableView{
    
    self.TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT ) style:UITableViewStylePlain];
    [self.TableView setSeparatorColor:_COLOR_RGB(0xd4d4d4)];
    self.TableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    
    self.TableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.TableView];
    
    self.TableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    
    [self.TableView registerNib:[UINib nibWithNibName:@"AllRewardCell" bundle:nil] forCellReuseIdentifier:@"AllRewardCell"];
    
    
    
    if ([self.TableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.TableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.TableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.TableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.source.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rank"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"rank"];
    }
    if (self.source.count > 0) {
        cell.textLabel.text = self.source[indexPath.row][@"name"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ score",self.source[indexPath.row][@"score"]];
    }

    if (indexPath.row == 0) {
          cell.imageView.image = IMG(@"排行榜1");
    }
    if (indexPath.row == 1) {
          cell.imageView.image = IMG(@"排行榜2");
    }
    if (indexPath.row == 2) {
          cell.imageView.image = IMG(@"排行榜3");
    }
    
    
    return cell;
    
    
}
-(void)loadData{
    [SVProgressHUD showWithStatus:@"waiting"];
//    //查找GameScore表
//    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"login"];
//    //查找GameScore表里面id为0c6db13c的数据
//    [bquery getObjectInBackgroundWithId:@"5891c76a14" block:^(BmobObject *object,NSError *error){
//        if (error){
//            [SVProgressHUD dismiss];
//            //进行错误处理
//        }else{
//            [SVProgressHUD dismiss];
//            //表里有id为0c6db13c的数据
//            if (object) {
//                NSLog(@"%@",object);
//               self.source =  [object objectForKey:@"rank_list"];
//                [self.TableView reloadData];
//            }
//        }
//    }];
    [LoginUserModel GetReleaseBillTopTenWithurl:QDWGetReleaseBillTopTen_URL Withuserid:[UserModel user].userid SuccessBlock:^(id data) {
        if (data) {
            
        }
    } Failure:^(id data) {
        
    }];

    sleep(2);
    self.source = [[NSMutableArray alloc]initWithArray:@[@{@"score":@"150",@"name":@"tony"},@{@"score":@"120",@"name":@"boo"},@{@"score":@"110",@"name":@"borr"},@{@"score":@"105",@"name":@"tony"},@{@"score":@"104",@"name":@"too"},@{@"score":@"103",@"name":@"tow"},@{@"score":@"102",@"name":@"myself"},@{@"score":@"100",@"name":@"honi"}]];
    [SVProgressHUD dismiss];
    
    dispatch_async(dispatch_get_main_queue(), ^{
          [self.TableView reloadData];
    });
  
    
    
   
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
