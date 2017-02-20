//
//  posionModel.h
//  zph
//
//  Created by 李龙 on 2016/12/25.
//  Copyright © 2016年 李龙. All rights reserved.
//

//职位cell数据model
#import <Foundation/Foundation.h>

@interface posionModel : NSObject

@property (nonatomic, strong) NSString *P_posionName;//职位名称
@property (nonatomic, strong) NSString *P_salary;//薪水
@property (nonatomic, strong) NSString *P_date;//日期
@property (nonatomic, strong) NSString *NET_ID;//主键

- (id)initWithDic:(NSDictionary *)dic;

@end
