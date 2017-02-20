//
//  HM_HomeModel.m
//  zph
//
//  Created by 李龙 on 2016/12/22.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "HM_HomeModel.h"

@implementation HM_HomeModel


- (id)initWithDic:(NSDictionary *)dic{
    self = [HM_HomeModel new];
    if (self) {
        self.M_logo = [NSString stringWithFormat:@"%@%@",IMAGEUPLOAD,[dic objectForKey:@"company_logo"]];
        self.M_Nologo = [[dic objectForKey:@"industry"] isEqualToString:@""]?@"big0":[dic objectForKey:@"industry"];
        self.M_salary = [dic objectForKey:@"money"];
        self.M_address = [dic objectForKey:@"areas"];
        self.M_company = [dic objectForKey:@"company_name"];
        self.M_jobName = [dic objectForKey:@"job_name"];
        self.M_careerFair = [dic objectForKey:@"jobfair_number"];
        self.M_jobId = [dic objectForKey:@"job_id"];
        self.M_RN = [dic objectForKey:@"rn"];
        self.M_ID = [dic objectForKey:@"id"];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
