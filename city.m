//
//  city.m
//  footBall
//
//  Created by mac on 15/8/10.
//  Copyright (c) 2015年 z.b. All rights reserved.
//

#import "city.h"

@implementation city

@synthesize area_name;
@synthesize area_id;
@synthesize County;
@synthesize parent_id;

- (id)init
{
    if (self == [super init]) {
        
        County = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return self;
}

@end
