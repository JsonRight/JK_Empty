//
//  UIScrollView+JK_Empty.m
//  HaoLyyPro
//
//  Created by jk on 2017/8/8.
//  Copyright © 2017年 jk. All rights reserved.
//

#import "UIScrollView+JK_Empty.h"


#import <objc/runtime.h>
@implementation UIScrollView (JK_Empty)
#pragma mark - Method Swizzling



static NSMutableDictionary *_impLookupTable;
static NSString *const DZNSwizzleInfoPointerKey = @"pointer";
static NSString *const DZNSwizzleInfoOwnerKey = @"owner";
static NSString *const DZNSwizzleInfoSelectorKey = @"selector";


-(void)setJk_EmptyView:(UIView*)jk_EmptyView{
    objc_setAssociatedObject(self, @"jk_EmptyView", jk_EmptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self swizzleIfPossible:@selector(reloadData)];
    
    // Exclusively for UITableView, we also inject -dzn_reloadData to -endUpdates
    if ([self isKindOfClass:[UITableView class]]) {
        [self swizzleIfPossible:@selector(endUpdates)];
    }
}
-(UIView*)jk_EmptyView{
    return objc_getAssociatedObject(self, @"jk_EmptyView");
}
void jk_original_implementation(id self, SEL _cmd)
{
    // Fetch original implementation from lookup table
    Class baseClass = jk_baseClassToSwizzleForTarget(self);
    NSString *key = jk_implementationKey(baseClass, _cmd);
    
    NSDictionary *swizzleInfo = [_impLookupTable objectForKey:key];
    NSValue *impValue = [swizzleInfo valueForKey:DZNSwizzleInfoPointerKey];
    
    IMP impPointer = [impValue pointerValue];
    
    // We then inject the additional implementation for reloading the empty dataset
    // Doing it before calling the original implementation does update the 'isEmptyDataSetVisible' flag on time.
    [self jk_reloadEmptyDataSet];
    
    // If found, call original implementation
    if (impPointer) {
        ((void(*)(id,SEL))impPointer)(self,_cmd);
    }
}

NSString *jk_implementationKey(Class class, SEL selector)
{
    if (!class || !selector) {
        return nil;
    }
    
    NSString *className = NSStringFromClass([class class]);
    
    NSString *selectorName = NSStringFromSelector(selector);
    return [NSString stringWithFormat:@"%@_%@",className,selectorName];
}

Class jk_baseClassToSwizzleForTarget(id target)
{
    if ([target isKindOfClass:[UITableView class]]) {
        return [UITableView class];
    }
    else if ([target isKindOfClass:[UICollectionView class]]) {
        return [UICollectionView class];
    }
    else if ([target isKindOfClass:[UIScrollView class]]) {
        return [UIScrollView class];
    }
    
    return nil;
}

- (void)swizzleIfPossible:(SEL)selector
{
    // Check if the target responds to selector
    if (![self respondsToSelector:selector]) {
        return;
    }
    
    // Create the lookup table
    if (!_impLookupTable) {
        _impLookupTable = [[NSMutableDictionary alloc] initWithCapacity:3]; // 3 represent the supported base classes
    }
    
    // We make sure that setImplementation is called once per class kind, UITableView or UICollectionView.
    for (NSDictionary *info in [_impLookupTable allValues]) {
        Class class = [info objectForKey:DZNSwizzleInfoOwnerKey];
        NSString *selectorName = [info objectForKey:DZNSwizzleInfoSelectorKey];
        
        if ([selectorName isEqualToString:NSStringFromSelector(selector)]) {
            if ([self isKindOfClass:class]) {
                return;
            }
        }
    }
    
    Class baseClass = jk_baseClassToSwizzleForTarget(self);
    NSString *key = jk_implementationKey(baseClass, selector);
    NSValue *impValue = [[_impLookupTable objectForKey:key] valueForKey:DZNSwizzleInfoPointerKey];
    
    // If the implementation for this class already exist, skip!!
    if (impValue || !key || !baseClass) {
        return;
    }
    
    // Swizzle by injecting additional implementation
    Method method = class_getInstanceMethod(baseClass, selector);
    IMP dzn_newImplementation = method_setImplementation(method, (IMP)jk_original_implementation);
    
    // Store the new implementation in the lookup table
    NSDictionary *swizzledInfo = @{DZNSwizzleInfoOwnerKey: baseClass,
                                   DZNSwizzleInfoSelectorKey: NSStringFromSelector(selector),
                                   DZNSwizzleInfoPointerKey: [NSValue valueWithPointer:dzn_newImplementation]};
    
    [_impLookupTable setObject:swizzledInfo forKey:key];
}


- (NSInteger)jk_itemsCount
{
    NSInteger items = 0;
    

    // UITableView support
    if ([self isKindOfClass:[UITableView class]]) {
        
        UITableView *tableView = (UITableView *)self;
        id <UITableViewDataSource> dataSource = tableView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource tableView:tableView numberOfRowsInSection:section];
            }
        }
    }
    // UICollectionView support
    else if ([self isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *collectionView = (UICollectionView *)self;
        id <UICollectionViewDataSource> dataSource = collectionView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource collectionView:collectionView numberOfItemsInSection:section];
            }
        }
    }else{
       items= self.subviews.count;
    
    }
    return items;
}

#pragma mark - Reload APIs (Public)

- (void)reloadEmptyDataSet
{
    [self jk_reloadEmptyDataSet];
}


#pragma mark - Reload APIs (Private)

- (void)jk_reloadEmptyDataSet
{
    if ([self jk_itemsCount]==0) {
        
        [self insertSubview:self.jk_EmptyView atIndex:0];
        
    }else{
        if (self.jk_EmptyView) {
            
            [self.jk_EmptyView removeFromSuperview];
            
        }
    }
}


@end

@implementation JK_EmptyView

+(UIView *)createEmpty:(UIView *(^)(void))block{
    if (block) {
        return block();
    }else{
        return nil;
    }
}
+(UIView*)createNormelEmptyViewWith:(NSString*)imageName title:(NSString*)title {
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64-50)];
    UIImage* image=[UIImage imageNamed:imageName];
    CGSize size=image.size;
    UIImageView* imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    
    [view addSubview:imageView];
    imageView.frame=CGRectMake(0, 0, view.width*0.3, view.width*0.3*(size.height/size.width));
    imageView.centerX=view.centerX;
    imageView.centerY=view.centerY-imageView.height*0.5;
    
    
    UILabel* lab=[[UILabel alloc]init];
    lab.text= title;
    lab.textAlignment= NSTextAlignmentCenter;
    [lab setFont:[UIFont systemFontOfSize:14]];
    lab.textColor=[UIColor lightGrayColor];
    [view addSubview:lab];
    CGFloat height=[JK_EmptyView textHeightFromTextString:title width:[[UIScreen mainScreen] bounds].size.width fontSize:14];
    lab.frame= CGRectMake(0, imageView.bottom+30, view.width, height);
    
    
    return view;
}
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    //返回计算出的行高
    return rect.size.height;
}
@end

