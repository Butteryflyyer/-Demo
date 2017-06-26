//
//  QDWSettingViewController.m
//  QianDaoWeiApp
//
//  Created by 融联 on 16/4/26.
//  Copyright © 2016年 信昊. All rights reserved.
//


#import "QDWSettingViewController.h"
#import "QDWCapitalAccountCell.h"

@interface QDWSettingViewController () <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *exitBtn;
@end

static NSString *ID = @"QDWCapitalAccountCell";
static NSString *SwitchID = @"QDWSwitchCell";

@implementation QDWSettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self creatTableView];
    //    self.tabBarController.tabBar.hidden=YES;
}

- (void)setupNav {
    
    [self addNavBarTitle: @"设置"];
   
}

- (void)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    // 设置每一行cell的高度
    self.tableView.rowHeight = QDWRealValue(46);
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    self.tableView.separatorColor = _COLOR_RGB(0xf1f1f1);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerClass:[QDWCapitalAccountCell class] forCellReuseIdentifier:ID];
    [self.tableView registerNib:[UINib nibWithNibName:SwitchID bundle:nil] forCellReuseIdentifier:SwitchID];
    [self.view addSubview:self.tableView];
}

#pragma mark - DataSoure
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
         return 4;
    }
    
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLOG(@"testcell");
    
    if (indexPath.section == 0) {
    
        QDWSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:SwitchID];
        
        cell.titleLabel.text = @"是否接收消息";
        
        return cell;
        
        
    }else{
        // 访问缓存池
        QDWCapitalAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        // 设置数据
        if (0 == indexPath.row) //第0行
        {
            cell.titleLabel.text = @"登录密码";
            
        } else if (1 == indexPath.row) // 第1行
        {
            cell.titleLabel.text = @"支付密码";
            
        } else if (2 == indexPath.row) // 第2行
        {
            cell.titleLabel.text = @"意见反馈";
            
        } else if (3 == indexPath.row) // 第3行
        {
            cell.titleLabel.text = @"关于我们";
        }
               
        
        
        return cell;
        
    }
    

}


#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        
    }else{
        
        if (0 == indexPath.row) // 第0行
        {

            
        } else if (1 == indexPath.row)//第1行
        {
            
    
        }
        else if (2 == indexPath.row) // 第2行
        {

            
        } else if (3 == indexPath.row) // 第3行
        {

            
        }
    }
    
    
  }


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        return 100;
    }else{
        return 10;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, QDWRealValue(100), SCREEN_WIDTH, QDWRealValue(100))];
        [self.view addSubview:footView];
        
        UIButton *exitBtn = [[UIButton alloc] init];
        [exitBtn setTitle:@"退出" forState:UIControlStateNormal];
        [exitBtn setTitleColor:_COLOR_RGB(0xffffff) forState:UIControlStateNormal];
        exitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        exitBtn.titleLabel.font = FontSystem(QDWRealValue(15));
        [exitBtn setBackgroundImage:IMG(FormatMidCicle_btn_ImageName) forState:UIControlStateNormal];
        exitBtn.layer.masksToBounds = YES;
        exitBtn.layer.cornerRadius = 5.0;
        [exitBtn addTarget:self action:@selector(exitClick) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:exitBtn];
        self.exitBtn = exitBtn;
        
        [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footView).offset(QDWRealValue(50));
            make.centerX.mas_equalTo(footView.mas_centerX);
            make.width.equalTo(@QDWRealValue(245));
            make.height.equalTo(@QDWRealValue(40));
        }];
        
        return footView;
 
    }else{
        
        return [[UIView alloc]init];
    }
  }

//点击按钮，程序退出
- (void)exitClick
{
    
    [SVProgressHUD showSuccessWithStatus:@"退出成功"];
    
    
    [[QDWLoginManager shareManager] UsrExitLogin];//用户退出登录

    [self.tabBarController setSelectedIndex:0];
    
   
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
#pragma mark -- 分割线左右顶头
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,15,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,15,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,15,0,0)];
    }
    
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,15,0,0)];
    }
}


@end
