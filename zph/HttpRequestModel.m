//
//  NetWorkRtController.h
//  zph
//
//  Created by 李龙 on 2016/12/21.
//  Copyright © 2016年 李龙. All rights reserved.
//
#import "HttpRequestModel.h"


@implementation HttpRequestModel
{
    NSInteger m_tag;
}

/**
 发送http请求
 
 @param dicBody 参数
 @param bizName 接口名
 @param tag tag
 @param type  1 json串  0字典
 */
- (void)postAsynRequestBody:(NSDictionary *)dicBody interfaceName:(NSString *)bizName interfaceTag:(NSInteger)tag parType:(NSInteger)type
{
    m_tag = tag;
    // 启动系统风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *domainStr = [NSString stringWithFormat:@"%@%@", INTERFACE_URL, bizName];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setTimeoutInterval:20];
    
    if (type == 1) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    NSLog(@"%@",((AppDelegate *)[[UIApplication sharedApplication] delegate]).userModel.token);
    [manager.requestSerializer setValue:@"myApiKeyc934e40eb43a9347f8bcb41526f23a30" forHTTPHeaderField:@"x-api-key"];
    [manager.requestSerializer setValue:@"Accept" forHTTPHeaderField:@"application/json"];
    [manager.requestSerializer setValue:((AppDelegate *)[[UIApplication sharedApplication] delegate]).userModel.token forHTTPHeaderField:@"Authorization"];
    [manager POST:domainStr parameters:dicBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask *operation, id responseObject){
        
        NSString *str1 = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str1);
        // 隐藏系统风火轮
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //json解析
        NSMutableDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"---获取到的json格式的字典--%@",resultDic);
        if (self.httpSuccessBlock) {
            self.httpSuccessBlock(resultDic,m_tag);
        }
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error){
        // 解析失败隐藏系统风火轮(可以打印error.userInfo查看错误信息)
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (self.httpFieldBlock) {
            self.httpFieldBlock(error);
        }
        
    }];
    
    
}

- (void)getHttpRequest:(id)dicBody interfaceName:(NSString *)bizName interfaceTag:(NSInteger)tag{
    m_tag = tag;
    // 启动系统风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    NSString *domainStr = [NSString stringWithFormat:@"%@%@", INTERFACE_URL, bizName];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:((AppDelegate *)[[UIApplication sharedApplication] delegate]).userModel.token forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setTimeoutInterval:20];
    
    [manager.requestSerializer setValue:@"myApiKeyc934e40eb43a9347f8bcb41526f23a30" forHTTPHeaderField:@"x-api-key"];
    
    //以get的形式提交，只需要将上面的请求地址给GET做参数就可以
    [manager GET:domainStr parameters:dicBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask *operation, id responseObject){
        
        // 隐藏系统风火轮
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //json解析
        NSMutableDictionary *resultDic;
        NSMutableArray *resultArry;
        NSError *error1;
        if ([[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error1] isKindOfClass:[NSArray class]]) {
            resultArry =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if (self.httpSuccessArryBlock) {
                self.httpSuccessArryBlock(resultArry,m_tag);
            }
        }
        else{
            resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error1];
            if (self.httpSuccessBlock) {
                self.httpSuccessBlock(resultDic,m_tag);
            }
        }
        
        
        NSLog(@"---获取到的json格式的字典--%@",resultDic);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error){
        
        // 解析失败隐藏系统风火轮(可以打印error.userInfo查看错误信息)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (self.httpFieldBlock) {
            self.httpFieldBlock(error);
        }
        
    }];
}


@end
