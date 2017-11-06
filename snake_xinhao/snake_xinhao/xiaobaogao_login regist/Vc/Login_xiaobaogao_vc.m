//
//  Login_xiaobaogao_vc.m
//  xiaoxinyong
//
//  Created by 信昊 on 2017/9/12.
//  Copyright © 2017年 xiaoxinyong. All rights reserved.
//

#import "Login_xiaobaogao_vc.h"
#import "phone_view.h"
#import "password_view.h"
#import "forget_pass_view.h"
#import "Color_btn.h"
#import "borderColor_btn.h"
#import "UIControl+recurClick.h"
#import "Regist_xiaobaogao_vc.h"
#import "XBGUserLoginRegistHelper.h"
//#import "ForgetPsdOneViewController.h"
#import "Login_regist_bottom.h"
#import "Main_ViewController.h"
@interface Login_xiaobaogao_vc ()

@property(nonatomic,strong)phone_view *phoneview;//手机号
@property(nonatomic,strong)password_view *passview;//密码
@property(nonatomic,strong)forget_pass_view *forget_view;//忘记密码

@property(nonatomic,strong)Color_btn *login_btn;
@property(nonatomic,strong)borderColor_btn *go_regist_btn;

@property(nonatomic,strong)Login_regist_bottom *bottom_view;//最下面的协议

@end

@implementation Login_xiaobaogao_vc

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self blockUI];

    self.navigationItem.title = @"Login";

    
    // Do any additional setup after loading the view.
}
#pragma mark -- UI
-(void)initUI{
    self.view.backgroundColor = _COLOR_RGB(0xffffff);
    _phoneview = [[[NSBundle mainBundle]loadNibNamed:@"phone_view" owner:self options:nil]firstObject];
    _passview = [[[NSBundle mainBundle]loadNibNamed:@"password_view" owner:self options:nil]firstObject];
    _passview.password_textfield.placeholder = @"please enter password";
    [self.view addSubview:_passview];
    [self.view addSubview:_phoneview];

    _forget_view = [[[NSBundle mainBundle]loadNibNamed:@"forget_pass_view" owner:self options:nil]firstObject];
    
    _login_btn = [[Color_btn alloc]init];
    [_login_btn setTitle:@"login" forState:UIControlStateNormal];
    _login_btn.uxy_acceptEventInterval = 5;
    _go_regist_btn = [[borderColor_btn alloc]init];
    [_go_regist_btn setTitle:@"go regist" forState:UIControlStateNormal];
    [self.view addSubview:_forget_view];
    [self.view addSubview:_login_btn];
    [self.view addSubview:_go_regist_btn];
    
//    _bottom_view = [[[NSBundle mainBundle]loadNibNamed:@"Login_regist_bottom" owner:self options:nil]firstObject];
//    [self.view addSubview:_bottom_view];
    
    [_phoneview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(Real(80));
        make.left.mas_equalTo(self.view.mas_left).offset(Real(32.5));
        make.right.mas_equalTo(self.view.mas_right).offset(Real(-32.5));
        make.height.mas_equalTo(@Real(58.5));
    }];
    [_passview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneview.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).offset(Real(32.5));
        make.right.mas_equalTo(self.view.mas_right).offset(Real(-32.5));
        make.height.mas_equalTo(@Real(58.5));
    }];
    
    [_forget_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passview.mas_bottom).offset(10);
        make.right.mas_equalTo(self.passview.mas_right);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    [_login_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.forget_view.mas_bottom).offset(Real(28));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(235);
        make.height.mas_equalTo(43);
    }];
    [_go_regist_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.login_btn.mas_bottom).offset(Real(20));
        make.width.height.mas_equalTo(self.login_btn);
        make.centerX.mas_equalTo(self.login_btn.mas_centerX);
    }];
//    [_bottom_view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-24);
//        make.width.mas_equalTo(233);
//        make.height.mas_equalTo(40);
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//    }];

    
    
}

#pragma mark -- blockUI
-(void)blockUI{
    @weakify(self)
//    [[_forget_view.forget_pass_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//        @strongify(self)
//
//    }];
    [[_login_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self login];
        });
       
    }];
    [[_go_regist_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       @strongify(self)

        Regist_xiaobaogao_vc *vc = [[Regist_xiaobaogao_vc alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
//    [[_bottom_view.regist_info_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//       @strongify(self)
//        XXYWebViewController *vc = [[XXYWebViewController alloc] init];
//        vc.urlString = @"https://cms.xiaoxinyong.com/index.php?m=content&c=index&a=show&catid=7&id=5";
//        //    vc.title = @"说明";
//        [self.navigationController pushViewController:vc animated:YES];
//    }];
//    [[_bottom_view.sina_payinfo_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//       @strongify(self)
//        XXYWebViewController *vc = [[XXYWebViewController alloc] init];
//        vc.urlString = @"https://cms.xiaoxinyong.com/index.php?m=content&c=index&a=show&catid=7&id=6";
//        //    vc.title = @"说明";
//        [self.navigationController pushViewController:vc animated:YES];
//    }];
}
#pragma mark -- data
-(void)login{
    NSString *phone =@"";
    NSString *password =@"";
    phone = _phoneview.phone_textfield.text;
     password = _passview.password_textfield.text;
   

    NSString *bmobid = @"";
//    if ([phone isEqual:@"18518989539"]&&[password isEqual:@"s123456"]) {
//        bmobid = @"25728";
//    }
    if (![Tools checkTelNumber:phone]) {
        [SVProgressHUD showErrorWithStatus:@"please enter sure account and password"];
        return;
    }
    if ([password length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"please enter sure account and password"];
        return;
    }
    [SVProgressHUD showWithStatus:@"waiting"];

    //查找GameScore表
//    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"login"];
//    //查找GameScore表里面id为0c6db13c的数据
//    [bquery getObjectInBackgroundWithId:bmobid block:^(BmobObject *object,NSError *error){
//        if (error){
//            [SVProgressHUD dismiss];
//            //进行错误处理
//        }else{
//            [SVProgressHUD dismiss];
//            //表里有id为0c6db13c的数据
//            if (object) {
//                [UserModel user].userid = @"5891c76a14";
//                Main_ViewController *main = [[Main_ViewController alloc]init];
//
//                [self.navigationController pushViewController:main animated:YES];
//            }
//        }
//    }];
    [SVProgressHUD showWithStatus:@"waiting"];

    [LoginUserModel LoginQDWWithUrl:QDWLogin_URL AndDic:@{@"phone":phone,@"password":password} BlockSuccess:^(id data) {
        [SVProgressHUD dismiss];
        if (data) {
            [UserModel user].userid = @"25728";
            [SVProgressHUD showSuccessWithStatus:@"login success"];
            dispatch_async(dispatch_get_main_queue(), ^{
                Main_ViewController *main = [[Main_ViewController alloc]init];
                [UserModel user].userid = @"25728";
                [self.navigationController pushViewController:main animated:YES];
            });

        }else{
            [SVProgressHUD showErrorWithStatus:@"error"];
        }
    } WithBlockFail:^(id data) {
          [SVProgressHUD dismiss];
    }];
//    sleep(3);

    
}


#pragma mark - other
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

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
