//
//  person_addExperController.h
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

//个人中心添加工作实习经历
#import "BaseController.h"

@interface person_addExperController : BaseController

@property (nonatomic, copy) void(^addBlock)(NSMutableDictionary *dic);

@end
