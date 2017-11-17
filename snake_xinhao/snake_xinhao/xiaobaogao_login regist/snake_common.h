//
//  snake_common.h
//  Snakes
//
//  Created by 信昊 on 2017/10/27.
//  Copyright © 2017年 Li Xiaolei. All rights reserved.
//

#ifndef snake_common_h
#define snake_common_h

#define XBGBaseColor   _COLOR_RGB(0x9876ff)
// 获取屏幕的宽高
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define _COLOR_RGB(rgbValue) [UIColor colorWith\
Red     :(rgbValue & 0xFF0000)     / (float)0xFF0000 \
green   :(rgbValue & 0xFF00)       / (float)0xFF00 \
blue    :(rgbValue & 0xFF)         / (float)0xFF \
alpha   :1.0]

#define Real(value) ((value)/375.0f*[UIScreen mainScreen].bounds.size.width)

#define IMG(imageName) [UIImage imageNamed:imageName]

#define IPHONE5s 568
#define IPHONE4s 480

#define IPHONE6  667

#define IPHONE6PLUS 736

// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

// 字体设置
#define FontBold(x)     [UIFont boldSystemFontOfSize:x]
#define FontSystem(x)   [UIFont systemFontOfSize:x]

#endif /* snake_common_h */
