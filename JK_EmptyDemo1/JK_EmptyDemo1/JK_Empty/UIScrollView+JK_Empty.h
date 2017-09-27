//
//  UIScrollView+JK_Empty.h
//  HaoLyyPro
//
//  Created by 姜奎 on 2017/8/8.
//  Copyright © 2017年 jk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKFactory.h"
@class JK_EmptyView;
@interface UIScrollView (JK_Empty)

@property(nonatomic,strong)UIView* jk_EmptyView;

@end
@interface JK_EmptyView : UIView
+(UIView*)createEmpty:(UIView*(^)(void))block;
+(UIView*)createNormelEmptyViewWith:(NSString*)imageName title:(NSString*)title;
@end
