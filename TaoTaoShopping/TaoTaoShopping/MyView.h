//
//  MyView.h
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/13.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)(NSInteger index);
@interface MyView : UIView

@property (nonatomic,strong)Block block;

@end
