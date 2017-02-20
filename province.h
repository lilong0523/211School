//
//  province.h
//  footBall
//
//  Created by mac on 15/8/10.
//  Copyright (c) 2015年 z.b. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface province : NSObject

@property (nonatomic,strong) NSString *area_name;
@property (nonatomic,strong) NSMutableArray *city;
@property (nonatomic,strong) NSString *area_id;
@property (nonatomic,strong) NSString *parent_id;

@end
