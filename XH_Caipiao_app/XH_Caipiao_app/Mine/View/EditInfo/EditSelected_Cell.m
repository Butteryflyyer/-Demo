//
//  EditSelected_Cell.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "EditSelected_Cell.h"

@interface EditSelected_Cell ()

@property (weak, nonatomic) IBOutlet UILabel *mytitleLabel;



@end

@implementation EditSelected_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     [self.myTextfield setValue:_COLOR_RGB(0x999999) forKeyPath:@"placeholderLabel.textColor"];
    self.myTextfield.userInteractionEnabled = NO;
}

-(void)setIndexPath:(NSIndexPath *)IndexPath{
    _IndexPath = IndexPath;
    if (IndexPath.section == 1) {
        if (IndexPath.row == 1) {
            self.myTextfield.placeholder = @"请选择";
            self.mytitleLabel.text = @"性别";
            if ([self.userInfo.userInfo.sex integerValue] == 0) {
                self.myTextfield.text = @"男";
            }
            if ([self.userInfo.userInfo.sex integerValue] == 1) {
                self.myTextfield.text = @"女";
            }
        }
      
        
        
    }
    if (IndexPath.section == 2) {
        if (IndexPath.row == 0) {
            self.myTextfield.placeholder = @"请选择城市";
            self.mytitleLabel.text = @"业务区域";
            self.myTextfield.text = self.userInfo.userInfo.workcity;
        }
   
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
