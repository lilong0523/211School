//
//  WorkAreaSelectController.h
//  zph
//
//  Created by 李龙 on 2017/1/15.
//  Copyright © 2017年 李龙. All rights reserved.
//

//工作地区选择页面
#import "BaseController.h"

@interface WorkAreaSelectController : BaseController

@property (nonatomic, copy) void(^selectCityBlock)(NSMutableArray *arry);
@property (nonatomic, strong) NSMutableArray *numberArry;
@end
