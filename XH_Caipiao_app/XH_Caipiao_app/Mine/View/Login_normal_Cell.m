//
//  Login_normal_Cell.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/6/15.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "Login_normal_Cell.h"

#import "NSString+Chinese.h"
@interface Login_normal_Cell ()

@property (weak, nonatomic) IBOutlet UILabel *title_label;

@property (weak, nonatomic) IBOutlet UIButton *Secret_Control_btn;


@end

@implementation Login_normal_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    

    @weakify(self)
    [[self.title_Detail_textfield rac_signalForControlEvents:UIControlEventEditingDidEnd]subscribeNext:^(id x) {
        @strongify(self)
        NSString *detail = self.title_Detail_textfield.text;
   
       if (self.Login_Index_Path) {
         if (self.Login_Index_Path.row == 0) {
                if (![QDWTools validateMobile:detail]) {
                    [[ShowMessageView shareManager]showMessage:@"正确的手机号"];
                }
            }
        if (self.Login_Index_Path.row == 1) {
                if (![QDWTools validatePassword:detail]) {
                    [[ShowMessageView shareManager]showMessage:@"请输入6-18位密码 由字母数字和.#%-*@_符号组成"];
                }
            }
       }
        if (self.Regist_Index_Path) {
            if (self.Regist_Index_Path.row == 0) {
                if (![detail includeChinese]) {
                    [[ShowMessageView shareManager]showMessage:@"请输入正确姓名"];
                }
            }
            if (self.Regist_Index_Path.row == 1) {
                if (![QDWTools validateMobile:detail]) {
                    [[ShowMessageView shareManager]showMessage:@"正确的手机号"];
                }
            }
            if (self.Regist_Index_Path.row == 3) {
                if (![QDWTools validatePassword:detail]) {
                    [[ShowMessageView shareManager]showMessage:@" 请输入6-18位密码 由字母数字和.#%-*@_符号组成"];
                }
            }
        }
        
        
    }];
    
    
    // Initialization code
}
//登录时候
-(void)setLogin_Index_Path:(NSIndexPath *)Login_Index_Path{
    _Login_Index_Path = Login_Index_Path;
    if (Login_Index_Path.row == 0) {
        self.title_label.text = @"账号";
        self.title_Detail_textfield.placeholder = @"请输入注册的手机号";
        self.title_Detail_textfield.keyboardType = UIKeyboardTypeNumberPad;
        self.Secret_Control_btn.hidden = YES;
    }else{
        self.title_label.text = @"密码";
        self.title_Detail_textfield.placeholder = @"请输入密码";
        self.title_Detail_textfield.keyboardType = UIKeyboardTypeASCIICapable;
        self.Secret_Control_btn.hidden = NO;
        self.title_Detail_textfield.secureTextEntry = YES;
        @weakify(self)
        [[self.Secret_Control_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
           @strongify(self)
            self.Secret_Control_btn.selected = !self.Secret_Control_btn.selected;
            if (self.Secret_Control_btn.selected == YES) {
                self.title_Detail_textfield.secureTextEntry = YES;
            }else{
                 self.title_Detail_textfield.secureTextEntry = NO;
            }
        }];
    }
}
//注册的时候
-(void)setRegist_Index_Path:(NSIndexPath *)Regist_Index_Path{
    _Regist_Index_Path = Regist_Index_Path;
    self.Secret_Control_btn.hidden = YES;
    if (Regist_Index_Path.row == 0) {
        self.title_label.text = @"姓名";
        self.title_Detail_textfield.placeholder = @"请输入注册的姓名";
        self.title_Detail_textfield.keyboardType = UIKeyboardTypeDefault;
    }else if (Regist_Index_Path.row == 1){
        self.title_label.text = @"手机";
        self.title_Detail_textfield.placeholder = @"请输入注册的手机号";
        self.title_Detail_textfield.keyboardType = UIKeyboardTypeNumberPad;
        
    }else if(Regist_Index_Path.row == 3){
        self.title_label.text = @"密码";
        self.title_Detail_textfield.placeholder = @"请输入密码";
        self.title_Detail_textfield.keyboardType = UIKeyboardTypeASCIICapable;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
