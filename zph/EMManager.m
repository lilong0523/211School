//
//  EMManager.m
//  zph
//
//  Created by 李龙 on 2017/2/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "EMManager.h"

@implementation EMManager


- (void)login:(NSString *)user pass:(NSString *)passWord{
    [[EMClient sharedClient] loginWithUsername:user
                                      password:passWord
                                    completion:^(NSString *aUsername, EMError *aError) {
                                        if (!aError) {
                                            NSLog(@"登陆成功");
                                        } else {
                                            NSLog(@"%u",aError.code);
                                            NSLog(@"登陆失败");
                                        }
                                    }];
}



@end
