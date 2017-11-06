

//
//  Score_vc.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/29.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "Score_vc.h"

@interface Score_vc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *TableView;
@property(nonatomic,retain)NSMutableArray *source;
@end

@implementation Score_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"your score";
    self.source = [[NSMutableArray alloc]init];
    [self creatTableView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         [self loadData];
    });
   
    // Do any additional setup after loading the view.
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
    
    [self.TableView registerNib:[UINib nibWithNibName:@"info_cell" bundle:nil] forCellReuseIdentifier:@"info_cell"];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if (self.source.count>0) {
        cell.textLabel.text = @"yourself";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@score",self.source[indexPath.row][@"score"]];
    }
    
    return cell;
    
    
}

-(void)loadData{
    [SVProgressHUD showWithStatus:@"waiting"];
    //查找GameScore表
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
//                self.source =  [object objectForKey:@"score_list"];
//                [self.TableView reloadData];
//            }
//        }
//    }];

    sleep(2);
    self.source = [[NSMutableArray alloc]initWithArray:@[@{@"score":@"100",@"name":@"tony"},@{@"score":@"90",@"name":@"boo"},@{@"score":@"70",@"name":@"borr"},@{@"score":@"70",@"name":@"tony"},@{@"score":@"70",@"name":@"too"},@{@"score":@"60",@"name":@"tow"},@{@"score":@"59",@"name":@"myself"},@{@"score":@"48",@"name":@"honi"}]];
    [SVProgressHUD dismiss];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.TableView reloadData];
    });
    
    
    [LoginUserModel SignDateWithurl:QDWSignDate_URL WithUserid:[UserModel user].userid SuccessBlock:^(id data) {
        if (data) {
            
//            DLOG(@"%@", data[@"Integral"]);
//            SignInDateModel *model = [[SignInDateModel alloc]initWithDictionary:data error:nil];
            
        }
        
        
    } FailureBlock:^(id data) {
        
        
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
