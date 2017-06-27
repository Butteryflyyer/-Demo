//
//  UIView+QDWExtension.h
//
//  Created by 信昊 on 16/5/2.
//  Copyright (c) 2016年 信昊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QDWExtension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/** 从xib中创建一个控件 */
+ (instancetype)viewFromXib;
@end
