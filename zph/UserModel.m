//
//  UserModel.m
//  zph
//
//  Created by 李龙 on 2017/1/19.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)setModel:(NSMutableDictionary *)model{
    _token = [NSString stringWithFormat:@"%@",[model objectForKey:@"access_token"]];
    _HX_pass = [NSString stringWithFormat:@"%@",[model objectForKey:@"hx_pass"]];
    _HX_user = [NSString stringWithFormat:@"%@",[model objectForKey:@"hx_user"]];
}

- (void)setToken:(NSString *)token{
    _token = token;
}

- (void)setHX_pass:(NSString *)HX_pass{
    _HX_pass = HX_pass;
}

- (void)setHX_user:(NSString *)HX_user{
    _HX_user = HX_user;
}

@end
