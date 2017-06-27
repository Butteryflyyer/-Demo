//
//  MenuView.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/1/6.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        [self initSubViews];
        
    }
    return self;
    
}
-(void)initSubViews{
    self.backgroundColor = _COLOR_RGB(0xffffff);
    CGFloat Selected_Width = 42;
    CGFloat Selected_Height = 72;
    CGFloat TopGap = QDWRealValue(15);
    CGFloat midGap = (SCREEN_WIDTH - 64-4*Selected_Width)/3;
    
    
    
    self.FindOrderView = [[[NSBundle mainBundle]loadNibNamed:@"MenuSubView" owner:self options:nil]firstObject];
    self.FindOrderView.frame = CGRectMake(32, TopGap, Selected_Width, Selected_Height);
    self.FindOrderView.NowImage = IMG(@"首页找单");
    self.FindOrderView.NowText = @"抽奖";
    
    [self addSubview:self.FindOrderView];
    
    self.FireOrderView = [[[NSBundle mainBundle]loadNibNamed:@"MenuSubView" owner:self options:nil]firstObject];
    self.FireOrderView.frame = CGRectMake(MaxX(self.FindOrderView)+midGap, TopGap, Selected_Width, Selected_Height);
    self.FireOrderView.NowImage = IMG(@"首页发单");
    self.FireOrderView.NowText = @"走势";
    
    [self addSubview:self.FireOrderView];
    
    self.ActivityView = [[[NSBundle mainBundle]loadNibNamed:@"MenuSubView" owner:self options:nil]firstObject];
    self.ActivityView.frame = CGRectMake(MaxX(self.FireOrderView)+midGap, TopGap, Selected_Width, Selected_Height);
    self.ActivityView.NowImage = IMG(@"首页活动");
    self.ActivityView.NowText = @"新闻";
    
    [self addSubview:self.ActivityView];
    
    self.ServeView = [[[NSBundle mainBundle]loadNibNamed:@"MenuSubView" owner:self options:nil]firstObject];
    self.ServeView.frame = CGRectMake(MaxX(self.ActivityView)+midGap, TopGap, Selected_Width, Selected_Height);
    self.ServeView.NowImage = IMG(@"首页服务");
    self.ServeView.NowText = @"服务";
    
    [self addSubview:self.ServeView];
    
    
}

@end
