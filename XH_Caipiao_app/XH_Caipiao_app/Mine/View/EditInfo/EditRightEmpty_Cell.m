//
//  EditRightEmpty_Cell.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "EditRightEmpty_Cell.h"

@interface EditRightEmpty_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *mytitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *RightTitleLabel;


@end

@implementation EditRightEmpty_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.myTextfield.keyboardType = UIKeyboardTypeDecimalPad;
    [self.myTextfield setValue:_COLOR_RGB(0x999999) forKeyPath:@"placeholderLabel.textColor"];
    // Initialization code
}

-(void)setIndexPath:(NSIndexPath *)IndexPath{
    _IndexPath = IndexPath;
    if (IndexPath.section == 2) {
        self.mytitleLabel.text = @"工作经验";
        self.RightTitleLabel.text = @"年";
        self.myTextfield.text = self.userInfo.userInfo.workexperience;
        self.myTextfield.placeholder = @"请输入工作经验";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
