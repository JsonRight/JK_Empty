//
//  UIScrollView+JK_Empty.h
//  HaoLyyPro
//
//  Created by 姜奎 on 2017/8/8.
//  Copyright © 2017年 jk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+JK.h"

@class JK_EmptyView;

@interface UIScrollView (JK_Empty)

@property(nonatomic, strong) UIView *jk_EmptyView;

@end
@interface JK_EmptyView : UIView

/**
 自定义空白占位视图

 @param block block中创建想要的占位视图
 @return 返回创建的占位视图
 */
+(UIView*)createEmpty:(UIView*(^)(void))block;

/**
 默认样式占位视图

 @param imageName 图片名称
 @param title 图片下方显示文字
 @return 返回创建的占位视图
 */
+(UIView*)createNormelEmptyViewWith:(NSString*)imageName title:(NSString*)title;
@end
