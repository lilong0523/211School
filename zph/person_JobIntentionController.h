//
//  person_JobIntentionController.h
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

//个人中心求职意向编辑页面
#import "BaseController.h"

@interface person_JobIntentionController : BaseController

@property (nonatomic, strong) NSMutableDictionary *JobInfo;

@property (nonatomic, copy) void(^changeBlock)();

@end
