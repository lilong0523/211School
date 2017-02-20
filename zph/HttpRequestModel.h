//
//  NetWorkRtController.h
//  zph
//
//  Created by 李龙 on 2016/12/21.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequestModel : NSObject

@property (nonatomic, copy) void(^httpSuccessBlock)(NSMutableDictionary * dicData,NSInteger tag);
@property (nonatomic, copy) void(^httpSuccessArryBlock)(NSMutableArray * dicData,NSInteger tag);

@property (nonatomic, copy) void(^httpFieldBlock)(NSError *error);

- (void)postAsynRequestBody:(NSDictionary *)dicBody interfaceName:(NSString *)bizName interfaceTag:(NSInteger)tag parType:(NSInteger)type;
- (void)getHttpRequest:(id )dicBody interfaceName:(NSString *)bizName interfaceTag:(NSInteger)tag;

@end
