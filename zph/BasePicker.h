//
//  BasePicker.h
//  zph
//
//  Created by 李龙 on 2016/12/31.
//  Copyright © 2016年 李龙. All rights reserved.
//

//选择器
#import <UIKit/UIKit.h>

@interface BasePicker : UIView

@property (nonatomic, copy) void(^selectBlock)(NSString *text);

@property (nonatomic, copy) void(^updateBlock)(NSString *text);
@property (nonatomic, copy) void(^secondBlock)(NSString *text);

@property (nonatomic, copy) void(^FullIdBlock)(NSString *text);

@property (nonatomic, copy) void(^changeBlock)(NSMutableArray *Arry);

- (instancetype)initWithDic:(NSMutableArray *)arry copNum:(NSInteger) compontNum;

@property (nonatomic, strong) NSMutableArray *secondArry;
@property (nonatomic) NSInteger compontNum;

@property (nonatomic) NSInteger defaultNum;//默认显示第几项

- (void)show;

@end
