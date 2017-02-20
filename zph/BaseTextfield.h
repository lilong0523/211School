//
//  BaseTextfield.h
//  zph
//
//  Created by 李龙 on 2016/12/21.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextfield : UIView<UITextFieldDelegate>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeHold;
@property (nonatomic) UIReturnKeyType returnType;
@property (nonatomic, strong) UIView *outView;

@property (nonatomic, copy) void(^touchBlock)();

@end
