//
//  QDWTools+UICreat.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "QDWTools+UICreat.h"

@implementation QDWTools (UICreat)

+(UIButton *)initBtnWithName:(NSString *)name Withfont:(NSInteger)font WithImag:(UIImage *)img WithTextColor:(UIColor *)textcolor WithBackColor:(UIColor *)backColor WithCornerRadius:(NSInteger)Radius WithFrame:(CGRect)btnframe{
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setTitle:name forState:UIControlStateNormal];
    [Btn setTitleColor:textcolor forState:UIControlStateNormal];
    [Btn setBackgroundColor:backColor];
    [Btn setBackgroundImage:img forState:UIControlStateNormal];
    Btn.titleLabel.font = FontSystem(font);
    Btn.frame = btnframe;
    Btn.layer.cornerRadius = Radius;
    
    return Btn;
}
+(UIView *)initViewWithFrame:(CGRect)viewFrame WithColor:(UIColor *)backColor{
    UIView *view = [[UIView alloc]initWithFrame:viewFrame];
    view.backgroundColor = backColor;
    
    return view;
}
+(UILabel *)initLabelWithText:(NSString *)text WithTextColor:(UIColor *)textColor Withfont:(NSInteger)font WithFrame:(CGRect)labelFrame WithTextAlit:(NSTextAlignment)Aligment{
    UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
    label.font = FontSystem(font);
    label.textColor = textColor;
    label.text = text;
    label.textAlignment = Aligment;
    return label;
}
+(UIBarButtonItem *)initBarButtonItemWithText:(NSString *)text Withfont:(NSInteger)font WithTextColor:(UIColor *)textColor WithBackColor:(UIColor *)backColor WithImg:(UIImage *)Btnimage WithBackImage:(UIImage *)backImage WithFrame:(CGRect)Frame WithTarget:(id)target WithAction:(SEL)action{
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setTitle:text forState:UIControlStateNormal];
    [Btn setTitleColor:textColor forState:UIControlStateNormal];
    [Btn setBackgroundImage:backImage forState:UIControlStateNormal];
    [Btn setImage:Btnimage forState:UIControlStateNormal];
    Btn.titleLabel.font = FontSystem(font);
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    Btn.frame = Frame;
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:Btn];
    return barButtonItem;
}

@end
