//
//  NET_recruitModel.m
//  zph
//
//  Created by 李龙 on 2016/12/26.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "NET_recruitModel.h"

@implementation NET_recruitModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [NET_recruitModel new];
    if (self) {
        self.NET_logo = [dic objectForKey:@"poster_path"];
        self.NET_Name = [dic objectForKey:@"job_fair_name"];
        self.NET_Statu = [dic objectForKey:@"begin"];
        if (![[dic objectForKey:@"job_fair_feature"] isEqualToString:@""]) {
            [self.NET_label addObject:[dic objectForKey:@"job_fair_feature"]];
        }
        if (![[dic objectForKey:@"job_fair_level"] isEqualToString:@""]) {
            [self.NET_label addObject:[dic objectForKey:@"job_fair_level"]];
        }
        
       
        self.NET_companyNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"company_num"]];
        self.NET_Dete = [NSString stringWithFormat:@"%@到%@",[dic objectForKey:@"job_fair_time"],[dic objectForKey:@"job_fair_overtime"]];
        self.NET_Id = [dic objectForKey:@"job_fair_id"];
        self.NET_RN =[NSString stringWithFormat:@"%@",[dic objectForKey:@"rn"]];
        self.NET_ID =[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

- (NSMutableArray *)NET_label{
    if (_NET_label == nil) {
        _NET_label = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _NET_label;
}

@end
