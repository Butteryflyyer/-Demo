//
//  feedBackview.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "feedBackview.h"

@interface feedBackview()



@end

@implementation feedBackview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.textview.text = @"Write down the questions you are expernecing,or tell us your valuable opinions~";
    self.photoadd.layer.borderWidth = 1;
    self.photoadd.layer.borderColor = _COLOR_RGB(0x333333).CGColor;
    
}

@end
