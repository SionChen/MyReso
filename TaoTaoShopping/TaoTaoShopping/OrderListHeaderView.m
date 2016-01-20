//
//  OrderListHeaderView.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/14.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "OrderListHeaderView.h"

@implementation OrderListHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

{
    BOOL _isClik;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.backImageView.image = [UIImage imageNamed:@"moods_btn"];
        [self addSubview:self.backImageView];
        NSInteger myWidth = frame.size.width;
        for (int i = 0; i<4; i++) {
            UIControl * control = [[UIControl alloc] initWithFrame:CGRectMake(i*(myWidth/4), 0, myWidth/4, frame.size.height)];
            [control addTarget:self action:@selector(Control:) forControlEvents:UIControlEventTouchUpInside];
            control.tag = 100+i;
            [self addSubview:control];
        }
        //self.backgroundColor = [UIColor redColor];
        
        
    }
    
    return self;
}
-(void)Control:(UIControl *)control
{
    //NSLog(@"%d",control.tag);
    
    switch (control.tag-100) {
        case 0:
            _isClik = NO;
            self.backImageView.image = [UIImage imageNamed:@"moods_btn"];
            break;
        case 1:
            _isClik = NO;
            self.backImageView.image = [UIImage imageNamed:@"sale_btn"];
            break;
        case 2:
            if (_isClik) {
                self.backImageView.image = [UIImage imageNamed:@"price_down_btn"];
                _isClik = NO;
            }else
            {
                _isClik = YES;
                self.backImageView.image = [UIImage imageNamed:@"price_btn"];
            }
            
            break;
        default:
            break;
    }
    
    self.block(control.tag-100,_isClik);
    
}

@end
