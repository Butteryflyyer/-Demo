//
//  Registacount_Vc.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/6/15.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "Registacount_Vc.h"
#import "Login_normal_Cell.h"
#import "yanzhengma_Cell.h"
#import "Regist_View.h"
#import "NSString+Chinese.h"

static NSString *const Yanzhengma_Cell_Id = @"yanzhengma_Cell";
static NSString *const Login_normal_Cell_Id = @"Login_normal_Cell";
@interface Registacount_Vc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIImageView *Logo_Image;//logo
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *Regist_btn;//完成
@property(nonatomic,strong)UIButton *GetVerifyBtn;//获取验证码

@property(nonatomic,copy)NSString *Name_Real;//姓名
@property(nonatomic,copy)NSString *Tele_Phone;//手机
@property(nonatomic,copy)NSString *Yan_zhengma;//验证码
@property(nonatomic,copy)NSString *pass_word;//密码

@property(nonatomic,copy)NSString *Yan_zhengma_getFromInternet;

@end

@implementation Registacount_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBarTitle:@"注册"];
    [self initUI];
    [self initData];
    [self rac_Complete];
    // Do any additional setup after loading the view.
}
-(void)initData{
    self.Name_Real = @"";
    self.Tele_Phone = @"";
    self.Yan_zhengma = @"";
    self.pass_word = @"";
}
-(void)initUI{
    [self.view addSubview:self.scrollView];
    
    self.Logo_Image = [[UIImageView alloc]initWithImage:IMG(@"个人中心头像默认")];
    self.Logo_Image.frame = CGRectMake(0, QDWRealValue(79), QDWRealValue(75), QDWRealValue(75));
    self.Logo_Image.centerX = SCREEN_WIDTH/2;
    [self.scrollView addSubview:self.Logo_Image];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, MaxY(self.Logo_Image)+QDWRealValue(34), SCREEN_WIDTH-30, QDWRealValue(49*4)) style:UITableViewStylePlain];
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    self.tableView.separatorColor = _COLOR_RGB(0xf5f5f5);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.scrollView addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:Yanzhengma_Cell_Id bundle:nil] forCellReuseIdentifier:Yanzhengma_Cell_Id];
    [self.tableView registerNib:[UINib nibWithNibName:Login_normal_Cell_Id bundle:nil] forCellReuseIdentifier:Login_normal_Cell_Id];
    
    self.Regist_btn = [QDWTools initBtnWithName:@"完成" Withfont:17 WithImag:IMG(FormatMidCicle_btn_ImageName) WithTextColor:_COLOR_RGB(0xffffff) WithBackColor:nil WithCornerRadius:0 WithFrame:CGRectMake(0, MaxY(self.tableView)+QDWRealValue(172), 245, QDWRealValue(40))];
    self.Regist_btn.centerX = SCREEN_WIDTH/2;
    [self.scrollView addSubview:self.Regist_btn];
    
    Regist_View *regist = [[[NSBundle mainBundle]loadNibNamed:@"Regist_View" owner:self options:nil]firstObject];
    regist.frame = CGRectMake(0, MaxY(self.Regist_btn)+QDWRealValue(43), 200, 25);
    regist.centerX = SCREEN_WIDTH/2-QDWRealValue(10);
    [regist.Regist_btn setTitle:@"直接登录" forState:UIControlStateNormal];
    regist.Title_Detail_Label.text = @"已有账号?";
    [self.scrollView addSubview:regist];
    @weakify(self)
   [[regist.Regist_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       @strongify(self) //直接登录
       [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
   }];
    [[self.Regist_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self) //注册完成
        [self regist];
    }];
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Login_normal_Cell *normal_cell = [tableView dequeueReusableCellWithIdentifier:Login_normal_Cell_Id];
    yanzhengma_Cell *yanzhen_cell = [tableView dequeueReusableCellWithIdentifier:Yanzhengma_Cell_Id];
    normal_cell.Regist_Index_Path = indexPath;
    @weakify(self)
    if (indexPath.row == 2) {
        self.GetVerifyBtn = yanzhen_cell.Yanzheng_btn;
        [[yanzhen_cell.Yanzheng_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self)
            if ([QDWTools validateMobile:self.Tele_Phone]) {
                [self startTime];
                [QDWUser SendSMSWithURL:QDWsendSms_URL WithDic:@{@"phone":self.Tele_Phone} AndBlockSendSMS:^(id data) {
                    if (data) {
                        self.Yan_zhengma_getFromInternet = data;
                    }
                } andFailure:^(id data) {
                }];
            }else{
                [[ShowMessageView shareManager]showMessage:@"请输入正确手机号"];
            }

        }];
        [yanzhen_cell.title_detaile_textField.rac_textSignal subscribeNext:^(id x) {
            @strongify(self)
            self.Yan_zhengma = (NSString *)x;
        }];
        return yanzhen_cell;
    }
    [normal_cell.title_Detail_textfield.rac_textSignal subscribeNext:^(id x) {
       @strongify(self)
        if (indexPath.row == 0) {
            self.Name_Real = (NSString *)x;
        }
        if (indexPath.row == 1) {
            self.Tele_Phone = (NSString *)x;
        }
        if (indexPath.row == 3) {
            self.pass_word = (NSString *)x;
        }
    }];

    
    return normal_cell;
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
#pragma mark -- 完成按钮
-(void)rac_Complete{
    RACSignal *enableComplete_Siginal = [RACSignal combineLatest:@[RACObserve(self, Name_Real),RACObserve(self, Tele_Phone),RACObserve(self, pass_word),RACObserve(self, Yan_zhengma)] reduce:^id(NSString *name,NSString *phone,NSString *password,NSString *yanzhenma){
        
        return @([name includeChinese] > 0 && [QDWTools validateMobile:phone] && yanzhenma == self.Yan_zhengma_getFromInternet && [QDWTools validatePassword:password]);
        
    }];
   RAC(self.Regist_btn,enabled) = enableComplete_Siginal;
    
}

#pragma mark -- 注册接口
-(void)regist{
    NSDictionary *dic = @{@"telephone":self.Tele_Phone,@"name":self.Name_Real,@"password":self.pass_word, @"terminal":@"3"};
    
    [QDWUser MobileRegiseterWithDic:dic Success:^(id data) {
        if (data) {
            NSUSER_SAVE(self.Tele_Phone,QDWSaveNameAcount);
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } andfailure:^(id data) {}];
}

#pragma mark -- 获取验证码

/**
 *  获取验证码倒计时
 */
-(void)startTime{
    __block NSInteger timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.GetVerifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.GetVerifyBtn setTitleColor:_COLOR_RGB(0x999999) forState:UIControlStateNormal];
                self.GetVerifyBtn.enabled = YES;
                self.GetVerifyBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            //            [SingleJiuYou sharedManager].timeForgetSecret = [strTime integerValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5];
                [self.GetVerifyBtn setTitle:[NSString stringWithFormat:@"重新获取(%@秒)",strTime] forState:UIControlStateNormal];
                [self.GetVerifyBtn setTitleColor:_COLOR_RGB(0x999999) forState:UIControlStateNormal];
                self.GetVerifyBtn.enabled = NO;
                [UIView commitAnimations];
                self.GetVerifyBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
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
