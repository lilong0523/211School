//
//  datePicker.h
//  zph
//
//  Created by 李龙 on 2017/1/14.
//  Copyright © 2017年 李龙. All rights reserved.
//

//自定义日期选择器
#import <UIKit/UIKit.h>


@interface datePicker : UIView

@property (nonatomic, copy) void(^selectBlock)(NSString *text);

@property (nonatomic, copy) void(^FullIdBlock)(NSString *text);


- (instancetype)initWithNum:(NSInteger) compontNum;

@property (nonatomic) NSInteger compontNum;

@property (nonatomic) NSInteger defaultNum;//默认显示第几项

- (void)show;

@end
