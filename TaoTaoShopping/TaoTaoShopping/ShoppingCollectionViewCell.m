//
//  ShoppingCollectionViewCell.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/14.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "ShoppingCollectionViewCell.h"

@implementation ShoppingCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-20)];
        //self.titleImageView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.titleImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-17, frame.size.width, 15)];
        self.titleLabel.text = @"保暖内衣";
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
        
        
        
    }
    
    return self;
}

@end
