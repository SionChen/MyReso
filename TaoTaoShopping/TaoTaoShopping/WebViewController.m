//
//  WebViewController.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/11.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "WebViewController.h"
#import <ShareSDK/ShareSDK.h>
@interface WebViewController ()<UIWebViewDelegate,UIActionSheetDelegate>

@end

@implementation WebViewController
{
    UIWebView * _webView;
    
    //菊花
    UIActivityIndicatorView * _indicator;
    
    NSString * _urlString;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back1"] style:UIBarButtonItemStylePlain target:self action:@selector(barBackButton)];
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 10);

    
    __weak typeof(self)_weak = self;
    _weak.block = ^(NSString * title){
        _weak.navigationItem.title = title;
        
    };
    //菊花
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.frame = CGRectMake(0, 0, 30, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_indicator];
        
    
    
}
-(void)createButton
{
    NSArray * imageArr = @[@"back_icon",@"forward_icon",@"reload_icon",@"share"];
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-64-49, WIDTH, 49)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    for (int i = 0; i<4; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(((WIDTH-160)/5)*(i+1)+i*40, 5, 40, 40);
        [button setImage:[UIImage imageNamed:[imageArr objectAtIndex:i]] forState:UIControlStateNormal];
        button.tag = 200+i;
        [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
        
        [bgView addSubview:button];
        
        
    }
    
    
    
}
-(void)button:(UIButton *)btn
{
    
    UIActionSheet * ac = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪分享",@"分享给微信好友", nil];
    [self.view addSubview:ac];
    switch (btn.tag) {
        case 200:
            //后退
            [_webView goBack];
            break;
        case 201:
            //前进
            [_webView goForward];
            break;
        case 202:
            //重载
            [_webView reload];
            break;
        case 203:
            //分享
            [ac showInView:self.view];
            
            break;
            
        default:
            break;
    }
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"我看着不错你也来看看 @value(url)"
                                     images:nil
                                        url:[NSURL URLWithString:_urlString]
                                      title:@"我发现了好东西你也赶快来看看吧"
                                       type:SSDKContentTypeAuto];

    NSLog(@"%d",buttonIndex);
    switch (buttonIndex) {
        case 0:
            
            //进行分享
            //新浪微博分享
            [ShareSDK share:SSDKPlatformTypeSinaWeibo
                 parameters:shareParams
             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                 
                 switch (state) {
                     case SSDKResponseStateSuccess:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     case SSDKResponseStateFail:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                             message:[NSString stringWithFormat:@"%@", error]
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     case SSDKResponseStateCancel:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     default:
                         break;
                 }
                 
             }];

            break;
        case 1:
            //微信分享
            [ShareSDK share:SSDKPlatformTypeWechat
                 parameters:shareParams
             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                 
                 switch (state) {
                     case SSDKResponseStateSuccess:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     case SSDKResponseStateFail:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                             message:[NSString stringWithFormat:@"%@", error]
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     case SSDKResponseStateCancel:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     default:
                         break;
                 }
                 
             }];

            
            break;
            
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithUrlString:(NSString *)urlString
{
    if (self = [super init]) {
        
        //self.text = [NSString string];
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-63)];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        NSLog(@"%@",urlString);
        //把网络请求加载到webView
        [_webView loadRequest:request];
        _urlString = urlString;
        self.tabBarController.tabBar.hidden = NO;
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
        _webView.allowsInlineMediaPlayback = NO;
        [self.view addSubview:_webView];
        [self createButton];


        //self.navigationController.navigationBar.tintColor = [UIColor clearColor];
        
    }
    
    
    return self;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    [_indicator stopAnimating];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
    [_indicator startAnimating];
}

-(void)barBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
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
