//
//  Personal_vc.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "Personal_vc.h"
#import "info_cell.h"
@interface Personal_vc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSMutableArray *source;
@property(nonatomic,strong)UITableView *TableView;
@end

@implementation Personal_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    self.title =@"your info";
    @weakify(self)
    self.navigationItem.rightBarButtonItem = [self savebarItem:^{
        @strongify(self)
        [self loadData];
    }];
    // Do any additional setup after loading the view.
}
-(UIBarButtonItem *)savebarItem:(void(^)(void))back{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 23, 23);
    [btn  setTitle:@"save" forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        back();
    }];
    UIBarButtonItem *leftbarItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return leftbarItem;
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
    
    
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    info_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"info_cell"];
    cell.indexpath = indexPath;
    
    
    return cell;
    
    
}
-(void)loadData{
    [SVProgressHUD showWithStatus:@"saving"];
            BmobObject *gameScore = [BmobObject objectWithClassName:@"user"];
            [gameScore setObject:@"hello" forKey:@"name"];
            [gameScore setObject:@"world" forKey:@"age"];

            [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                //进行操作
                [SVProgressHUD showSuccessWithStatus:@"success"];
                [self.navigationController popViewControllerAnimated:YES];
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
