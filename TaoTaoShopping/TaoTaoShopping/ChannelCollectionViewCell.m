//
//  ChannelCollectionViewCell.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/15.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "ChannelCollectionViewCell.h"

@implementation ChannelCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //边框图片
        self.frameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 56, 56)];
        self.frameImageView.image = [UIImage imageNamed:@"frame"];
        [self.contentView addSubview:self.frameImageView];
        self.frameImageView.hidden = YES;
        
        
        self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 50, 50)];
        self.titleImageView.image = [UIImage imageNamed:@"upload"];
        //self.titleImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.titleImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 60, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.text = @"超值购";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
        //分割线
        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height, 56, 1)];
        //line.image = [UIImage imageNamed:@"line"];
        line.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:line];
        
        
    }
    
    
    return self;
}

@end
