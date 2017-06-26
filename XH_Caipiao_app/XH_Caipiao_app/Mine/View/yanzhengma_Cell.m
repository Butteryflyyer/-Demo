//
//  yanzhengma_Cell.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/6/15.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "yanzhengma_Cell.h"

@implementation yanzhengma_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title_detaile_textField.userInteractionEnabled = NO;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
