//
//  YearMonthPick.h
//  zph
//
//  Created by 李龙 on 2017/1/13.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    DateStyleShowYearMonthDayHourMinute  = 0,
    DateStyleShowMonthDayHourMinute,
    DateStyleShowYearMonthDay,
    DateStyleShowMonthDay,
    DateStyleShowHourMinute
    
}XHDateStyle;

typedef enum{
    DateTypeStartDate,
    DateTypeEndDate
    
}XHDateType;

@interface YearMonthPick : UIView

@property (nonatomic,assign)XHDateStyle datePickerStyle;
@property (nonatomic, copy) void(^selectBlock)(NSString *text);

@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认2049）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认1970）

- (void)show;

@end
