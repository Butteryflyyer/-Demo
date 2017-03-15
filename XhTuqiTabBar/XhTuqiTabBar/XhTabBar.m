//
//  XhTabBar.m
//  XhTuqiTabBar
//
//  Created by 信昊 on 17/3/3.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "XhTabBar.h"
#import "UIView+LBExtension.h"
#define XHMagin 10

@interface XhTabBar ()

@property(nonatomic,strong)UIButton * MindBtn;

@end


@implementation XhTabBar


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setShadowImage:[UIImage new]];
        self.MindBtn = [[UIButton alloc]init];
        [self.MindBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [self.MindBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
        [self.MindBtn addTarget:self action:@selector(MidBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.MindBtn];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    Class class = NSClassFromString(@"UITabBarButton");
    self.MindBtn.centerX = self.centerX;
    self.MindBtn.centerY = self.height * 0.5 -2*XHMagin;
    self.MindBtn.size = CGSizeMake(self.MindBtn.currentBackgroundImage.size.width, self.MindBtn.currentBackgroundImage.size.height);
    UILabel *label = [[UILabel alloc] init];
    label.text = @"发布";
    label.font = [UIFont systemFontOfSize:11];
    [label sizeToFit];
    label.textColor = [UIColor grayColor];
    [self addSubview:label];
    label.centerX = self.MindBtn.centerX;
    label.centerY = CGRectGetMaxY(self.MindBtn.frame) + XHMagin ;
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:class]) {
            btn.width = self.width/5;
            btn.x = btn.width * btnIndex;
            btnIndex++;
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
    [self bringSubviewToFront:self.MindBtn];
}
-(void)MidBtnDidClick{
    if ([self.delegate respondsToSelector:@selector(tabBarMidBtnClick:)]) {
        [self.myDelegate tabBarMidBtnClick:self];
    }
    
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.isHidden == NO) {
        CGPoint newp = [self convertPoint:point toView:self.MindBtn];
        if ([self.MindBtn pointInside:newp withEvent:event]) {
            return self.MindBtn;
        }else{
            return [super hitTest:point withEvent:event];
        }
    }else{
        return [super hitTest:point withEvent:event];
    }
    
}


@end
