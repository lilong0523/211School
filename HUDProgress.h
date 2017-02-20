//
//  HUDProgress.h
//  Traffic
//
//  Created by 李龙 on 2016/12/13.
//  Copyright © 2016年 z.b. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUDProgress : NSObject

+ (void)showHUD:(NSString *)msg;
+ (void)hideHUD;
+ (void)showHDWithString:(NSString *)string coverView:(UIView *)coverFrom;
+ (void)hideHDWithView:(UIView *)coverFrom;

@end
