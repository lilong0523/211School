//
//  posionModel.m
//  zph
//
//  Created by 李龙 on 2016/12/25.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "posionModel.h"

@implementation posionModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [posionModel new];
    if (self) {
        self.P_posionName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"job_name"]];
        self.P_date = [NSString stringWithFormat:@"%@",[dic objectForKey:@"add_time"]];
        self.P_salary = [NSString stringWithFormat:@"%@",[dic objectForKey:@"money"]];
        self.NET_ID =[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    }
    return self;
}


@end
