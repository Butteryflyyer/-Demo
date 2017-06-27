//
//  Login_Vc.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/6/15.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "Login_Vc.h"
#import "Login_normal_Cell.h"
#import "Regist_View.h"
#import "ForgetSecretViewController.h"
#import "LoginUserModel.h"
#import "Registacount_Vc.h"
static NSString *const CellId = @"Login_normal_Cell";
@interface Login_Vc ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView *Logo_Image;//logo
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *forget_password_Btn;//忘记密码
@property(nonatomic,strong)UIButton *Login_btn;//登录
@property(nonatomic,strong)UIButton *Regist_btn;//注册

@property(nonatomic,copy)NSString *Tele_phone;
@property(nonatomic,copy)NSString *password;

@property(nonatomic,strong)UITextField *tele_field;
@property(nonatomic,strong)UITextField *pass_field;

@end

@implementation Login_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBarTitle:@"登录"];
    [self initUI];
    [self rac_loginbtn];
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    if (NSUSER_OBJECTFORRKEY(QDWSaveNameAcount)) {
        self.Tele_phone = NSUSER_OBJECTFORRKEY(QDWSaveNameAcount);
    }
}
-(void)initData{
    self.Tele_phone = @"";
    self.password = @"";
}
-(void)initUI{
    [self.view addSubview:self.scrollView];
    
    self.Logo_Image = [[UIImageView alloc]initWithImage:IMG(@"个人中心头像默认")];
    self.Logo_Image.frame = CGRectMake(0, QDWRealValue(90), QDWRealValue(75), QDWRealValue(75));
    self.Logo_Image.centerX = SCREEN_WIDTH/2;
    [self.scrollView addSubview:self.Logo_Image];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, MaxY(self.Logo_Image)+QDWRealValue(55), SCREEN_WIDTH-30, QDWRealValue(49)*2) style:UITableViewStylePlain];
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    self.tableView.separatorColor = _COLOR_RGB(0xf5f5f5);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.scrollEnabled = NO;
    [self.scrollView addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:CellId bundle:nil] forCellReuseIdentifier:CellId];
    
    self.forget_password_Btn = [QDWTools initBtnWithName:@"忘记密码?" Withfont:15 WithImag:nil WithTextColor:_COLOR_RGB(0x47a2ff) WithBackColor:nil WithCornerRadius:0 WithFrame:CGRectMake(MaxX(self.tableView)-100, MaxY(self.tableView)+10, 100, QDWRealValue(20))];
    [self.scrollView addSubview:self.forget_password_Btn];
    @weakify(self)
    self.Login_btn = [QDWTools initBtnWithName:@"登录" Withfont:17 WithImag:IMG(FormatMidCicle_btn_ImageName) WithTextColor:_COLOR_RGB(0xffffff) WithBackColor:nil WithCornerRadius:0 WithFrame:CGRectMake(0, MaxY(self.tableView)+QDWRealValue(172), 245, QDWRealValue(40))];
    self.Login_btn.centerX = SCREEN_WIDTH/2;
    [self.scrollView addSubview:self.Login_btn];
    
    Regist_View *regist = [[[NSBundle mainBundle]loadNibNamed:@"Regist_View" owner:self options:nil]firstObject];
    regist.frame = CGRectMake(0, MaxY(self.Login_btn)+QDWRealValue(43), 200, 25);
    regist.centerX = SCREEN_WIDTH/2;
    [regist.Regist_btn setTitle:@"立即注册" forState:UIControlStateNormal];
    regist.Title_Detail_Label.text = @"您还没有账号?";
    [self.scrollView addSubview:regist];
    
    [[regist.Regist_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {//注册
        @strongify(self)
        Registacount_Vc *vc= [[Registacount_Vc alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [[self.forget_password_Btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {//忘记密码
        @strongify(self)
        ForgetSecretViewController *forget_vc = [[ForgetSecretViewController alloc]init];
        forget_vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:forget_vc animated:YES];
    }];
    [[self.Login_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {//登录
        @strongify(self)
        [self login];
        
    }];
    if (NSUSER_OBJECTFORRKEY(QDWSaveNameAcount)) {
        self.tele_field.text = NSUSER_OBJECTFORRKEY(QDWSaveNameAcount);
        self.pass_field.text = [SSKeychain passwordForService:KeyChain_Service account:self.tele_field.text];
        self.Tele_phone = self.tele_field.text;
        self.password = self.pass_field.text;
    }

}
#pragma mark -- delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Login_normal_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    cell.Login_Index_Path = indexPath;
    @weakify(self)
    [cell.title_Detail_textfield.rac_textSignal subscribeNext:^(id x) {
        @strongify(self)
        if (indexPath.row == 0) {
            self.Tele_phone = (NSString *)x;
            NSString *pass = [SSKeychain passwordForService:KeyChain_Service account:self.Tele_phone];
            if (pass.length>0) {
                self.pass_field.text = pass;
                self.password = pass;
            }

                   }else{
            self.password = (NSString *)x;
        }
    }];
    if (indexPath.row == 0) {
        self.tele_field = cell.title_Detail_textfield;
    }
    if (indexPath.row == 1) {
        self.pass_field = cell.title_Detail_textfield;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return QDWRealValue(49);
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        if (SCREEN_HEIGHT < IPHONE6) {
            _scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT *1.2);
        }else{
            _scrollView.contentSize = CGSizeMake(0, 0);
        }
    }
    return _scrollView;
}

#pragma mark -- 登录按钮 监听
-(void)rac_loginbtn{
    RACSignal *enableLogin_Signal = [RACSignal combineLatest:@[RACObserve(self, Tele_phone),RACObserve(self, password)]reduce:^id(NSString *telephone,NSString *pass_word){
        return @([QDWTools validateMobile:telephone] && [QDWTools validatePassword:pass_word]);
    }];
    RAC(self.Login_btn,enabled) = enableLogin_Signal;
}
#pragma mark -- 登录接口
-(void)login{
 
    NSDictionary* dic =  @{ @"phone" :self.Tele_phone,
                            @"password":self.password,
                            @"terminal":@"3"
                            };
    [SVProgressHUD showWithStatus:@"登录中"];
    @weakify(self);
    [LoginUserModel LoginQDWWithUrl:QDWLogin_URL AndDic:dic BlockSuccess:^(id data) {
        @strongify(self);
        DLOG(@"%@",data);
        if (data) {
            //key chain 存储
            if (![SSKeychain setPassword:self.password forService:KeyChain_Service account:self.Tele_phone]) {
                [SVProgressHUD showErrorWithStatus:@"存储失败"];
            }
            NSUSER_SAVE(self.Tele_phone,QDWSaveNameAcount); //存账号
            NSUserDefaults_Syn;
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            LoginUserModel *loginmodel = [LoginUserModel mj_objectWithKeyValues:(NSDictionary *)data];
            loginmodel.userCount = self.Tele_phone;
            loginmodel.userpassword = self.password;
            [QDWUser shareManager].Userid = loginmodel.id;
            if ([loginmodel.id length]>0) {
                //绑定友盟
                if (loginmodel.workcity.length != 0) {
                    //                        [UmengManager UmengaddAlisWithCity:loginmodel.workcity];
                    [self TellServiceMakePushWithCity:loginmodel.workcity];
                }else{
                    //                        [UmengManager UmengaddAlisWithCity:NSUSEROBJECTFORKEY(MyNowCity)];//绑定定位的城市
                    [self TellServiceMakePushWithCity:NSUSER_OBJECTFORRKEY(MyNowCity)];
                    
                }
#warning 归档
                BOOL Success = [NSKeyedArchiver archiveRootObject:loginmodel toFile:[QDWLoginManager shareManager].accountPath];
                if (Success) {
                }
                [self.navigationController popViewControllerAnimated:YES];
                
                [QDWLoginManager shareManager].UserAcount = loginmodel;
            }
        }
    } WithBlockFail:^(id data) {
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    }];
}
-(void)TellServiceMakePushWithCity:(NSString *)city{
    

}
#pragma mark -- 分割线左右顶头
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
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
