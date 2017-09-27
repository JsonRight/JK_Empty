//
//  MyHelper.h
//  Factory
//
//  Created by jk on 16/2/4.
//  Copyright © 2016年 jk. All rights reserved.
//

#ifndef MyHelper_h
#define MyHelper_h

/**
 *  调试 代码的宏
 *
 *  @param NSLog(...)...表示变参宏
 
 *  NSLog(__VA_ARGS__)__VA_ARGS__表示接受宏中的变参
 *DEBUG 宏 在调试模式下（DeBug）下系统会定义，在发布模式下（release）不会定义
 *  @return 如果定义过宏DEBUG那么NSLog 表示NSLong函数，否则表示空
 */

#ifdef DEBUG
//#define DLog(format, ...) do {                                              \
//fprintf(stderr, "<%s : %d> %s ",                                            \
//[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
//__LINE__, __func__);                                                        \
//(NSLog)((format), ##__VA_ARGS__);                                           \
//fprintf(stderr, "==========================\n");                            \
//} while (0);
#define DLog(...) printf("<%s : %d>%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
//#define DLog(fmt,...) NSLog((@"^ 🐶<%s : %d>  " fmt),[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__,##__VA_ARGS__);
#define DLogRect(rect) DLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
#define DLogSize(size) DLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height);
#define DLogPoint(point) DLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y);
#else
#define DLog(format, ...)
#define DLogRect(rect)
#define DLogSize(size)
#define DLogPoint(point)
#undef NSLog
#define NSLog(args, ...)
#endif
//44是一个特殊的常量，默认行高和NavigationBar的高度为44
#define Default 44
//距离左边边距为10
#define LeftDistance 10
//控件间的距离
#define ControlDistance 20
//获取屏幕大小
#define Screen [UIScreen mainScreen].bounds
//获取屏幕大小
#define ScreenSize [UIScreen mainScreen].bounds.size
//获取屏幕的宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//获取屏幕的高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
// 操作系统版本号
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

// 是否横竖屏
// 用户界面横屏了才会返回YES
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])
// 无论支不支持横屏，只要设备横屏了，就会返回YES
#define IS_DEVICE_LANDSCAPE UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])


// 屏幕宽度，会根据横竖屏的变化而变化
#define SCREEN_WIDTH (IOS_VERSION >= 8.0 ? [[UIScreen mainScreen] bounds].size.width : (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width))

// 屏幕宽度，跟横竖屏无关
#define DEVICE_WIDTH (IOS_VERSION >= 8.0 ? (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width) : [[UIScreen mainScreen] bounds].size.width)

// 屏幕高度，会根据横竖屏的变化而变化
#define SCREEN_HEIGHT (IOS_VERSION >= 8.0 ? [[UIScreen mainScreen] bounds].size.height : (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height))

// 屏幕高度，跟横竖屏无关
#define DEVICE_HEIGHT (IOS_VERSION >= 8.0 ? (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height) : [[UIScreen mainScreen] bounds].size.height)
//安全释放宏
#define Release_Safe(_control) [_control release], _control = nil;

//传入RGB三个参数，得到颜色
#define RGB(r,g,b) RGBA(r,g,b,1.f)
//取得随机颜色
#define RandomColor RGB(arc4random()%256,arc4random()%256,arc4random()%256)
//传入RGBA四个参数，得到颜色
//美工和设计通过PS给出的色值是0~255
//苹果的RGB参数给出的是0~1
//那我们就让美工给出的 参数/255 得到一个0-1之间的数
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXString(c) [UIColor colorWithHexString:c]
//字体宏
#ifndef UIFontPFSCForSize
#define UIFontPFSCForSize(a)   [UIFont fontWithName:@".PingFangSC-Regular" size:a]?[UIFont fontWithName:@".PingFangSC-Regular" size:a]:[UIFont systemFontOfSize:a]
#endif
//全局通用常量定义,结尾请不要使用；号


//ios系统版本
#define ios10x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0f)
#define ios9x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0f)
#define ios8x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0f)
#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f
#define iosNot6x [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f


#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)

/*//图片宏
 #define Image(str) [UIImage imageNamed:str]
 //取图宏
 #define ImageForPath(name,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]]*/
/**
 度数
 */
#define angle(d) ((M_PI / 180.0f) * d)//1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
/**
 //程序是否打开过 如果打开过 就不是 第一次打开了
 BOOL isOpen = [[NSUserDefaults standardUserDefaults] boolForKey:kIsOpen];
 if (!isOpen) {
 //第一次打开
 self.window.rootViewController = [[BeginOpenViewController alloc] init];
 }else {
 self.window.rootViewController = [[PicketKitchenTabBarController alloc] init];
 }
 //记录打开过
 [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsOpen];
 //            //获取window
 //            //UIWindow *window = self.tabBarController.view;
 //            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
 
 */
//不为nil或[NSNull null]时，为YES，不适合用于判断字符串是否为空
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
//为nil或[NSNull null]时，为YES，不适合用于判断字符串是否为空
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
//字符串是否为空,为空时值为YES
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//字符串是否不为空，不为空时值为YES
#define IsStrNotEmpty(_ref)    (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]) && (![(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

#define kIsOpen @"isOpen"//是否打开过
#define canEvaluatePolicys @"canEvaluatePolicys"//是否支持指纹
#define AccountNumber @"AccountNumber"//账号
#define UserPassword @"UserPassword"

#define CoreLockPWDKey  @"CoreLockPWDKey"//手势密码

#define isSwitch @"isSwitch"//手势密码开关
#define isEvaluateID @"isEvaluateID"//是否启用指纹



#endif /* MyHelper_h */
