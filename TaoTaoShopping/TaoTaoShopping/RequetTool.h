//
//  RequetTool.h
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/10.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol RequestDelegate <NSObject>

@required
-(void)getDataWithDictionary:(NSDictionary *)dataDict andName:(NSString *)name;

@end


@interface RequetTool : NSObject





#pragma mark 请求代理
@property(nonatomic,assign) id<RequestDelegate> delegate;

-(void)requestWithUrlString:(NSString *)urlString andName:(NSString *)name;
-(void)postWithUrlString:(NSString *)urlString withParams:(NSDictionary *)paramsDict andName:(NSString *)name;

@end
