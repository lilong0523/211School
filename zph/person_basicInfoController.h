//
//  person_basicInfoController.h
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

//个人中心基本信息
#import "BaseController.h"

@interface person_basicInfoController : BaseController
@property (nonatomic, strong) NSMutableDictionary *model;
@property (nonatomic, copy) void(^changeBlock)();

@end
