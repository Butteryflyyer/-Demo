//
//  password_view.m
//  xiaoxinyong
//
//  Created by 信昊 on 2017/9/12.
//  Copyright © 2017年 xiaoxinyong. All rights reserved.
//

#import "password_view.h"

@implementation password_view

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.Showhiden_pass_btn.selected = NO;
    self.password_textfield.secureTextEntry = YES;
    @weakify(self)
    [[self.Showhiden_pass_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       @strongify(self)
        self.Showhiden_pass_btn.selected = !self.Showhiden_pass_btn.selected;
        self.password_textfield.secureTextEntry = !self.Showhiden_pass_btn.selected;
    }];
}
@end
