//
//  person_editEducateController.h
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

//个人中心编辑教育背景
#import "BaseController.h"

@interface person_editEducateController : BaseController
@property (nonatomic, strong) NSMutableDictionary *educationInfo;
@property (nonatomic) NSInteger indexNum;

@property (nonatomic, copy) void(^changeBlock)(NSInteger num, NSMutableDictionary *dic);

@property (nonatomic, copy) void(^deleteBlock)(NSInteger num);

@end
