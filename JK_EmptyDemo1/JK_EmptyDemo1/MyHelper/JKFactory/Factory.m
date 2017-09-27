//
//  Factory.m
//  Factory
//
//  Created by jk on 16/2/4.
//  Copyright © 2016年 jk. All rights reserved.
//

#import "Factory.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation Factory
#pragma mark -Factory

@end
@implementation Factory (JKDate)
#pragma mark -Factory (JKDate)
/**
 *  把一个秒字符串 转化为真正的本地时间
 *
 *  @param timerStr @"1419055200"
 *
 *  @return 转化 日期字符串
 */
+ (NSString *)dateStringFromNumberTimer:(NSString *)timerStr {
    //转化为Double
    double t = [timerStr doubleValue];
    //计算出距离1970的NSDate
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t];
    //转化为 时间格式化字符串
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //转化为 时间字符串
    return [df stringFromDate:date];
}
/**
 *  将日期字符串转化为日期yyyy-MM-dd
 */
+ (NSString *)dateStrFromNumberTimer:(NSString *)timerStr {
    //转化为Double
    double t = [timerStr doubleValue];
    //计算出距离1970的NSDate
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t];
    //转化为 时间格式化字符串
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    //    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    df.dateFormat = @"yyyy-MM-dd";
    //转化为 时间字符串
    return [df stringFromDate:date];
}
/**
 *  将系统时间或者是某一个时间转换成秒字符串
 *
 *  @param date 日期字符串
 *
 *  @return @"1419055200"
 */
+(NSTimeInterval)timeIntervalFormWithDate:(NSDate*)date{
    NSTimeInterval time=0;
    if (!date) {
        NSDate *today = [NSDate date];
        time=[today timeIntervalSince1970];
    }else{
        time=[date timeIntervalSince1970];
    }
    return time;
}
//获得当前系统时间到指定时间的时间差字符串,传入目标时间字符串和格式
/**
 *  获得当前系统时间到指定时间的时间差字符串,传入目标时间字符串和格式
 *
 *  @param toDate    目标时间字符串
 *  @param formatStr 格式
 *
 *  @return 时间差字符串
 */
+(NSString*)stringNowToDate:(NSString*)toDate formater:(NSString*)formatStr
{
    
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    if (formatStr) {
        [formater setDateFormat:formatStr];
    }
    else{
        [formater setDateFormat:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
    }
    NSDate *date=[formater dateFromString:toDate];
    
    return [self stringNowToDate:date];
    
}
//获得到指定时间的时间差字符串,格式在此方法内返回前自己根据需要格式化
+(NSString*)stringNowToDate:(NSDate*)toDate
{
    //创建日期 NSCalendar对象
    NSCalendar *cal = [NSCalendar currentCalendar];
    //得到当前时间
    NSDate *today = [NSDate date];
    
    //用来得到具体的时差,位运算
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
    
    if (toDate && today) {//不为nil进行转化
        NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:toDate options:0 ];
        
        //NSString *dateStr=[NSString stringWithFormat:@"%d年%d月%d日%d时%d分%d秒",[d year],[d month], [d day], [d hour], [d minute], [d second]];
        NSString *dateStr=[NSString stringWithFormat:@"%02ld:%02ld:%02ld",[d hour], [d minute], [d second]];
        return dateStr;
    }
    return @"";
}

+(NSInteger)stringFirstDate:(NSString*)firstDate secondDate:(NSString *)secondDate formater:(NSString *)formatStr{

    if (firstDate.integerValue<=secondDate.integerValue) {
        return 0;
    }else{
        NSDateFormatter *formater=[[NSDateFormatter alloc] init];
        if (formatStr) {
            [formater setDateFormat:formatStr];
        }
        else{
            [formater setDateFormat:[NSString stringWithFormat:@"yyyy-MM-dd"]];
        }
        NSString *date1=[Factory dateStrFromNumberTimer:firstDate];
        NSString *date2=[Factory dateStrFromNumberTimer:secondDate];
        
        
        if (date1&& date2) {//不为nil进行转化
            NSTimeInterval a=[formater dateFromString:date1].timeIntervalSince1970;
            NSTimeInterval b=[formater dateFromString:date2].timeIntervalSince1970;
            NSInteger c=(a-b)/(3600*24.0);
            
            return c;
        }
        return 0;
    }
    
}

/**
 *  获取今天日期
 *
 *  @return 获取今天日期
 */
+ (NSString *)getToday
{
    NSDate *date               = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr          = [formatter stringFromDate:date];
    return dateStr;
}
/**
 *  获取制定时间字符串
 *
 *  @return 时间字符串
 */
+ (NSString *)getTimeStrWith:(NSDate*)date formmatter:(NSString*)str{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:str];
    NSString *dateStr          = [formatter stringFromDate:date];
    return dateStr;
}
/**
 *  获取现在的时间
 *
 *  @return 获取现在的时间
 */
+ (NSString *)getNowTime:(NSDate*)date
{
    if (!date) {
        date = [NSDate date];
    }
    
//    DLog(@"121 %@",date)
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //本地时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
//    系统时区间隔
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate: date];
//    本地时区间隔
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
//    DLog(@"%@\n %@\n %ld\n %ld\n",sourceTimeZone,destinationTimeZone,sourceGMTOffset,destinationGMTOffset)
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
//    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    NSString*timer =[destinationDateNow.description substringWithRange:NSMakeRange(0, destinationDateNow.description.length-6)];
    return timer;
}





@end
@implementation Factory (JKSystem)
#pragma mark -Factory (JKSystem)
//获取iOS版本号
/**
 *  获取 当前设备版本
 *
 *  @return  当前设备版本
 */
+ (double)getCurrentIOS {
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}
/**
 获取app版本
 
 @return 版本信息
 */
+ (NSString *)VersonString{
    NSDictionary* info = [NSBundle mainBundle].infoDictionary;
    return info[@"CFBundleShortVersionString"];
}


+ (NSString *)getIPAddress {
    NSString *address = @"0.0.0.0";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/**
 * 判断系统的相机权限有没有打开
 */

+ (BOOL)CanUseCamera{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == ALAuthorizationStatusDenied||authStatus == ALAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

@end
@implementation Factory (JKString)
#pragma mark -Factory (JKString)
//动态 计算行高
//根据字符串的实际内容的多少 在固定的宽度和字体的大小，动态的计算出实际的高度
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    if ([Factory getCurrentIOS] >= 7.0) {
        //iOS7之后
        /*
         第一个参数: 预设空间 宽度固定  高度预设 一个最大值
         第二个参数: 行间距 如果超出范围是否截断
         第三个参数: 属性字典 可以设置字体大小
         */
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        //返回计算出的行高
        return rect.size.height;
        
    }else {
        //iOS7之前
        /*
         1.第一个参数  设置的字体固定大小
         2.预设 宽度和高度 宽度是固定的 高度一般写成最大值
         3.换行模式 字符换行
         */
        
        
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size;
        //        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(textWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        
        return textSize.height;//返回 计算出得行高
    }
}

//将汉字转换成UTF-8码
+(NSString*)stringFromUTFStringWithText:(NSString*)text{
    //ios9
    /*[text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];*/
    
    return [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}
//将UTF-8码转换成oc字符串
+(NSString*)utfStringFromObjectStringWithText:(NSString*)text{
    //    ios9
    /*[text stringByRemovingPercentEncoding];*/
    return [text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
@implementation Factory (JKImage)
#pragma mark -Factory (JKImage)
//图片切割的方法
+(UIImage *)clipImage: (UIImage *)image inRect: (CGRect) rect
{
    //获取父图片要切的位置
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    //用子图片来接收切割出来的图片
    UIImage *subImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return subImage;
}
@end
@implementation Factory (JKFolder)
#pragma mark -Factory (JKFolder)
//获取 一个文件 在沙盒Library/Caches/ 目录下的路径
+ (NSString *)getCachesPathWithFile:(NSString *)urlName {
    
    //先获取 沙盒中的Library/Caches/路径
    NSString *docPath = [Factory cachesFolder];
    NSString *myCacheDirectory = [docPath stringByAppendingPathComponent:@"MyCaches"];
    //检测MyCaches 文件夹是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:myCacheDirectory]) {
        //不存在 那么创建
        [[NSFileManager defaultManager] createDirectoryAtPath:myCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //用md5进行 加密 转化为 一串十六进制数字 (md5加密可以把一个字符串转化为一串唯一的用十六进制表示的串)
    //    NSString * newName = [urlName MD5Hash];
    
    //拼接路径
    return [myCacheDirectory stringByAppendingPathComponent:urlName];
}
/**
 *  在沙盒中创建一个文件/文件夹
 *
 *  @param FileExists 文件/文件夹名称
 *
 *  @return 返回路径
 */
+(NSString*)createAFIleExistsWith:(NSString*)FileExists{
    NSString*docPath = [Factory documentFolder];
    NSString *myCacheDirectory = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"MyDocuments/%@",FileExists]];
    //检测MyCaches 文件夹是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:myCacheDirectory]) {
        //不存在 那么创建
        [[NSFileManager defaultManager] createDirectoryAtPath:myCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return myCacheDirectory;
}
+(void)writeDataWithPath:(NSString*)path andData:(id)data{
    //检测MyCaches 文件夹是否存在
    
    [data writeToFile:path atomically:YES];
}

//获取 一个文件 在沙盒Documents
/**
 *  获取 一个文件 在沙盒Documents
 *
 *  @param urlName 文件名称
 *
 *  @return 路径
 */
+ (NSString *)getDocumentsPathWithFile:(NSString *)urlName{
    NSString*docPath = [Factory documentFolder];
    NSString *myCacheDirectory = [docPath stringByAppendingPathComponent:@"MyDocuments"];
    //检测MyCaches 文件夹是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:myCacheDirectory]) {
        //不存在 那么创建
        [[NSFileManager defaultManager] createDirectoryAtPath:myCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //用md5进行 加密 转化为 一串十六进制数字 (md5加密可以把一个字符串转化为一串唯一的用十六进制表示的串)
    //    NSString * newName = [urlName MD5Hash];
    
    //拼接路径
    return [myCacheDirectory stringByAppendingPathComponent:urlName];
    
}

//获取 一个文件 在沙盒Tmp
/**
 *  获取 一个文件 在沙盒Tmp
 *
 *  @param urlName 文件名称
 *
 *  @return 路径
 */
+ (NSString *)getTmpPathWithFile:(NSString *)urlName{
    NSString*docPath = [Factory documentFolder];
    NSString *myCacheDirectory = [docPath stringByAppendingPathComponent:@"MyTmp"];
    //检测MyCaches 文件夹是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:myCacheDirectory]) {
        //不存在 那么创建
        [[NSFileManager defaultManager] createDirectoryAtPath:myCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //用md5进行 加密 转化为 一串十六进制数字 (md5加密可以把一个字符串转化为一串唯一的用十六进制表示的串)
    //    NSString * newName = [urlName MD5Hash];
    
    //拼接路径
    return [myCacheDirectory stringByAppendingPathComponent:urlName];
    
}

//检测 缓存文件 是否超时
/**
 *  检测 缓存文件 是否超时
 *
 *  @param filePath 文件路径
 *  @param timeOut  超时世间点
 *
 *  @return 是否超时
 */
+ (BOOL)isTimeOutWithFile:(NSString *)filePath timeOut:(double)timeOut {
    //获取文件的属性
    NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    //获取文件的上次的修改时间
    NSDate *lastModfyDate = fileDict.fileModificationDate;
    //算出时间差 获取当前系统时间 和 lastModfyDate时间差
    NSTimeInterval sub = [[NSDate date] timeIntervalSinceDate:lastModfyDate];
    if (sub < 0) {
        sub = -sub;
    }
    //比较是否超时
    if (sub > timeOut) {
        //如果时间差 大于 设置的超时时间 那么就表示超时
        return YES;
    }
    return NO;
}
/*
 *  document根文件夹
 */
+(NSString *)documentFolder{
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}



/*
 *  caches根文件夹
 */
+(NSString *)cachesFolder{
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
/**
 *  查看文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 文件大小
 */
+(unsigned long long)getFilesSizeWithFilePath:(NSString*)filePath{
    //获取文件的属性
    NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    unsigned long long fileSize = [fileDict fileSize];
    return fileSize;
    
}

//Tmp
/**
 *  Tmp根文件夹
 *
 *  @return Tmp根文件夹
 */
+(NSString*)tmpFolder{
    return NSTemporaryDirectory();
    
}
/**
 *  删除Mycaches
 *
 *  @return 删除Mycaches
 */
+(BOOL)removeAllMyCaches{
    NSString*docPath = [Factory cachesFolder];
    NSString *myCacheDirectory = [docPath stringByAppendingPathComponent:@"MyCaches"];
    NSFileManager*fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:myCacheDirectory error:NULL];
    
    
    
}
/**
 *  删除MyDocuments
 *
 *  @return 删除MyDocuments
 */
+(BOOL)removeAllMyDocuments{
    NSString*docPath = [Factory documentFolder];
    NSString *myCacheDirectory = [docPath stringByAppendingPathComponent:@"MyDocuments"];
    NSFileManager*fileManager = [NSFileManager defaultManager];
    return  [fileManager removeItemAtPath:myCacheDirectory error:NULL];
    
}
/**
 *  删除MyDocuments某个文件
 *
 *  @return 删除MyDocuments
 */
+(BOOL)removeMyDocumentsWith:(NSString*)file{
    NSString*docPath = [Factory documentFolder];
    NSString *myCacheDirectory = [[docPath stringByAppendingPathComponent:@"MyDocuments"] stringByAppendingPathComponent:file];
    NSFileManager*fileManager = [NSFileManager defaultManager];
    return  [fileManager removeItemAtPath:myCacheDirectory error:NULL];
}
/**
 *  删除MyTmp
 *
 *  @return 删除MyTmp
 */
+(BOOL)removeAllMyTmp{
    NSString*docPath = [Factory tmpFolder];
    NSString *myCacheDirectory = [docPath stringByAppendingPathComponent:@"MyTmp"];
    NSFileManager*fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:myCacheDirectory error:NULL];
    
}
@end
@implementation Factory (JKUserDefault)
#pragma mark -Factory (JKUserDefault)
//保存普通对象
+(void)setUserDefoultWithStr:(NSString *)str forkey:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    
    [defaults setObject:str forKey:key];
    
    
    //立即同步
    [defaults synchronize];
    
}

//读取
+(NSString *)readUserDefoultWithstrForKey:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    NSString *str=(NSString *)[defaults objectForKey:key];
    
    return str;
    
}

//删除
+(void)removeUserDefoultValueForKey:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    //立即同步
    [defaults synchronize];
    
}

//保存int
+(void)setUserDefoultWithInt:(NSInteger)i forkey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setInteger:i forKey:key];
    
    //立即同步
    [defaults synchronize];
    
}

//读取
+(NSInteger)readUserDefoultWithintForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    NSInteger i=[defaults integerForKey:key];
    
    return i;
}

//保存float
+(void)setUserDefoultWithFloat:(CGFloat)floatValue forkey:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setFloat:floatValue forKey:key];
    
    //立即同步
    [defaults synchronize];
    
}
//读取
+(CGFloat)readUserDefoultWithfloatForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    CGFloat floatValue=[defaults floatForKey:key];
    
    return floatValue;
}


//保存bool
+(void)setUserDefoultWithBool:(BOOL)boolValue forkey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setBool:boolValue forKey:key];
    
    //立即同步
    [defaults synchronize];
    
}
//读取
+(BOOL)readUserDefoultWithboolForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    BOOL boolValue=[defaults boolForKey:key];
    
    return boolValue;
}

@end
@implementation Factory (JKPredicate)
// 正则匹配手机号
+ (BOOL)checkMobileNumber:(NSString *) telNumber
{
    //    NSString *pattern = @"^((14[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString*pa = @"^(1[0-9])\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pa];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

// 正则匹配座机号
+ (BOOL)checkTelNumber:(NSString *) telNumber{
    
    NSString *pattern = @"^\\d{3}-\\d{8}|\\d{4}-\\d{7}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}
// 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

//正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z一-龥]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

//正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    if (isMatch) {
        
        //得到当前日期
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        NSString*data = [dateFormatter stringFromDate:today];
        NSString *birth = [idCard substringWithRange:NSMakeRange(6,8)];
        return ([[birth substringWithRange:NSMakeRange(0, 4)] integerValue]<=[[data substringWithRange:NSMakeRange(0, 4)] integerValue]&[[birth substringWithRange:NSMakeRange(4, 2)] integerValue]<=12&([[birth substringWithRange:NSMakeRange(6, 2)] integerValue]<=31));
        
        
    }
    
    return isMatch;
}

// 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber: (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

// 正则匹配URL
+ (BOOL)checkURL: (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}
//正则匹配港澳通行证 Hong Kong-Macau laissez-passer
+ (BOOL)checkLaissezPasser: (NSString *) number
{
    NSString *pattern = @"^[HMhm]{1}([0-9]{10}|[0-9]{8})$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}
//正则匹配军官证 military ID
+ (BOOL)checkMilitaryID: (NSString *) number
{
    NSString *pattern = @"^南字第(\\d{8})号|北字第(\\d{8})号|沈字第(\\d{8})号|兰字第(\\d{8})号|成字第(\\d{8})号|济字第(\\d{8})号|广字第(\\d{8})号|海字第(\\d{8})号|空字第(\\d{8})号|参字第(\\d{8})号|政字第(\\d{8})号|后字第(\\d{8})号|装字第(\\d{8})号$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

//正则匹配护照 passport
+ (BOOL)checkPassport: (NSString *) number
{
    NSString *pattern = @"(^[a-zA-Z]{5,17}$)|(^[a-zA-Z0-9]{5,17}$)";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}
//正则匹配台胞证 MTPs
+ (BOOL)checkMTPs: (NSString *) number{
    
    NSString *pattern = @"(^[0,9]{10}(B)$)|(^[0,9]{8}$)";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}
// 正则匹配邮箱
+ (BOOL)checkEmail: (NSString *) number{
    NSString *pattern = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}
//正则匹配邮编
+ (BOOL)checkPostcode: (NSString *) number{
    NSString *pattern = @"^[1-9][0-9]{5}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}
//正则匹配银行卡号
+ (BOOL)checkBankCardNum: (NSString *) number{
    NSString *pattern = @"^(\\d{16}|\\d{19})$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

@end



