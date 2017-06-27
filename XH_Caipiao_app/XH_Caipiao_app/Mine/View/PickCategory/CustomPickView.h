//
//  CustomPickView.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/5/25.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPickView : UIView

@property(nonatomic,copy) NSString *OneComponentStr; // 第一行的串


@property(nonatomic,copy) NSString *TwoComponentStr; // 第二行的串


@property(nonatomic,strong)UIButton *SuccessButton;// 完成

@property(nonatomic,strong)UIButton *CancelButton;// 取消


@property(nonatomic,strong)UIPickerView *pickView;

@property(nonatomic,strong)UIView *backView;

@property(nonatomic,strong)UIView *TopbackView ;//底部蒙版

@property(nonatomic,strong)UIView *backBottomView;//承载选择器的

-(instancetype)initWithFrame:(CGRect)frame WithOneArr:(NSArray *)oneArr WithTwoArr:(NSDictionary *)twoDic;

@end
