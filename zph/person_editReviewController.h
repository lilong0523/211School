//
//  person_editReviewController.h
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

//个人中心编辑综合评述
#import "BaseController.h"

@interface person_editReviewController : BaseController
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, copy) void(^editBlock)(NSString *text);

@end
