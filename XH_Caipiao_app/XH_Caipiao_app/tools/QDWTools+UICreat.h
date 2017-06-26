//
//  QDWTools+UICreat.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "QDWTools.h"

@interface QDWTools (UICreat)


+(UIButton *)initBtnWithName:(NSString *)name Withfont:(NSInteger)font WithImag:(UIImage *)img WithTextColor:(UIColor *)textcolor WithBackColor:(UIColor *)backColor WithCornerRadius:(NSInteger)Radius WithFrame:(CGRect)btnframe;
+(UIView *)initViewWithFrame:(CGRect)viewFrame WithColor:(UIColor *)backColor;
+(UILabel *)initLabelWithText:(NSString *)text WithTextColor:(UIColor *)textColor Withfont:(NSInteger)font WithFrame:(CGRect)labelFrame WithTextAlit:(NSTextAlignment)Aligment;
+(UIBarButtonItem *)initBarButtonItemWithText:(NSString *)text Withfont:(NSInteger)font WithTextColor:(UIColor *)textColor WithBackColor:(UIColor *)backColor WithImg:(UIImage *)Btnimage WithBackImage:(UIImage *)backImage WithFrame:(CGRect)Frame WithTarget:(id)target WithAction:(SEL)action;
@end
