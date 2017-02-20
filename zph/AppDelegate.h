//
//  AppDelegate.h
//  zph
//
//  Created by 李龙 on 2016/12/21.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *mainNav;

@property (strong, nonatomic) NSString *siteid;
@property (strong, nonatomic) NSString *RegistrationID;//极光推送注册id
@property (strong, nonatomic) UserModel *userModel;

@end

