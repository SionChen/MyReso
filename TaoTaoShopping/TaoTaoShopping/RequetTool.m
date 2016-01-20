//
//  RequetTool.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/10.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "RequetTool.h"
#import <AFNetworking.h>

@implementation RequetTool


- (AFHTTPRequestOperationManager *)manager {
    
    static AFHTTPRequestOperationManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPRequestOperationManager manager];
    });
    
    return manager;
}


#pragma mark 请求方法
-(void)requestWithUrlString:(NSString *)urlString andName:(NSString *)name
{
    
    AFHTTPRequestOperationManager * manager = self.manager;
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    /*
    // 设置共享网络状态监视事件
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                
                manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
                NSLog(@"无网络");
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
                NSLog(@"3G/4G网络");
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
                NSLog(@"Wifi网络");
                
                break;
                
            default:
                break;
        }
        
    }];
    
    // 启动共享网络状态监视
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    */
    
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //NSLog(@"成功 dataDict:%@",responseObject);
        
        if ([self.delegate respondsToSelector:@selector(getDataWithDictionary:andName:)]) {
            [self.delegate getDataWithDictionary:responseObject andName:name];
        }
    
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"失败：%@",error);
        // 当没有网络时
        if (error.code == -1009) {
            self.manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
            
            [self requestWithUrlString:urlString andName:name];
        }
        if ([self.delegate respondsToSelector:@selector(getDataWithDictionary:andName:)]) {
            [self.delegate getDataWithDictionary:nil andName:name];
        };
        
    }];
    NSLog(@"name:%@",name);
    NSLog(@"%@",NSHomeDirectory());
}
-(void)postWithUrlString:(NSString *)urlString withParams:(NSDictionary *)paramsDict andName:(NSString *)name
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager POST:urlString parameters:paramsDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       // NSLog(@"成功 dataDict:%@",responseObject);
        
        if ([self.delegate respondsToSelector:@selector(getDataWithDictionary:andName:)]) {
            [self.delegate getDataWithDictionary:responseObject andName:name];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"失败：%@",error);
        if ([self.delegate respondsToSelector:@selector(getDataWithDictionary:andName:)]) {
            [self.delegate getDataWithDictionary:nil andName:name];
        };
        
    }];
    NSLog(@"name:%@",name);
}

@end
