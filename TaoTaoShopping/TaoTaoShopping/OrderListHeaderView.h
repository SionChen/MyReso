//
//  OrderListHeaderView.h
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/14.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListHeaderView : UIView


@property (nonatomic,strong)UIImageView * backImageView;

@property (nonatomic,strong)void(^block)(NSInteger index,BOOL isDown);

@end
