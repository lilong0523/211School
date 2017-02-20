//
//  basicInfoTouch.h
//  zph
//
//  Created by 李龙 on 2016/12/30.
//  Copyright © 2016年 李龙. All rights reserved.
//

//基本信息点击栏
#import <UIKit/UIKit.h>

@interface basicInfoTouch : UIView

@property(nonatomic, strong) NSString *leftText;//左侧text
@property(nonatomic, strong) NSString *leftImage;//左侧图片
@property(nonatomic, strong) NSString *rightText;//右边txt
@property(nonatomic, strong) UIView *line;//分割线
@property(nonatomic, strong) UIImageView *logo;//logo
@property (nonatomic, copy) void(^selectBlock)();

@end
