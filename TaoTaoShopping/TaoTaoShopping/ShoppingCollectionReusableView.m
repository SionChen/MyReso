//
//  ShoppingCollectionReusableView.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/14.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "ShoppingCollectionReusableView.h"

@implementation ShoppingCollectionReusableView


-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, frame.size.width-20, frame.size.height)];
        self.imageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView];
        
        UIControl * control =[[UIControl alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-20, frame.size.height)] ;
        
        [control addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
        
    }
    
    return self;
}
-(void)Click:(UIControl *)control
{
    self.tempBlock();
}

@end
