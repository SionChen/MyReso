//
//  ViewController.m
//  yaoyiyao
//
//  Created by 晓 on 15/12/31.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    //我擦泪
    
    
}


- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    NSLog(@"摇一摇");
    //检测到摇动
    
}



- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    NSLog(@"摇动取消");
    
    //摇动取消
    
}



- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动结束
    NSLog(@"摇动结束");
    
    if (event.subtype == UIEventSubtypeMotionShake) {
        
        //something happens
        NSLog(@"这是什么玩意");
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
