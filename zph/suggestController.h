//
//  suggestController.h
//  zph
//
//  Created by 李龙 on 2017/2/14.
//  Copyright © 2017年 李龙. All rights reserved.
//

//意见反馈页面
#import "BaseController.h"

@interface suggestController : BaseController

@property (nonatomic, strong) NSString *detail;
@property (nonatomic, copy) void(^editBlock)(NSString *text);

@end
