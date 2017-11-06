//
//  main_view.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/27.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "main_view.h"

@implementation main_view

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent: 0.5];
}
@end
