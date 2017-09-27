//
//  Factory.h
//  Factory
//
//  Created by jk on 16/2/4.
//  Copyright © 2016年 jk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
@interface Factory : NSObject


@end
@interface Factory (JKDate)

//@"1419055200" -> 转化 日期字符串
/**
 *  把一个秒字符串 转化为真正的本地时间
 *
 *  @param timerStr @"1419055200"
 *
 *  @return 转化 日期字符串
 */
+ (NSString *)dateStringFromNumberTimer:(NSString *)timerStr;
+ (NSString *)dateStrFromNumberTimer:(NSString *)timerStr;

// 转化 日期字符串 ->@"1419055200"
/**
 *  将系统时间或者是某一个时间转换成秒字符串
 *
 *  @param date 日期字符串
 *
 *  @return @"1419055200"
 */
+(NSTimeInterval)timeIntervalFormWithDate:(NSDate*)date;

/**
 *  获得当前系统时间到指定时间的时间差字符串,传入目标时间字符串和格式
 *
 *  @param toDate    目标时间字符串
 *  @param formatStr 格式
 *
 *  @return 时间差字符串
 */
+(NSString*)stringNowToDate:(NSString*)toDate formater:(NSString*)formatStr;

+(NSInteger)stringFirstDate:(NSString*)firstDate secondDate:(NSString *)secondDate formater:(NSString *)formatStr;

/**
 *  获取今天日期
 *
 *  @return 获取今天日期
 */
+ (NSString *)getToday;
/**
 *  获取制定时间字符串
 *
 *  @return 时间字符串
 */
+ (NSString *)getTimeStrWith:(NSDate*)date formmatter:(NSString*)str;
/**
 *  获取现在的时间
 *
 *  @return 获取现在的时间
 */
+ (NSString *)getNowTime:(NSDate*)date;

/**
 *
 *
 *  @return 是否有网络
 */
+ (BOOL)isConnected ;

/**
 
 *  获取网络当前时间
 
 */

+ (NSInteger)getInternetDate;
//本地互联网时间计算
+ (NSInteger)getNetData;

@end
@interface Factory (JKSystem)
/**
 *  获取 当前设备版本
 *
 *  @return  当前设备版本
 */
+ (double)getCurrentIOS;
/**
 获取app版本
 
 @return 版本信息
 */
+ (NSString *)VersonString;
//获取本地ip
+ (NSString *)getIPAddress;
/**
 * 判断系统的相机权限有没有打开
 */

+ (BOOL)CanUseCamera;
@end
@interface Factory (JKString)

/**
 *  根据字符串内容的多少  在固定宽度 下计算出实际的行高
 *
 *  @param text      字符串内容的多少
 *  @param textWidth 固定宽度
 *  @param size      字体大小
 *
 *  @return 行高
 */
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size;

/**
 *  将汉字转换成UTF-8码
 *
 *  @param text 汉字
 *
 *  @return UTF-8
 */
+(NSString*)stringFromUTFStringWithText:(NSString*)text;

/**
 *  将UTF-8码转换成oc(汉字)字符串
 *
 *  @param text UTF-8码
 *
 *  @return oc字符串
 */
+(NSString*)utfStringFromObjectStringWithText:(NSString*)text;
@end
@interface Factory (JKImage)

/**
 *  //图片切割的方法
 *
 *  @param image 传入图片
 *  @param rect  切割出来的frame
 *
 *  @return 新的图片
 */
+(UIImage *)clipImage: (UIImage *)image inRect: (CGRect) rect;
@end
@interface Factory (JKFolder)
/**
 *  在沙盒中创建一个文件/文件夹
 *
 *  @param FileExists 文件/文件夹名称
 *
 *  @return 返回路径
 */
+(NSString*)createAFIleExistsWith:(NSString*)FileExists;

/**
 *  路径
 *
 *  @param  内容
 *
 *  @return
 */
+(void)writeDataWithPath:(NSString*)path andData:(id)data;

/**
 *  获取 一个文件 在沙盒沙盒Library/Caches/ 目录下的路径
 *
 *  @param urlName 文件名称
 *
 *  @return 路径
 */
+ (NSString *)getCachesPathWithFile:(NSString *)urlName;

/**
 *  获取 一个文件 在沙盒Documents
 *
 *  @param urlName 文件名称
 *
 *  @return 路径
 */
+ (NSString *)getDocumentsPathWithFile:(NSString *)urlName;


/**
 *  获取 一个文件 在沙盒Tmp
 *
 *  @param urlName 文件名称
 *
 *  @return 路径
 */
+ (NSString *)getTmpPathWithFile:(NSString *)urlName;


/**
 *  检测 缓存文件 是否超时
 *
 *  @param filePath 文件路径
 *  @param timeOut  超时世间点
 *
 *  @return 是否超时
 */
+ (BOOL)isTimeOutWithFile:(NSString *)filePath timeOut:(double)timeOut;

/**
 *  document根文件夹
 *
 *  @return document根文件夹
 */
+(NSString *)documentFolder;



/**
 *  caches根文件夹
 *
 *  @return caches根文件夹
 */
+(NSString *)cachesFolder;



/**
 *  Tmp根文件夹
 *
 *  @return Tmp根文件夹
 */
+(NSString*)tmpFolder;
/**
 *  删除Mycaches
 *
 *  @return 删除Mycaches
 */
+(BOOL)removeAllMyCaches;
/**
 *  删除MyDocuments
 *
 *  @return 删除MyDocuments
 */
+(BOOL)removeAllMyDocuments;
/**
 *  删除MyDocuments某个文件
 *
 *  @return 删除MyDocuments
 */
+(BOOL)removeMyDocumentsWith:(NSString*)file;
/**
 *  删除MyTmp
 *
 *  @return 删除MyTmp
 */
+(BOOL)removeAllMyTmp;

/**
 *  查看文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 文件大小
 */
+(unsigned long long)getFilesSizeWithFilePath:(NSString*)filePath;
@end
@interface Factory (JKUserDefault)
/**
 *  保存普通字符串
 */
+(void)setUserDefoultWithStr:(NSString *)str forkey:(NSString *)key;

/**
 *  读取
 */
+(NSString *)readUserDefoultWithstrForKey:(NSString *)key;

/**
 *  删除
 */
+(void)removeUserDefoultValueForKey:(NSString *)key;


/**
 *  保存int
 */
+(void)setUserDefoultWithInt:(NSInteger)i forkey:(NSString *)key;

/**
 *  读取int
 */
+(NSInteger)readUserDefoultWithintForKey:(NSString *)key;



/**
 *  保存float
 */
+(void)setUserDefoultWithFloat:(CGFloat)floatValue forkey:(NSString *)key;

/**
 *  读取float
 */
+(CGFloat)readUserDefoultWithfloatForKey:(NSString *)key;



/**
 *  保存bool
 */
+(void)setUserDefoultWithBool:(BOOL)boolValue forkey:(NSString *)key;

/**
 *  读取bool
 */
+(BOOL)readUserDefoultWithboolForKey:(NSString *)key;
@end
@interface Factory (JKPredicate)
/**
 *正则匹配手机号
 */
+ (BOOL)checkMobileNumber:(NSString *) telNumber;
/**
 *  正则匹配座机号
 */
+ (BOOL)checkTelNumber:(NSString *) telNumber;
/**
 *正则匹配用户密码6-18位数字和字母组合
 */
+ (BOOL)checkPassword:(NSString *) password;
/**
 *正则匹配用户姓名,20位的中文或英文
 */
+ (BOOL)checkUserName : (NSString *) userName;
/**
 *正则匹配用户身份证号15或18位
 */
+ (BOOL)checkUserIdCard: (NSString *) idCard;
/**
 *正则匹配员工号
 */
+ (BOOL)checkEmployeeNumber : (NSString *) number;
/**
 *正则匹配URL
 */
+ (BOOL)checkURL : (NSString *) url;
/**
 *正则匹配港澳通行证
 */
+ (BOOL)checkLaissezPasser: (NSString *) number;
/**
 *正则匹配军官证
 */
+ (BOOL)checkMilitaryID: (NSString *) number;
/**
 *正则匹配护照
 */
+ (BOOL)checkPassport: (NSString *) number;
/**
 *正则匹配台胞证 MTPs
 */
+ (BOOL)checkMTPs: (NSString *) number;
/**
 *正则匹配邮箱
 */
+ (BOOL)checkEmail: (NSString *) number;
/**
 *正则匹配邮编
 */
+ (BOOL)checkPostcode: (NSString *) number;
/**
 *正则匹配银行卡号
 */
+ (BOOL)checkBankCardNum: (NSString *) number;


@end


