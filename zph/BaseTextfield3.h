//
//  BaseTextfield3.h
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol baseText3Delegate <NSObject>

- (void)changeText:(NSString *)text textfield:(UITextField *)inputText;

- (BOOL)changeText2:(NSString *)text textfield:(UITextField *)inputText;

@end

@interface BaseTextfield3 : UIView<UITextFieldDelegate>


@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeHold;
@property (nonatomic) UIReturnKeyType returnType;
@property (nonatomic, strong) UIView *outView;
@property (nonatomic, strong) NSString *clear;
@property (nonatomic) UIKeyboardType keybordType;
@property (nonatomic, weak) id<baseText3Delegate>delegate;

@property (nonatomic, copy) void(^searchBlock)();

@end
