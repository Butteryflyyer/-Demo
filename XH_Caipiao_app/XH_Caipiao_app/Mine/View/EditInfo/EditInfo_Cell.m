//
//  EditInfo_Cell.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "EditInfo_Cell.h"

@interface EditInfo_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *MytitleLabel;


@property(nonatomic,assign)BOOL IfCeritity;
@end

@implementation EditInfo_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.DetailTextField setValue:_COLOR_RGB(0x999999) forKeyPath:@"placeholderLabel.textColor"];
    
    
}
//



-(void)setIndexPath:(NSIndexPath *)IndexPath{
    _IndexPath = IndexPath;
    if (IndexPath.section == 1) {
        if (IndexPath.row == 0) {
            self.MytitleLabel.text = @"姓名";
            self.DetailTextField.text = self.userInfo.userInfo.name;
              self.DetailTextField.userInteractionEnabled = self.IfCeritity;
            self.DetailTextField.keyboardType = UIKeyboardTypeDefault;
        }
        
        if (IndexPath.row == 2) {
            self.MytitleLabel.text = @"手机号";
            self.DetailTextField.placeholder = @"请输入手机号";
            self.DetailTextField.text = self.userInfo.userInfo.phone;
            self.DetailTextField.userInteractionEnabled = NO;
            self.DetailTextField.keyboardType = UIKeyboardTypeDecimalPad;
        }
        if (IndexPath.row == 3) {
            self.MytitleLabel.text = @"身份证号";
            self.DetailTextField.placeholder = @"请输入身份证号";
            self.DetailTextField.text = self.userInfo.userInfo.cardnum;
            self.DetailTextField.userInteractionEnabled = self.IfCeritity;
            self.DetailTextField.keyboardType = UIKeyboardTypeDefault;
        }
      
    }
    if (IndexPath.section == 2) {
  
        if (IndexPath.row == 1) {
            self.MytitleLabel.text = @"工作单位";
            self.DetailTextField.text = self.userInfo.userInfo.workunit;
            self.DetailTextField.placeholder = @"请输入工作单位";
            self.DetailTextField.keyboardType = UIKeyboardTypeDefault;
        }
     
        if (IndexPath.row == 3) {
            self.MytitleLabel.text = @"职位";
            self.DetailTextField.text = self.userInfo.userInfo.position;
            self.DetailTextField.placeholder = @"请输入职位";
            self.DetailTextField.keyboardType = UIKeyboardTypeDefault;
        }
        if (IndexPath.row == 4) {
            self.MytitleLabel.text = @"邮箱";
            self.DetailTextField.text = self.userInfo.userInfo.email;
            self.DetailTextField.placeholder = @"请输入邮箱";
            self.DetailTextField.keyboardType = UIKeyboardTypeDefault;
        }
    }
    
}
-(void)setUserInfo:(QDWUserPersonalInfo *)userInfo{
    _userInfo = userInfo;
    if ([self.userInfo.userInfo.registerstatus integerValue] == 2 ||[self.userInfo.userInfo.registerstatus integerValue] == 1||[self.userInfo.userInfo.registerstatus integerValue] == 4||[self.userInfo.userInfo.registerstatus integerValue] == 7) {
        self.IfCeritity = NO;
    }else{
        self.IfCeritity = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
