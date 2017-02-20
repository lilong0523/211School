//
//  BaseTextfield2.h
//  zph
//
//  Created by 李龙 on 2016/12/26.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextfield2 : UIView<UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic, copy) NSString *placeHold;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) void(^SearchBlock)();

@end
