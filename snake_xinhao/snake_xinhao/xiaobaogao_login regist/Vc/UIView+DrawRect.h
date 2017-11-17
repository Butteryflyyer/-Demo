//
//  UIView+DrawRect.h
//  弹射
//
//  Created by 阿城 on 15/10/17.
//  Copyright © 2015年 阿城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DrawRect)


//选择拖动点
- (BOOL)selectPoint:(CGPoint)Point OnCenter:(CGPoint)center;

//相对坐标
CGPoint relativeCor(CGPoint point,CGFloat x,CGFloat y);


@end
