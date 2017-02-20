//
//  UserModel.h
//  zph
//
//  Created by 李龙 on 2017/1/19.
//  Copyright © 2017年 李龙. All rights reserved.
//

//当前登录人信息
#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, strong) NSMutableDictionary *model;

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *HX_user;//环信账号
@property (nonatomic, strong) NSString *HX_pass;//环信密码

@end
