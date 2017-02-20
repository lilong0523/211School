//
//  SCH_SchoolModel.m
//  zph
//
//  Created by 李龙 on 2016/12/27.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "SCH_SchoolModel.h"

@implementation SCH_SchoolModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [SCH_SchoolModel new];
    if (self) {
        self.NET_logo = [dic objectForKey:@"logo_path"];
        self.NET_Name = [dic objectForKey:@"job_fair_name"];
 
        self.NET_companyNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"company_num"]];
        self.NET_Dete = [NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"job_fair_time"],[dic objectForKey:@"job_fair_overtime"]];
        self.NET_jobId = [dic objectForKey:@"job_fair_id"];
        self.NET_ID =[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}



@end
