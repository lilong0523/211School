//
//  BaseController.h
//  zph
//
//  Created by 李龙 on 2016/12/21.
//  Copyright © 2016年 李龙. All rights reserved.
//

//基础控制器
#import <UIKit/UIKit.h>

@interface BaseController : UIViewController
@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UIButton *rightBut1;//右1按钮
@property(nonatomic, strong) UIButton *rightBut2;//右2按钮
@property(nonatomic, strong) UIButton *leftBut;//返回按钮
@property(nonatomic, strong) NSString *topTitle;//title
@property(nonatomic, strong) UIView *line;//分割线

@end
