//
//  HomeCustomCollectionViewCell.h
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/11.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCustomCollectionViewCell : UICollectionViewCell




//商品图片
@property (nonatomic,strong)UIImageView * titleImageView;

//原价格
@property (nonatomic,strong)UILabel * orPriceLabel;

//现价
@property (nonatomic,strong)UILabel * nowPriceLabel;

//价格背景图
@property (nonatomic,strong)UIView * priceBackgroundView;

//简介
@property (nonatomic,strong)UILabel * mainLabel;

//收藏
@property (nonatomic,strong)UIButton * collectButton;

//看相似
@property (nonatomic,strong)UIButton * similarButton;

@end
