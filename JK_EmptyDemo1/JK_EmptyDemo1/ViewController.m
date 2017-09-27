//
//  ViewController.m
//  JK_EmptyDemo1
//
//  Created by 姜奎 on 2017/9/27.
//  Copyright © 2017年 jk. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+JK_Empty.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    { self.table.jk_EmptyView = [JK_EmptyView createEmpty:^UIView *{
        UIView * view=[[UIView alloc]initWithFrame:self.table.bounds];
        view.backgroundColor = [UIColor redColor];
        return view;
    }];}
    return;
    {//or
        self.table.jk_EmptyView = [JK_EmptyView createNormelEmptyViewWith:@"hehe" title:@""];

    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
