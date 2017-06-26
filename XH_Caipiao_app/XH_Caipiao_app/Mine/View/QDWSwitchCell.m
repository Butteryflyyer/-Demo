
//
//  QDWSwitchCell.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/2/6.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "QDWSwitchCell.h"
// test3
@interface  QDWSwitchCell()


@end

@implementation QDWSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // 分隔线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    lineView.backgroundColor = _COLOR_RGB(0xd4d4d4);
    

    // self.lineView = lineView;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@QDWRealValue(0.4));
    }];
    
    self.titleLabel.font = FontSystem(QDWRealValue(16));
    
    
    
//    
//    
//    BOOL on = NSUSEROBJECTFORBOOLKEY(QDWUmengPushSwitchBtn);
//   
//    if (on) {
//        
//        [self.SwitchBtn setOn:YES];
//    }else{
//        
//        [self.SwitchBtn setOn:NO];
//    }
    

    [MinePageManager FindUserAppMsgSettingSuccess:^(id data) {
        if (data) {

            if ([data isEqual:@"1"]) {
                [self.SwitchBtn setOn:YES];
                
//                [UmengManager UmengaddAlisWithCity:[QDWUser shareManager].UserCity];
            }else{
                
                [self.SwitchBtn setOn:NO];
              
//                 [UmengManager UmengRemoveAlis];
            }
            
            
        }
        
    }];
    
    
   

    
    // Initialization code
}

-(CGFloat)RealValue:(CGFloat)value{
    
    return (value)/375.0f*[UIScreen mainScreen].bounds.size.width;
    
}


- (IBAction)SwitchAction:(id)sender {
    
    NSString *msgEnble;
    
    BOOL isButtonOn = [self.SwitchBtn isOn];
    
    if (isButtonOn) {//打开
        msgEnble = @"1";
   
        
    }else{//关闭
        msgEnble = @"0";
        

    }
    
    [MinePageManager AppSettingPushMsgWithmsgEnable:msgEnble Success:^(id data) {
        if (data) {
            if ([msgEnble isEqual:@"1"]) {
                 [UmengManager UmengaddAlisWithCity:[QDWUser shareManager].UserCity];
            }
           
            if ([msgEnble isEqual:@"0"]) {
                   [UmengManager UmengRemoveAlis];
                
            }
        }
    }];
    

    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
