//
//  contry.m
//  footBall
//
//  Created by mac on 15/8/10.
//  Copyright (c) 2015年 z.b. All rights reserved.
//

#import "contry.h"

@implementation contry

@synthesize area_name;
@synthesize area_id;
@synthesize county;
@synthesize parent_id;

- (id)init
{
    if (self == [super init]) {
        
        county = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return self;
}

@end
