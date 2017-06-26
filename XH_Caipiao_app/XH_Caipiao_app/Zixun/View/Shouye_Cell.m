//
//  Shouye_Cell.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Shouye_Cell.h"

@interface Shouye_Cell ()
@property (weak, nonatomic) IBOutlet UIImageView *Caipiao_icon;
@property (weak, nonatomic) IBOutlet UILabel *Zhongjiang_num;

@end

@implementation Shouye_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(Caipiao_Model *)model{
    _model = model;
    
    self.Caipiao_icon.image = IMG(@"双色球");
    self.Zhongjiang_num.text = model.openCode;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
