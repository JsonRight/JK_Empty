//
//  UIView+JK.h
//  Factory
//
//  Created by jk on 16/2/4.
//  Copyright © 2016年 jk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JK)
/**
 *  width
 */
@property(nonatomic) CGFloat width;
/**
 *  height
 */
@property(nonatomic) CGFloat height;
/**
 *  top
 */
@property(nonatomic) CGFloat top;
/**
 *  left
 */
@property(nonatomic) CGFloat left;
/**
 *  bottom
 */
@property(nonatomic) CGFloat bottom;
/**
 *  right
 */
@property(nonatomic) CGFloat right;
/**
 *  centerX
 */
@property(nonatomic) CGFloat centerX;
/**
 *  centerY
 */
@property(nonatomic) CGFloat centerY;
/**
 *  origin
 */
@property(nonatomic) CGPoint origin;
/**
 *  size
 */
@property(nonatomic) CGSize size;

@end

typedef enum{
    
    //上
    UIViewBorderDirectTop=0,
    
    //左
    UIViewBorderDirectLeft,
    
    //下
    UIViewBorderDirectBottom,
    
    //右
    UIViewBorderDirectRight,
    
    
}UIViewBorderDirect;
@interface UIView (JKBounds)
/**
 *  添加边框：注给scrollView添加会出错
 *
 *  @param direct 方向
 *  @param color  颜色
 *  @param width  线宽
 */
-(void)addSingleBorder:(UIViewBorderDirect)direct color:(UIColor *)color width:(CGFloat)width;

/**
 *  添加边框:四边
 */
-(void)setBorder:(UIColor *)color width:(CGFloat)width;


/**
 *  //设置圆角
 *
 *  @param r //圆角半径
 */

-(void)setRadius:(CGFloat)r;
@end
