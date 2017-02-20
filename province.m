//
//  province.m
//  footBall
//
//  Created by mac on 15/8/10.
//  Copyright (c) 2015年 z.b. All rights reserved.
//

#import "province.h"

@implementation province
@synthesize area_name;
@synthesize area_id;
@synthesize city;
@synthesize parent_id;


- (id)init
{
    if (self == [super init]) {
        
        city = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return self;
}

@end
