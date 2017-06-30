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
#import "QDWSettingViewController.h"
#import "ViewController.h"
#import "PersonalInfoEditVc.h"
#import <SDWebImage/UIImage+MultiFormat.h>
#import <SDWebImage/SDWebImageManager.h>
#import "ScanViewController.h"
#import "QDWInviteFriendsViewController.h"
@interface Mine_Vc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) JSHeaderView *headerView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)QDWUserPersonalInfo *userInfo;
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
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您点击了头像" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
    }];

    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadUserInfoWithjump:0];
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
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    header.backgroundColor = _COLOR_RGB(0xf5f5f5);
    UILabel *label = [QDWTools initLabelWithText:@"" WithTextColor:[UIColor blackColor] Withfont:17 WithFrame:CGRectMake(20, 10, 100, 30) WithTextAlit:NSTextAlignmentCenter];
    label.centerY = 100/2;
    label.centerX = SCREEN_WIDTH/2;
    label.centerX = header.centerX;
    label.text = [QDWUser shareManager].Username ;
    [header addSubview:label];
    return header;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ViewController *vc = [[ViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        
        [self loadUserInfoWithjump:1];
    }
    if (indexPath.row ==2) {
        ScanViewController *vc = [[ScanViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 3) {
        QDWInviteFriendsViewController *vc = [[QDWInviteFriendsViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 4) {
        QDWSettingViewController *vc = [[QDWSettingViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:vc animated:YES];  
    }
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)loadUserInfoWithjump:(NSInteger)jump {
    [SVProgressHUD showWithStatus:@"加载中"];
    @weakify(self)
    [MinePageManager getMySelfInfoWithSuccessBlock:^(id data) {
        [SVProgressHUD dismiss];
        @strongify(self)
        if (data) {
            
            self.userInfo = [QDWUserPersonalInfo mj_objectWithKeyValues:data];
           
            if (jump == 1) {
                PersonalInfoEditVc *vc = [[PersonalInfoEditVc alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.UserInfo = self.userInfo;
                
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
               [ manager downloadImageWithURL:[NSURL URLWithString:self.userInfo.userInfo.avatarpath] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                            self.headerView.image = image;
                    });
                    
                }];
  
            }
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
