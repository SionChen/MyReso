//
//  HomeCustomHeaderView.h
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/10.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesScrollView.h"

@interface HomeCustomHeaderView : UICollectionReusableView

//装载control的数组
@property (nonatomic,strong)NSArray * urlArray;


@property (nonatomic,strong)void(^block)(NSInteger index);

@property (nonatomic,strong)ImagesScrollView * scrollView;

//重载此方法是因为调用了registerClass:forHeaderFooterViewReuseIdentifier:调用了这个方法会自动掉用此初始化方法
//- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
-(instancetype)initWithFrame:(CGRect)frame;


@end
