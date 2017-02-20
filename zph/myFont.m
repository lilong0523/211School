//
//  myFont.m
//  Traffic
//
//  Created by 李龙 on 2016/12/4.
//  Copyright © 2016年 z.b. All rights reserved.
//


#import <UIKit/UIKit.h>

@implementation myFont

+ (NSInteger)textFont:(NSInteger)font{
   
    if ([[UIScreen mainScreen] bounds].size.width>320) {
        return font;
    }
    else{
        return font-2;
    }
}



@end
