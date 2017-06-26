//
//  ForgetSecretViewController.m
//  钱到位
//
//  Created by 信昊 on 16/4/14.
//  Copyright © 2016年 zhongyingshengke. All rights reserved.
//

#import "ForgetSecretViewController.h"
#import "QDWUser.h"
@interface ForgetSecretViewController ()
{
    
    NSString *VerifyStr; //验证码 从网上获取到的验证码
}
/**
 *  手机号
 */
@property (weak, nonatomic) IBOutlet UITextField *TelephoneNumberText;

/**
 *  验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *VerifyText;
/**
 *  验证码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *GetVerifyTextBtn;
/**
 *  密码
 */

@property (weak, nonatomic) IBOutlet UITextField *SecretNumberText;
/**
 *  是否可以看到密码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *IfCanSeeSecretNumer;

/**
 *  提交按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *ChangSecretNumberBtn;

@end

@implementation ForgetSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
    // Do any additional setup after loading the view from its nib.
}
-(void)initSubViews{
    [self addNavBarTitle:@"修改登录密码"];
    
    self.SecretNumberText.keyboardType = UIKeyboardTypeASCIICapable;
    
    //绑定textfield
    @weakify(self);
    
    [self.TelephoneNumberText.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        NSString *text = (NSString *)x;
        if ([QDWTools validateMobile:text]) {
            [self IfChangSecretBtnCanClick];
            
            self.GetVerifyTextBtn.userInteractionEnabled = YES;
        }else{
            
            self.GetVerifyTextBtn.userInteractionEnabled = NO;
            
            self.ChangSecretNumberBtn.enabled = NO;
        }
        
        
    }];
    
    [self.VerifyText.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        NSString *text = (NSString *)x;
        if (text.length == 4) {
            [self IfChangSecretBtnCanClick];
            
        }else{
            self.ChangSecretNumberBtn.enabled = NO;
        }
        
        
    }];
    
    [self.SecretNumberText.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        NSString *text = (NSString *)x;
        if (text.length >0) {
            [self IfChangSecretBtnCanClick];
            
        }else{
            self.ChangSecretNumberBtn.enabled = NO;
        }
        
    }];
    
    
}
/**
 *  条件封装 是否可以点击
 */
-(void)IfChangSecretBtnCanClick{
    
    if ([QDWTools validateMobile:self.TelephoneNumberText.text] && self.SecretNumberText.text.length >0 && [self.VerifyText.text isEqual:VerifyStr] ) {
        
        self.ChangSecretNumberBtn.enabled = YES;
        
        
    }else{
        self.ChangSecretNumberBtn.enabled = NO;
        
    }
    
    
}

/**
 *  是否可以看到明文密码
 *
 *  @param sender
 */
- (IBAction)IfCanSeeSecretNumberAction:(id)sender {
    
    self.IfCanSeeSecretNumer.selected = !self.IfCanSeeSecretNumer.selected;
    if (self.IfCanSeeSecretNumer.selected) {
        
        self.SecretNumberText.secureTextEntry = YES;
        
    }else{
        
        self.SecretNumberText.secureTextEntry = NO;
    }
    
    
}

/**
 *  获取验证码点击
 *
 *  @param sender
 */
- (IBAction)GetVerifyTextBtnAction:(id)sender {
    
    if ([QDWTools validateMobile:self.TelephoneNumberText.text]) {
        
        [self startTime];
        
        NSDictionary *dic = @{@"phone":self.TelephoneNumberText.text};
        
        [QDWUser SendSMSWithURL:QDWsendSms_URL WithDic:dic AndBlockSendSMS:^(id data) {
            
            if (data) {
                VerifyStr = (NSString *)data;
            }
            
            
            
        } andFailure:^(id data) {
            
            
        }];
        
    }
    
    
}
/**
 *  提交
 *
 *  @param sender
 */
- (IBAction)ChangSecretNumberAction:(id)sender {
    
    if (self.SecretNumberText.text.length <6 || self.SecretNumberText.text.length > 18 ) {
        [QDWTools ShowTishiAlertControllerWithTitle:@"提示" AndDetial:@"请输入6-18位密码" WithView:self];
        
    }else if (![QDWTools validatePassword:self.SecretNumberText.text]){
        
        [QDWTools ShowTishiAlertControllerWithTitle:@"提示" AndDetial:@"请输入正确的密码由字母数字和.#%-*@_符号组成" WithView:self];
    }else{
        if ([VerifyStr isEqual:self.VerifyText.text]) {
            NSDictionary *dic = @{@"phone":self.TelephoneNumberText.text,@"password":self.SecretNumberText.text};
            
            [QDWUser RechargePassWordWith:QDWRechargePassword_URL WithDic:dic AndBlockSuccess:^(id data) {
                
                if (data) {
                    
                    NSUSER_SAVE(self.TelephoneNumberText.text,QDWSaveNameAcount); //存账号
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            } andfailure:^(id data) {
                
                
                
            }];
            
            
            
        }else{
            
            
            [SVProgressHUD showErrorWithStatus:@"请输入正确验证码"];
        }
        
    }
    
    
    
}
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
                [self.GetVerifyTextBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.GetVerifyTextBtn setTitleColor:_COLOR_RGB(0x0095fe) forState:UIControlStateNormal];
                
                self.GetVerifyTextBtn.userInteractionEnabled = YES;
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
                [self.GetVerifyTextBtn setTitle:[NSString stringWithFormat:@"重新获取(%@秒)",strTime] forState:UIControlStateNormal];
                [self.GetVerifyTextBtn setTitleColor:_COLOR_RGB(0xc8c8c8) forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.GetVerifyTextBtn.userInteractionEnabled = NO;
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
