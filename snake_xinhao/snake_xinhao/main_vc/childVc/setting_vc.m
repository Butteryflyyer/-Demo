//
//  setting_vc.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/29.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "setting_vc.h"

@interface setting_vc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *TableView;
@end

@implementation setting_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"setting";
    [self creatTableView];
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
    
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting-cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"setting-cell"];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"exit";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [Tools ShowTishiAlertControllerWithTitle:@"prompt" AndDetial:@"do you want to exit?" WithView:self WithCancelTitle:@"cancel" WithMakeSureTitle:@"make sure" CancelActionBlock:^(id data) {
        
    } MakSureActionBlock:^(id data) {
        [UserModel user].userid = nil;
        [self.navigationController popToRootViewControllerAnimated:YES];
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
