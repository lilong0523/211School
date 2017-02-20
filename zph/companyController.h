//
//  companyController.h
//  zph
//
//  Created by 李龙 on 2016/12/25.
//  Copyright © 2016年 李龙. All rights reserved.
//

//企业详情页面
#import "BaseController.h"

@interface companyController : BaseController
@property (nonatomic, strong) NSString *companyId;//企业id
@property (strong, nonatomic) NSString *type;//是否是需要进行视频预约

@end
