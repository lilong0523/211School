//
//  person_editExperController.h
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

//个人中心编辑工作经历页面
#import "BaseController.h"

@interface person_editExperController : BaseController
@property (nonatomic, strong) NSMutableDictionary *JobInfo;
@property (nonatomic) NSInteger indexNum;
@property (nonatomic, copy) void(^changeBlock)(NSInteger num, NSMutableDictionary *dic);

@property (nonatomic, copy) void(^deleteBlock)(NSInteger num);

@end
