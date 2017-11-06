//
//  info_cell.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "info_cell.h"

@implementation info_cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setIndexpath:(NSIndexPath *)indexpath{
    _indexpath = indexpath;
    if (indexpath.row == 0) {
        self.titlelabel.text = @"Name";
        self.textfiled.placeholder = @"please enter";
    }
    if (indexpath.row == 1) {
        self.titlelabel.text = @"Gender";
        self.textfiled.placeholder = @"please enter";
    }
    if (indexpath.row == 2) {
        self.titlelabel.text = @"Address";
        self.textfiled.placeholder = @"please enter";
    }
    if (indexpath.row == 3) {
        self.titlelabel.text = @"Telephone";
        self.textfiled.placeholder = @"please enter";
    }
    if (indexpath.row == 4) {
        self.titlelabel.text = @"Your love";
        self.textfiled.placeholder = @"please enter";
    }
    if (indexpath.row == 5) {
        self.titlelabel.text = @"Your email";
        self.textfiled.placeholder = @"please enter";
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
