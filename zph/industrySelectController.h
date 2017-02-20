//
//  industrySelectController.h
//  zph
//
//  Created by 李龙 on 2017/1/16.
//  Copyright © 2017年 李龙. All rights reserved.
//

//行业选择页面
#import "BaseController.h"

@interface industrySelectController : BaseController
@property (nonatomic, copy) void(^selectCityBlock)(NSMutableArray *arry);
@property (nonatomic, strong) NSMutableArray *numberArry;

@end
