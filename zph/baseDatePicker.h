//
//  baseDatePicker.h
//  zph
//
//  Created by 李龙 on 2016/12/31.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface baseDatePicker : UIView

@property (nonatomic, copy) void(^selectBlock)(NSDate *date);

- (void)show;

@end
