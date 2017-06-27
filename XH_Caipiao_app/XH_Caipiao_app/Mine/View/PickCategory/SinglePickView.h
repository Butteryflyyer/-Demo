//
//  SinglePickView.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/5/26.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinglePickView : UIView
@property(nonatomic,copy) NSString *OneComponentStr; // 第一行的串

@property(nonatomic,strong)UIButton *SuccessButton;// 完成

@property(nonatomic,strong)UIButton *CancelButton;// 取消


@property(nonatomic,strong)UIPickerView *pickView;


@property(nonatomic,retain)NSArray *PickViewSource;

@property(nonatomic,strong)UIView *backView ;//底部蒙版


@property(nonatomic,strong)UIView *backBottomView;//承载选择器的

-(instancetype)initWithFrame:(CGRect)frame WithOneArr:(NSArray *)oneArr;
@end
