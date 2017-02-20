//
//  EMManager.h
//  zph
//
//  Created by 李龙 on 2017/2/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

//环信登录管理类
#import <Foundation/Foundation.h>
#import <Hyphenate/Hyphenate.h>

@interface EMManager : NSObject


- (void)login:(NSString *)user pass:(NSString *)passWord;

@end
