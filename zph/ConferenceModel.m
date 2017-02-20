//
//  ConferenceModel.m
//  zph
//
//  Created by 李龙 on 2017/1/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "ConferenceModel.h"

@implementation ConferenceModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [ConferenceModel new];
    if (self) {
        self.CompanyName = [dic objectForKey:@"company_name"];
        self.JobId = [dic objectForKey:@"id"];
        self.status = [dic objectForKey:@"status"];
        if ([dic objectForKey:@"jobs"]) {
            self.jobArry = [dic objectForKey:@"jobs"];
        }
        
    }
    return self;
}

- (NSMutableArray *)jobArry{
    if (_jobArry == nil) {
        _jobArry = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _jobArry;
}

@end
