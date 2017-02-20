//
//  NET_recrutiModel.m
//  zph
//
//  Created by 李龙 on 2017/1/12.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "NET_recrutiModel.h"

@implementation NET_recrutiModel

- (NSMutableDictionary *)detailText{
    if (_detailText == nil) {
        _detailText = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _detailText;
}

@end
