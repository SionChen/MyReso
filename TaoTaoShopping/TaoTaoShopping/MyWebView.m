//
//  MyWebView.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/11.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "MyWebView.h"

@implementation MyWebView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        
        
        
        //网络请求类
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
        
        //把网络请求加载到webView
        [self loadRequest:request];
        
        //wv.scalesPageToFit = YES;
        
        self.allowsInlineMediaPlayback = NO;
        
        
        //添加到本类的View上
        
        NSArray *title = @[@"重载", @"停止", @"前进", @"后退"];
        
        for (int i = 0; i < 4; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:title[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [button setFrame:CGRectMake(20 + 60 * i + 10 * i , HEIGHT-60, 60, 40)];
            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:1000 + i];
            [self addSubview:button];
        }

        
        
    }
    
    return self;
}
- (void)onClick:(UIButton *)bt
{
    switch (bt.tag) {
        case 1000:
            //重载
            [self reload];
            break;
        case 1001:
            //停止
            [self stopLoading];
            break;
        case 1002:
            //前进
            [self goForward];
            break;
        case 1003:
            //后退
            [self goBack];
            break;
            
        default:
            break;
    }
}


@end
