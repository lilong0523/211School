//
//  ConferenceModel.h
//  zph
//
//  Created by 李龙 on 2017/1/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConferenceModel : NSObject

@property (strong, nonatomic) NSString *CompanyName;//公司名
@property (strong, nonatomic) NSString *status;//面试状态
@property (strong, nonatomic) NSString *JobId;//id

@property (strong, nonatomic) NSMutableArray *jobArry;//工作数组
- (id)initWithDic:(NSDictionary *)dic;

@end
