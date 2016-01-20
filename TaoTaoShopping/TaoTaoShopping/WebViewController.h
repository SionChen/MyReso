//
//  WebViewController.h
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/11.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController


-(instancetype)initWithUrlString:(NSString *)urlString;

@property (nonatomic,assign)BOOL isDrawer;


@property (nonatomic,strong)void(^block)(NSString *);

@end
