//
//  basicInfoController.h
//  zph
//
//  Created by 李龙 on 2016/12/29.
//  Copyright © 2016年 李龙. All rights reserved.
//

//基本信息页面
#import "BaseController.h"

@interface basicInfoController : BaseController
@property (nonatomic, copy) void(^searchBlock)(NSMutableArray *arry);

@property (nonatomic, strong) NSMutableDictionary *parDic;//参数字典
@end
