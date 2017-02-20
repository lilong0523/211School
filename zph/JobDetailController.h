//
//  JobDetailController.h
//  zph
//
//  Created by 李龙 on 2016/12/24.
//  Copyright © 2016年 李龙. All rights reserved.
//

//职位详情页面
#import "BaseController.h"

@interface JobDetailController : BaseController

@property (strong, nonatomic) NSString *jobId;//职位id
@property (strong, nonatomic) NSString *type;//是否是需要进行视频预约

@end
