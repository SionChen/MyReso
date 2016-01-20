//
//  DrawerView.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/12.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "DrawerView.h"


@implementation DrawerView

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
        //self.backgroundColor = [UIColor redColor];
        self.urlArray = @[@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/all.png",@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/figure.png",@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/women.png",@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/man.png",@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/house.png",@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/baby.png",@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/shoe.png",@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/acc.png",@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/beauty.png",@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/food.png",@"http://app.api.yijia.com/tb99/iphone/images/newfenjiu/other.png"];
        self.nameArray = @[@"新品",@"数码",@"女装",@"男装",@"家居",@"辣妈",@"鞋包",@"配饰",@"美妆",@"美食",@"其他"];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 150, HEIGHT-64)];
        UIImageView * headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, 150, 65)];
        headerView.backgroundColor = PLColor(212, 94, 132);
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 30, 80, 20)];
        titleLabel.text = @"商品类目";
        titleLabel.textColor = [UIColor whiteColor];
        [headerView addSubview:titleLabel];
        [self addSubview:self.tableView];
        [self addSubview:headerView];

        
    }
    
    return self;
}

@end
