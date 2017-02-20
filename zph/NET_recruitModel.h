//
//  NET_recruitModel.h
//  zph
//
//  Created by 李龙 on 2016/12/26.
//  Copyright © 2016年 李龙. All rights reserved.
//
//网络招聘会cell model
#import <Foundation/Foundation.h>

@interface NET_recruitModel : NSObject


@property (nonatomic, strong) NSString *NET_logo;//招聘会logo
@property (nonatomic, strong) NSString *NET_Name;//招聘会名称
@property (nonatomic, strong) NSString *NET_Statu;//招聘会状态
@property (nonatomic, strong) NSMutableArray *NET_label;//标签数组
@property (nonatomic, strong) NSString *NET_companyNum;//入展企业数
@property (nonatomic, strong) NSString *NET_Dete;//日期
@property (nonatomic, strong) NSString *NET_Id;//招聘会id

@property (nonatomic, strong) NSString *NET_RN;//rowdi

@property (nonatomic, strong) NSString *NET_ID;//主键id

- (id)initWithDic:(NSDictionary *)dic;

@end
