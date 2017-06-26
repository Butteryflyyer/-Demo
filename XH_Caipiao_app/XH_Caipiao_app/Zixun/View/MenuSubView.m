//
//  MenuSubView.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/1/6.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "MenuSubView.h"

@implementation MenuSubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.TitleLabel.font = FontSystem(QDWRealValue(15));
    
    
    
}

-(void)setNowText:(NSString *)NowText{
    
    self.TitleLabel.text = NowText;
    
    
}
-(void)setNowImage:(UIImage *)NowImage{
    
    [self.SelectedBtn setImage:NowImage forState:UIControlStateNormal];
    
    
}
@end
