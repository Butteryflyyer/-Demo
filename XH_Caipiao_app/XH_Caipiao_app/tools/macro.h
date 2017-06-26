//
//  macro.h
//  wenta
//
//  Created by zhouyi on 14-5-12.
//  Copyright (c) 2014年 Happiness. All rights reserved.
//

#ifndef ___macro_h
#define ___macro_h

#define FormatCicle_btn_ImageName @"钱到位圆角按钮" //300 70
#define FormatMidCicle_btn_ImageName @"钱到位中等长度圆角矩形" //490 80

#define Time_SelectedTools 0.2

/**
 *   苹果手机尺寸
 *
 */

#define IPHONE5s 568
#define IPHONE4s 480

#define IPHONE6  667 

#define IPHONE6PLUS 736

#define EnglishKeyboard_Height    SCREEN_HEIGHT > IPHONE6 ? 226 : 216

#define QDWRealValue(value) ((value)/375.0f*[UIScreen mainScreen].bounds.size.width)
/**
 *  图片加载
 *
 */

#define IMG(imageName) [UIImage imageNamed:imageName]

#define NSNotiFicationCenterPost(name)  [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];

#define NSNotiFicationCenterPostObject(name,object)  [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];

#define NSUserDefaults_Syn [[NSUserDefaults standardUserDefaults]synchronize]; // 保存安全

#define NSUSER_SAVEBOOL(value,key)  [[NSUserDefaults standardUserDefaults]setBool:value forKey:key];

#define NSUSERO_BJECTFORBOOLKEY(key) [[NSUserDefaults standardUserDefaults]boolForKey:key];

#define  NSUSER_SAVE(value,key) [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];

#define NSUSER_OBJECTFORRKEY(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define NSUSERE_MOVEOBJECT(key)  [[NSUserDefaults standardUserDefaults]removeObjectForKey:key]

#define STRING(str) @property(nonatomic,copy) NSString *str

// 获取设备版本
#define IOS_7 [[UIDevice currentDevice].systemVersion floatValue] >= 7.0
// Model中NSString属性设置
#define PropertyString(str) @property (nonatomic, copy) NSString * str;
// 字体设置
#define FontBold(x)     [UIFont boldSystemFontOfSize:x]
#define FontSystem(x)   [UIFont systemFontOfSize:x]
// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define _COLOR_RGB(rgbValue) [UIColor colorWith\
Red     :(rgbValue & 0xFF0000)     / (float)0xFF0000 \
green   :(rgbValue & 0xFF00)       / (float)0xFF00 \
blue    :(rgbValue & 0xFF)         / (float)0xFF \
alpha   :1.0]


// 获取屏幕的宽高
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

//** 沙盒路径 ***********************************************************************************
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


/* ****************************************************************************************************************** */
/** DEBUG LOG **/
#ifdef DEBUG

#define DLOG( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#else

#define DLOG( s, ... )

#endif


#ifdef DEBUG

#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
//同步银联订单并直接支付
#define kSTATE_CODE @"00"
#else

#define DLog( s, ... )
#define kSTATE_CODE @"00"
#endif


/** DEBUG RELEASE **/
#if DEBUG

#define MCRelease(x)            [x release]

#else

#define MCRelease(x)            [x release], x = nil

#endif


/** NIL RELEASE **/
#define NILRelease(x)           [x release], x = nil


/* ****************************************************************************************************************** */
#pragma mark - Frame (宏 x, y, width, height)

// App Frame
#define Application_Frame       [[UIScreen mainScreen] applicationFrame]

// App Frame Height&Width
#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width

// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width


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

#define selfViewWidth           WIDTH(self.view)
#define selfViewHeight          HEIGHT(self.view)
// 系统控件默认高度
#define kStatusBarHeight        (20.f)
#define kTopBarHeight           (44.f)
#define kTopBarWithStatusHeight (64.f)
#define kBottomBarHeight        (49.f)

#define kCellDefaultHeight      (44.f)

#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)



#define NLSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
#define IOS7_OR_LATER NLSystemVersionGreaterOrEqualThan(7.0)
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/* ****************************************************************************************************************** */
#pragma mark - Funtion Method (宏 方法)

// PNG JPG 图片路径
#define PNGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// 加载图片
#define PNGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// 颜色(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


#define kpopToViewController \
\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
[self.navigationController popViewControllerAnimated:YES];\
});



// 当前语言
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])

// 是否Retina屏
#define isRetina                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 960), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

// 是否iPhone5
#define isiPhone5               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

// 是否iPad
#define isIPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// UIView - viewWithTag
#define VIEWWITHTAG(_OBJECT, _TAG)\
\
[_OBJECT viewWithTag : _TAG]

// 本地化字符串
/** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
#define LocalString(x, ...)     NSLocalizedString(x, nil)
/** NSLocalizedStringFromTable宏做的其实就是在当前bundle中查找资源文件名“xxx.strings”(参数:键＋文件名＋注释) */
#define AppLocalString(x, ...)  NSLocalizedStringFromTable(x, @"someName", nil)

// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define UIColorFromRGBA(rgbValue, a) \
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:a]




#if TARGET_OS_IPHONE
/** iPhone Device */
#endif

#if TARGET_IPHONE_SIMULATOR
/** iPhone Simulator */
#endif

// ARC
#if __has_feature(objc_arc)
/** Compiling with ARC */
#else
/** Compiling without ARC */
#endif


#define NSStringFromInt(int)        [NSString stringWithFormat:@"%d", int]
#define NSStringFromFloat(float)    [NSString stringWithFormat:@"%f", float]

//计算线条宽度函数
#define LineWidth(CGFloat) CGFloat / [UIScreen mainScreen].scale




#endif
