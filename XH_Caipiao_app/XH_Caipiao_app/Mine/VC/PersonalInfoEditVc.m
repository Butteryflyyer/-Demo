//
//  PersonalInfoEditVc.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "PersonalInfoEditVc.h"
#import "PersonalEditVM.h"

@interface PersonalInfoEditVc ()

@property(nonatomic,strong)PersonalEditVM *EditVM;

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PersonalInfoEditVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBarTitle:@"编辑个人信息"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
   
    self.tableView.separatorColor = _COLOR_RGB(0xf1f1f1);
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.EditVM.myController = self;
    [self.view addSubview:self.tableView];

    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(PersonalEditVM *)EditVM{
    if (!_EditVM) {
        _EditVM = [[PersonalEditVM alloc]initWithTable:self.tableView];
        _EditVM.userInfo = self.UserInfo;
    }
    return _EditVM;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
