//
//  ShoppingCollectionReusableView.h
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/14.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShoppingCollectionReusableView : UICollectionReusableView


@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)void(^tempBlock)(void);



@end
