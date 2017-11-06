//
//  Regist_xiaobaogao_vc.m
//  xiaoxinyong
//
//  Created by 信昊 on 2017/9/12.
//  Copyright © 2017年 xiaoxinyong. All rights reserved.
//

#import "Regist_xiaobaogao_vc.h"
#import "phone_view.h"
#import "password_view.h"
#import "yanzhen_view.h"
#import "Color_btn.h"
#import "borderColor_btn.h"


#import "yanzhengBottom_view.h"
#import "yanzhengShowtime_view.h"
#import "Login_xiaobaogao_vc.h"

#import "XBGUserLoginRegistHelper.h"
#import "Login_regist_bottom.h"
#import "Invite_person_view.h"
@interface Regist_xiaobaogao_vc (){

    BOOL _Duanxin_yuyin_show;  //是在等待语音验证还是在等短信  YES 短信   NO 语音
    BOOL _ShowInvite_person;   //是否有邀请人
}
@property(nonatomic,strong)phone_view *phoneview;//手机号
@property(nonatomic,strong)password_view *passview;//密码
@property(nonatomic,strong)yanzhen_view *yanzhenview;//验证码
@property(nonatomic,strong)borderColor_btn *login_btn; //快速注册
@property(nonatomic,strong)Color_btn *go_regist_btn;//已有账号
@property(nonatomic,strong)Invite_person_view *invite_view;//邀请人

@property(nonatomic,strong)yanzhengBottom_view *yanzheng_yuyin_view;//点击语音
@property(nonatomic,strong)yanzhengShowtime_view *yanzheng_time_view;//显示时间

@property(nonatomic,strong)Login_regist_bottom *bottom_view;//最下面的协议

@end

@implementation Regist_xiaobaogao_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];

    [self initUI];
    [self blockUI];
    self.navigationItem.title = @"Regist";
  
    // Do any additional setup after loading the view.
}

#pragma mark -- viewwillappear
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

#pragma mark -- initdata
-(void)initData{
    _Duanxin_yuyin_show = YES;
}
#pragma mark -- UI
-(void)initUI{
    self.view.backgroundColor = _COLOR_RGB(0xffffff);
    _phoneview = [[[NSBundle mainBundle]loadNibNamed:@"phone_view" owner:self options:nil]firstObject];
    _passview = [[[NSBundle mainBundle]loadNibNamed:@"password_view" owner:self options:nil]firstObject];
    _yanzhenview = [[[NSBundle mainBundle]loadNibNamed:@"yanzhen_view" owner:self options:nil]firstObject];
    _invite_view = [[[NSBundle mainBundle]loadNibNamed:@"Invite_person_view" owner:self options:nil]firstObject];
    [self.view addSubview:_passview];
    [self.view addSubview:_phoneview];
    [self.view addSubview:_yanzhenview];
    [self.view addSubview:_invite_view];
    
        _yanzhenview.yanzhenma_textfield.text = @"111111";
    
    _go_regist_btn = [[Color_btn alloc]init];
    [_go_regist_btn setTitle:@"quick regist" forState:UIControlStateNormal];
    _login_btn = [[borderColor_btn alloc]init];
    [_login_btn setTitle:@"alreay account" forState:UIControlStateNormal];

    [self.view addSubview:_login_btn];
    [self.view addSubview:_go_regist_btn];
    
    
    _yanzheng_yuyin_view = [[[NSBundle mainBundle]loadNibNamed:@"yanzhengBottom_view" owner:self options:nil]firstObject];
    _yanzheng_time_view = [[[NSBundle mainBundle]loadNibNamed:@"yanzhengShowtime_view" owner:self options:nil]firstObject];
    [self.view addSubview:_yanzheng_time_view];
    [self.view addSubview:_yanzheng_yuyin_view];
    
    
    
    _bottom_view = [[[NSBundle mainBundle]loadNibNamed:@"Login_regist_bottom" owner:self options:nil]firstObject];
    [self.view addSubview:_bottom_view];
    self.bottom_view.hidden = YES;
    [_phoneview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(Real(80));
        make.left.mas_equalTo(self.view.mas_left).offset(Real(32.5));
        make.right.mas_equalTo(self.view.mas_right).offset(Real(-32.5));
        make.height.mas_equalTo(@Real(58.5));
    }];
    [_yanzhenview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneview.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).offset(Real(32.5));
        make.right.mas_equalTo(self.view.mas_right).offset(Real(-32.5));
        make.height.mas_equalTo(@Real(58.5));
    }];
    [_passview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yanzhenview.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).offset(Real(32.5));
        make.right.mas_equalTo(self.view.mas_right).offset(Real(-32.5));
        make.height.mas_equalTo(@Real(58.5));
    }];
    [_go_regist_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passview.mas_bottom).offset(Real(47));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(235);
        make.height.mas_equalTo(43);
    }];
    [_login_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.go_regist_btn.mas_bottom).offset(Real(20));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(235);
        make.height.mas_equalTo(43);
    }];
    
    
    [_yanzheng_yuyin_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yanzhenview.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@170);
        make.height.mas_equalTo(@Real(25));
        
    }];
    [_yanzheng_time_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yanzhenview.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.mas_equalTo(self.view.mas_left).offset(Real(32.5));
        make.right.mas_equalTo(self.view.mas_right).offset(Real(-32.5));
        make.height.mas_equalTo(@Real(25));
        
    }];
    self.yanzheng_time_view.hidden = YES;
    self.yanzheng_yuyin_view.hidden = YES;
    [_bottom_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-24);
        make.width.mas_equalTo(233);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [_invite_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passview.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).offset(Real(32.5));
        make.right.mas_equalTo(self.view.mas_right).offset(Real(-32.5));
        make.height.mas_equalTo(@Real(58.5));
    }];
    self.invite_view.hidden = YES;
}
//显示时间
-(void)Showyanzheng_time{
    self.yanzheng_time_view.hidden = NO;
    self.yanzheng_yuyin_view.hidden = YES;
}
//显示语音
-(void)showyanzheng_yuyin{
    self.yanzheng_time_view.hidden = YES;
    self.yanzheng_yuyin_view.hidden = NO;
}
//刷新位置
-(void)ChangePassword_positionWithoffset:(CGFloat)offset{
    [_passview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yanzhenview.mas_bottom).offset(offset);
        make.left.mas_equalTo(self.view.mas_left).offset(Real(32.5));
        make.right.mas_equalTo(self.view.mas_right).offset(Real(-32.5));
        make.height.mas_equalTo(@Real(58.5));
    }];

    [self.view layoutIfNeeded];
}
//邀请人 位置显示
-(void)ChangInvite_position{
    self.invite_view.hidden = NO;
    [_go_regist_btn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passview.mas_bottom).offset(Real(47+Real(58.5)));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(235);
        make.height.mas_equalTo(43);
    }];
    [self.view layoutIfNeeded];
}

-(void)blockUI{
    //验证码
    @weakify(self)
    [[_yanzhenview.yanzhen_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        [self duanxin_yanzheng];
    }];
    //语音验证
    [[_yanzheng_yuyin_view.yuyin_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        [self yuyin_yanzheng];
    }];
    //登录
    [[_login_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)

        Login_xiaobaogao_vc *vc = [[Login_xiaobaogao_vc alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    }];
    //注册
    [[_go_regist_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        [self regist];
    }];

}
#pragma mark -- 数据传输
-(void)get_yaoqingma{

}
-(void)yuyin_yanzheng{
    NSString *phone = self.phoneview.phone_textfield.text;

}
-(void)duanxin_yanzheng{

    NSString *phone = self.phoneview.phone_textfield.text;
    if (![Tools checkTelNumber:phone]) {
        [SVProgressHUD showErrorWithStatus:@"please enter really phone"];
    }
}
-(void)regist{
    NSString *phone = self.phoneview.phone_textfield.text;
    NSString *vertity = self.yanzhenview.yanzhenma_textfield.text;
    NSString *password = self.passview.password_textfield.text;
    NSString *invitePhone = self.invite_view.Invite_phone_textfield.text;
    if (![Tools checkTelNumber:phone]) {
        [SVProgressHUD showErrorWithStatus:@"please enter really phone"];
        return;
    }
    if (password.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"please enter format password"];
        return ;
    }
   NSDictionary *dic = @{@"telephone":phone,@"name":@"hao",@"password":password};
    [LoginUserModel MobileRegiseterWithDic:dic Success:^(id data) {
        if (data) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } andfailure:^(id data) {
        
    }];
 
}
- (void)showPasscodeSettingView {

}
- (void)postLoginInNotification {

}

#pragma mark -- 时间计时器
-(void)startTime{
    __block NSInteger timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                _Duanxin_yuyin_show = NO;
                [self showyanzheng_yuyin];
                self.yanzhenview.yanzhen_btn.enabled = YES;
                [self.yanzhenview.yanzhen_btn setTitle:@"重发验证码" forState:UIControlStateNormal];
                
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            //            [SingleJiuYou sharedManager].timeForgetSecret = [strTime integerValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_Duanxin_yuyin_show) {//点击短信
                    self.yanzhenview.yanzhen_btn.enabled = NO;
                    [self.yanzhenview.yanzhen_btn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                    [self Showyanzheng_time];
                    [self ChangePassword_positionWithoffset:25];
                    self.yanzheng_time_view.yanzhen_time_label.text = [NSString stringWithFormat:@"收不到短信?(%@秒)后尝试语音验证码",strTime];
                }
                if (_Duanxin_yuyin_show == NO) {//点击语音
                    self.yanzhenview.yanzhen_btn.enabled = NO;
                    [self Showyanzheng_time];
                    self.yanzheng_time_view.yanzhen_time_label.text = [NSString stringWithFormat:@"请注意接听电话:(%@秒)后重试",strTime];
                }
                
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
