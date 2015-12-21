//
//  PersonalCenterViewController.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/10.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "WebViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface PersonalCenterViewController ()

@end

@implementation PersonalCenterViewController


-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
    
    
    self.view.backgroundColor = PLColor(235, 235, 241);
    [self createUI];
}

//三方登录，新浪
-(void)rightBarButtonClick
{
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

-(void)createUI
{
    //个人中心背景图
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
    bgImageView.image = [UIImage imageNamed:@"userbg"];
    [self.view addSubview:bgImageView];
    
    
    //登录按钮
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake((WIDTH-110)/2, 0, 110, 180);
    loginButton.backgroundColor = [UIColor clearColor];
    loginButton.titleLabel.numberOfLines = 2;
    loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginButton setTitle:@"淘淘购欢迎您\n    点此登录" forState:UIControlStateNormal];
    loginButton.tag = 100;
    [loginButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    //收藏、我的宝贝、手机充值按钮
    
    NSArray * NormalArr = @[@"collect_selected",@"mine_selected",@"history"];
    NSArray * selectArr = @[@"collect_selected",@"mine_btn_click",@"history_selected"];
    
    //按钮底层图
    UIView * baView = [[UIView alloc] initWithFrame:CGRectMake(0, 130, WIDTH, 50)];
    baView.backgroundColor = [UIColor whiteColor];
    baView.alpha = 0.7;
    [self.view addSubview:baView];
    for (int i = 0; i<3; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(WIDTH/3), 130, WIDTH/3, 50);
        [button setImage:[UIImage imageNamed:[NormalArr objectAtIndex:i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[selectArr objectAtIndex:i]] forState:UIControlStateSelected];
        [self.view addSubview:button];
        button.tag = 1000+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(i*(WIDTH/3), 135, 1, 40)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:lineView];
        
    }
    
    //收藏下面的按钮
    UIButton * likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame =CGRectMake((WIDTH-225)/2, 180, 225, 150);
    [likeButton setImage:[UIImage imageNamed:@"me_info_like"] forState:UIControlStateNormal];
    likeButton.tag =101;
    [likeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeButton];
    
    
    
}

-(void)buttonClick:(UIButton *)button
{
    if (button.tag == 101) {
        self.tabBarController.selectedIndex = 0;
    }else if (button.tag == 1001)
    {
        WebViewController * wvc = [[WebViewController alloc] initWithUrlString:@"https://login.m.taobao.com/login.htm?tpl_redirect_url=http%3A%2F%2Fh5.m.taobao.com%2Fmlapp%2Fmytaobao.html%23mlapp-mytaobao"];
        wvc.block(@"我的宝贝");
        [self.navigationController pushViewController:wvc animated:YES];
    }else if (button.tag == 1002)
    {
        WebViewController * wvc = [[WebViewController alloc] initWithUrlString:@"http://h5.m.taobao.com/app/cz/cost.html?ttid=400000_21170841@suishengou_iPhone_1.0"];
        wvc.block(@"手机充值");
        [self.navigationController pushViewController:wvc animated:YES];
        
    }else if (button.tag == 100)
    {
        WebViewController * wvc = [[WebViewController alloc] initWithUrlString:@"https://login.m.taobao.com/login.htm?tpl_redirect_url=http%3A%2F%2Fh5.m.taobao.com%2Fmlapp%2Fmytaobao.html%23mlapp-mytaobao"];
        wvc.block(@"我的宝贝");
        [self.navigationController pushViewController:wvc animated:YES];
    }
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
