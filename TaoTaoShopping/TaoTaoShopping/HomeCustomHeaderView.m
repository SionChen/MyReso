//
//  HomeCustomHeaderView.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/10.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//Home界面的头视图

#import "HomeCustomHeaderView.h"
#import "HomeViewController.h"
#import <UIImageView+AFNetworking.h>


@implementation HomeCustomHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.scrollView = [[ImagesScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 90)];
        self.scrollView.backgroundColor = [UIColor lightGrayColor];
        self.scrollView.isLoop = YES;
        self.scrollView.showPageControl = YES;
        self.scrollView.autoScrollInterval = 3;
        [self addSubview:self.scrollView];
        
        //第二行按钮
        for (int i = 0; i<4; i++) {
            //第二行的按钮
            UIImageView * buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15+i*(WIDTH/4), 100, WIDTH/4-30, 20)];
            [buttonImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/btn%d@2x.png",i+1]]];
            UIControl * control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, WIDTH/4-30, 20)];
            [buttonImageView addSubview:control];
            control.tag = 1000+i;
            [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
            //按钮之间的间隔线
            UIImageView * separatorView = [[UIImageView alloc] initWithFrame:CGRectMake((i+1)*(WIDTH/4), 95, 0.6, 30)];
            separatorView.image = [UIImage imageNamed:@"line"];
            
            buttonImageView.userInteractionEnabled = YES;
            [self addSubview:separatorView];
            
            [self addSubview:buttonImageView];
            
        }
        
        //分割线
        
        UIImageView * separat = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, WIDTH, 0.6)];
        separat.image = [UIImage imageNamed:@"line"];
        
        [self addSubview:separat];
        
        
        //第三部分按钮
        
        //大家都在买
        UIImageView * allImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 150, WIDTH/3-20, 90)];
        [allImageView setImageWithURL:[NSURL URLWithString:@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/btn66@2x.png"]];
        UIControl * allControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, WIDTH/3-20, 90)];
        allControl.tag = 1004;
        [allControl addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
        [allImageView addSubview:allControl];
        allImageView.userInteractionEnabled =YES;
        [self addSubview:allImageView];
        
        
        //值得买
        UIImageView * valueImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/3+10, 150, WIDTH/3-20, 90)];
        [valueImageView setImageWithURL:[NSURL URLWithString:@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/btn55@2x.png"]];
        
        UIControl * valueControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, WIDTH/3-20, 90)];
        [valueImageView addSubview:valueControl];
        valueControl.tag = 1005;
        [valueControl addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
        valueImageView.userInteractionEnabled = YES;
        [self addSubview:valueImageView];
        
        //明日抢
        UIImageView * tomrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(((WIDTH/3)*2)-5, 150, WIDTH/3-10, 40)];
        [tomrImageView setImageWithURL:[NSURL URLWithString:@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/btn77@2x.png"]];
        UIControl * tomControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, WIDTH/3-10, 40)];
        tomControl.tag = 1006;
        [tomControl addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
        [tomrImageView addSubview:tomControl];
        tomrImageView.userInteractionEnabled = YES;
        [self addSubview:tomrImageView];
        
        //试试手气
        UIImageView * tryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(((WIDTH/3)*2)-5, 200, WIDTH/3-10, 40)];
        [tryImageView setImageWithURL:[NSURL URLWithString:@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/btn88@2x.png"]];
        UIControl * tryControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0,WIDTH/3-10, 40)];
        tryControl.tag = 1007;
        [tryControl addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
        [tryImageView addSubview:tryControl];
        tryImageView.userInteractionEnabled = YES;
        
        [self addSubview:tryImageView];
        
        //分割线
        for (int i = 0; i<2; i++) {
            
            UIImageView * seView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/3*(i+1)-10, 145, 1, 95)];
            seView.image = [UIImage imageNamed:@"line"];
            
            [self addSubview:seView];
        }
        
        UIImageView * hView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/3*2-10, 195, WIDTH/3+10, 1)];
        hView.image = [UIImage imageNamed:@"line"];
        
        
        [self addSubview:hView];
        
        UIImageView * lastSeparator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 240, WIDTH, 1)];
        lastSeparator.image = [UIImage imageNamed:@"line"];
        [self addSubview:lastSeparator];
        
        
        
        //获得url
        [self getUrlData];
        
        //新品推荐
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 243, 200, 15)];
        label.text = @"新品推荐";
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
        
    }
    
    
    return self;
}


-(void)controlClick:(UIControl *)control
{
    
    
    self.block(control.tag-1000);

}



-(void)getUrlData
{
    self.urlArray = @[@"http://cloud.repaiapp.com/yunying/miao.php?app_id=1066136336&target=present&app_oid=&app_version=&app_channel=appstore&sche=fenjiujiu",@"http://h5.m.taobao.com/app/cz/cost.html",@"http://zhekou.yijia.com/lws/view/yijia_shop.php?app_id=1066136336&sche=fenjiujiu",@"http://h5.m.taobao.com/cph5/home/h5/index.html?mode=hybrid",@"http://zhekou.repai.com/lws/model/paiming.php?lei=jkj",@"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=0",@"http://jkjby.yijia.com/jkjby/view/tomorrow_api.php?app_id=2402388976&app_oid=98a723d3f348b24c85251584250c379e586a851c&app_version=1.1&app_channel=appstore",@"limit/130/price_start/0/price_end/80/appkey/100022/app_id/2402388976"];
}


@end
