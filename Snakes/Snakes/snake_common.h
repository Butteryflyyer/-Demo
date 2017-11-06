//
//  snake_common.h
//  Snakes
//
//  Created by 信昊 on 2017/10/27.
//  Copyright © 2017年 Li Xiaolei. All rights reserved.
//

#ifndef snake_common_h
#define snake_common_h

// 获取屏幕的宽高
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define Real(value) ((value)/375.0f*[UIScreen mainScreen].bounds.size.width)

#define IPHONE5s 568
#define IPHONE4s 480

#define IPHONE6  667

#define IPHONE6PLUS 736

#define FontBold(x)     [UIFont boldSystemFontOfSize:x]
#define FontSystem(x)   [UIFont systemFontOfSize:x]
#endif /* snake_common_h */
