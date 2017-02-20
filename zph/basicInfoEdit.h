//
//  basicInfoEdit.h
//  zph
//
//  Created by 李龙 on 2016/12/29.
//  Copyright © 2016年 李龙. All rights reserved.
//

//信息编辑textInput
#import <UIKit/UIKit.h>

@interface basicInfoEdit : UIView<UITextFieldDelegate>

@property(nonatomic, strong) NSString *leftText;
@property(nonatomic, strong) NSString *leftImage;
@property(nonatomic, strong) NSString *leftOverImage;
@property(nonatomic, strong) NSString *PlaceHold;
@property(nonatomic, strong) NSString *text;
@property(nonatomic) UIKeyboardType inputType;

@end
