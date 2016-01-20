//
//  OrderListCollectionViewCell.h
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/14.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * orPriceLabel;
@property (nonatomic,strong)UILabel * nowPriceLabel;
@property (nonatomic,strong)UILabel * discountLabel;
@property (nonatomic,strong)UILabel * saleLabel;

@end
