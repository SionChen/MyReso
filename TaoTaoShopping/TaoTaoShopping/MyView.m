//
//  MyView.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/13.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "MyView.h"



typedef void(^Block)(NSInteger index);
@implementation MyView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
{
    Block _block;
    UIView * _barView;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSArray * titles = @[@"推荐", @"女孩", @"美妆", @"数码",@"居家",@"零食",@"男孩",@"创意"];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imageView.image = [UIImage imageNamed:@"tabbar_bg_HD"];
        [self addSubview:imageView];
        for (NSInteger i = 0; i < 8; i++) {
            [self addBtnWithTitle:titles[i] target:self action:@selector(btnClicked:) frame:CGRectMake(0, i*(frame.size.height/8), frame.size.width, frame.size.height/8) tag:i + 100];
        }
        
        
        _barView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width, 13, 1, 30)];
        _barView.backgroundColor = [UIColor redColor];
        [self addSubview:_barView];
    }
    
    
    return self;
}
- (void)btnClicked:(UIButton *)btn {
    
    btn.selected = YES;
    CGPoint center = _barView.center;
    center.y = btn.center.y;
    if (btn.selected) {
        for (int i= 0; i<8; i++) {
            if (btn.tag-100==i) {
                
            }else
            {
                UIButton *button = [self viewWithTag:i+100];
                button.selected = NO;
            }
            
            
        }

    }
    
    [UIView animateWithDuration:0.5 animations:^{
        _barView.center = center;
    }];
    
    NSInteger index = btn.tag - 100;
    // 调用block运行
    if (self.block) {
        self.block(index);
    }
}

- (void)addBtnWithTitle:(NSString *)title target:(id)target action:(SEL)action frame:(CGRect)frame tag:(NSInteger)tag {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = frame;
    btn.tag = tag;
    if (tag == 100) {
        btn.selected = YES;
    }
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self addSubview:btn];
}


@end
