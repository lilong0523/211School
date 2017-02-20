//
//  BaseswitchTouch.h
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseswitchTouch : UIView
@property(nonatomic, strong) NSString *leftText;//左侧text

@property(nonatomic, strong) UIView *line;//分割线

@property (nonatomic, copy) void(^selectBlock)();

@end
