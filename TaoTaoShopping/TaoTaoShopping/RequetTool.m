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





#pragma mark 请求方法
-(void)requestWithUrlString:(NSString *)urlString andName:(NSString *)name
{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"成功 dataDict:%@",responseObject);
        
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
