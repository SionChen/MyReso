//
//  TBController.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/10.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "TBController.h"
#import "NAController.h"
#import "FoundViewController.h"
#import "PersonalCenterViewController.h"
#import "ShoppingGoodsViewController.h"
#import "HomeViewController.h"
#import "ChannelViewController.h"
#import "CustomTabbarItem.h"

@interface TBController ()

@end

@implementation TBController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    NSArray * controllerArray = @[[HomeViewController class],[ShoppingGoodsViewController class],[FoundViewController class],[ChannelViewController class],[PersonalCenterViewController class]];
    NSArray * imageArray = @[@"nine",@"shopping",@"dongtai",@"zhuti",@"mine"];
    NSMutableArray * controllers = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        UIViewController * vc = [[controllerArray[i] alloc] init];
        NAController * nav = [[NAController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[CustomTabbarItem alloc] initWithTitle:nil image:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[i]]] selectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"gl%@",imageArray[i]]]];
        //推下一个也没的时候隐藏
        //vc.hidesBottomBarWhenPushed = YES;
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        [controllers addObject:nav];
        
    }
    self.viewControllers = controllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
