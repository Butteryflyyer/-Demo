

//
//  HomeBottom_View.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "HomeBottom_View.h"


@interface HomeBottom_View ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_const;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right_const;

@end

@implementation HomeBottom_View

-(void)awakeFromNib{
    [super awakeFromNib];
    
    CGFloat gap =(SCREEN_WIDTH - 3*50-2*20)/4;
    
    self.left_const.constant = gap;
    self.right_const.constant = gap;
    
    [self layoutIfNeeded];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
