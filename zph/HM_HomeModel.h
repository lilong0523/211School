//
//  HM_HomeModel.h
//  zph
//
//  Created by 李龙 on 2016/12/22.
//  Copyright © 2016年 李龙. All rights reserved.
//

//招聘职位model
#import <Foundation/Foundation.h>

@interface HM_HomeModel : NSObject

@property (nonatomic, strong) NSString *M_logo;//公司logo
@property (nonatomic, strong) NSString *M_Nologo;//没有图片显示的默认图片
@property (nonatomic, strong) NSString *M_jobId;//职位id
@property (nonatomic, strong) NSString *M_jobName;//职位名
@property (nonatomic, strong) NSString *M_salary;//职位薪资
@property (nonatomic, strong) NSString *M_company;//公司名
@property (nonatomic, strong) NSString *M_careerFair;//招聘展会数
@property (nonatomic, strong) NSString *M_address;//展会地点

@property (nonatomic, strong) NSString *M_RN;//rownum
@property (nonatomic, strong) NSString *M_ID;//主键


- (id)initWithDic:(NSDictionary *)dic;

@end
