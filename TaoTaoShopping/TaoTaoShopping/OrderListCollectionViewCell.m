//
//  OrderListCollectionViewCell.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/14.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "OrderListCollectionViewCell.h"

@implementation OrderListCollectionViewCell



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        //图片
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 140)];
        //self.imageView.backgroundColor = [UIColor greenColor];
        self.imageView.image = [UIImage imageNamed:@"upload"];
        [self.contentView addSubview:self.imageView];
        
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 143, frame.size.width-10, 10)];
        self.titleLabel.text = @"海蝶保温杯男女士真快不漏水";
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.titleLabel];
        
        //现价
        self.nowPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 163, 40, 10)];
        self.nowPriceLabel.font = [UIFont systemFontOfSize:12];
        self.nowPriceLabel.textColor = [UIColor redColor];
        self.nowPriceLabel.text = @"￥28.9";
        [self.contentView addSubview:self.nowPriceLabel];
        
        //原价
        self.orPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 163, 50, 10)];
        self.orPriceLabel.font = [UIFont systemFontOfSize:12];
        self.orPriceLabel.textColor = [UIColor lightGrayColor];;
        self.orPriceLabel.text = @"￥28.9";
        [self.contentView addSubview:self.orPriceLabel];
        //原价划线
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(45, 168, 50, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        
        //折扣
        self.discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 160, 30, 15)];
        self.discountLabel.backgroundColor = [UIColor greenColor];
        self.discountLabel.textColor = [UIColor whiteColor];
        self.discountLabel.font = [UIFont systemFontOfSize:12];
        self.discountLabel.text = @"1.0折";
        [self.contentView addSubview:self.discountLabel];
        
        //包邮
        UILabel * baoLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 160, 30, 15)];
        baoLabel.backgroundColor = [UIColor greenColor];
        baoLabel.textColor = [UIColor whiteColor];
        baoLabel.font = [UIFont systemFontOfSize:12];
        baoLabel.text = @"包邮";
        [self.contentView addSubview:baoLabel];
        
        //销量
        self.saleLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 180, frame.size.width-20, 10)];
        self.saleLabel.textColor = [UIColor lightGrayColor];
        self.saleLabel.font = [UIFont systemFontOfSize:12];
        self.saleLabel.text = @"已销12万";
        [self.contentView addSubview:self.saleLabel];
        
        
    }
    
    
    return self;
}

@end
