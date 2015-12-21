//
//  HomeCustomCollectionViewCell.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/11.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "HomeCustomCollectionViewCell.h"

@implementation HomeCustomCollectionViewCell



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"goods11_bg"]];
        //商品图片
        self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, (WIDTH-15)/2-6, 139)];
        //self.titleImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.titleImageView];
        
        
        //价格背景图片
        self.priceBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(1, 120, (WIDTH-15)/2-57, 20)];
        self.priceBackgroundView.backgroundColor = [UIColor whiteColor];
        self.priceBackgroundView.alpha = 0.7;
        self.priceBackgroundView.layer.cornerRadius = 10;
        self.priceBackgroundView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.priceBackgroundView.layer.borderWidth = 1;
        self.priceBackgroundView.layer.masksToBounds = YES;

        [self.contentView addSubview:self.priceBackgroundView];
        
        //原价格
        self.orPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 120, (WIDTH-15)/2-117, 20)];
        self.orPriceLabel.textColor = [UIColor lightGrayColor];
        self.orPriceLabel.text = @"￥120";
        self.orPriceLabel.font = [UIFont systemFontOfSize:12];
        //划线
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(60, 130,(WIDTH-15)/2-117 , 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        
        [self.contentView addSubview:self.orPriceLabel];
        
        //现价
        self.nowPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 120, 50, 20)];
        self.nowPriceLabel.textColor = [UIColor redColor];
        self.nowPriceLabel.text = @"￥110";
        self.nowPriceLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.nowPriceLabel];
        
        //简介
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 137, (WIDTH-15)/2-17, 40)];
        self.mainLabel.numberOfLines = 2;
        self.mainLabel.textColor = [UIColor grayColor];
        self.mainLabel.font = [UIFont systemFontOfSize:12];
        self.mainLabel.text = @"[1.5折]带护腕usb暖手鼠标垫 冬天保暖 加厚";
        [self.contentView addSubview:self.mainLabel];
        
        //收藏按钮
        self.collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.collectButton.frame = CGRectMake(10, 173, 30, 30);
        [self.collectButton setBackgroundImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        [self.collectButton setBackgroundImage:[UIImage imageNamed:@"fullheart"] forState:UIControlStateSelected];
        [self.collectButton setTitle:@"50" forState:UIControlStateNormal];
        [self.collectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.collectButton.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, -25);
        self.collectButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.collectButton addTarget:self action:@selector(collectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.collectButton];
        
        //找相似
        self.similarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.similarButton.frame = CGRectMake(70, 175, 25, 25);
        [self.similarButton setBackgroundImage:[UIImage imageNamed:@"list_icon_link"] forState:UIControlStateNormal];
        [self.similarButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.similarButton setTitle:@"看相似" forState:UIControlStateNormal];
        self.similarButton.titleLabel.font = [UIFont systemFontOfSize:12];
        self.similarButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -45);
        [self.contentView addSubview:self.similarButton];
        
        
    }
    
    
    return self;
}

-(void)collectButtonClick:(UIButton *)bt
{
    if (!bt.selected ) {
         [bt setTitle:[NSString stringWithFormat:@"%d",[bt.titleLabel.text integerValue]+1] forState:UIControlStateNormal];
    }
    
    bt.selected = YES;
}

@end
