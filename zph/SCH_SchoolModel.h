//
//  SCH_SchoolModel.h
//  zph
//
//  Created by 李龙 on 2016/12/27.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCH_SchoolModel : NSObject

@property (nonatomic, strong) NSString *NET_logo;//招聘会logo
@property (nonatomic, strong) NSString *NET_Name;//招聘会名称
@property (nonatomic, strong) NSString *NET_companyNum;//入展企业数
@property (nonatomic, strong) NSString *NET_Dete;//日期
@property (nonatomic, strong) NSString *NET_ID;//主键
@property (nonatomic, strong) NSString *NET_jobId;//招聘会id


- (id)initWithDic:(NSDictionary *)dic;

@end
