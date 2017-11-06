//
//  borderColor_btn.m
//  xiaoxinyong
//
//  Created by 信昊 on 2017/9/12.
//  Copyright © 2017年 xiaoxinyong. All rights reserved.
//

#import "borderColor_btn.h"

@implementation borderColor_btn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    if (self = [super init]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
   
    [self setBackgroundImage:IMG(@"noColor_btn_background") forState:UIControlStateNormal];
    [self setTitleColor:XBGBaseColor forState:UIControlStateNormal];
    self.titleLabel.font = FontSystem(Real(16));
}
@end
