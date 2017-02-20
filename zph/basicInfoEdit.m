//
//  basicInfoEdit.m
//  zph
//
//  Created by 李龙 on 2016/12/29.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "basicInfoEdit.h"

@implementation basicInfoEdit
{
    UIImageView *logo;
    UILabel *title;
    UITextField *textInput;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        logo = [[UIImageView alloc] init];
        logo.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:logo];
        title = [[UILabel alloc] init];
        [title setTextColor:COMPANY_COLOR];
        [title setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [title setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:title];
        
        textInput = [[UITextField alloc] init];
        [textInput setTextColor:COMPANY_COLOR];
        textInput.textAlignment = NSTextAlignmentRight;
        textInput.delegate = self;
        [textInput setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [self addSubview:textInput];
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:LINE_COLOR];
        [self addSubview:line];
        
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(15);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            
            make.left.equalTo(self.mas_left).offset(20);
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            
            make.left.equalTo(logo.mas_right).offset(10);
        }];
        [textInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-20);
            make.left.equalTo(title.mas_right).offset(10);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(self.mas_width);
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return self;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textInput.text.length != 0) {
        if (_leftOverImage != nil) {
            [logo setImage:[UIImage imageNamed:_leftOverImage]];
        }
        
    }
    else{
        if (_leftImage != nil) {
            [logo setImage:[UIImage imageNamed:_leftImage]];
        }
        
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}
- (void)setLeftText:(NSString *)leftText{
    [title setText:leftText];
}

- (void)setLeftImage:(NSString *)leftImage{
    _leftImage = leftImage;
    [logo setImage:[UIImage imageNamed:leftImage]];
}

- (void)setLeftOverImage:(NSString *)leftOverImage{
    _leftOverImage = leftOverImage;
}

- (void)setPlaceHold:(NSString *)PlaceHold{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = COMPANY_COLOR;
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:PlaceHold attributes:dict];
    [textInput setAttributedPlaceholder:attribute];
}

- (void)setInputType:(UIKeyboardType)inputType{
    textInput.keyboardType = inputType;
}

- (void)setText:(NSString *)text{
    textInput.text = text;
    if (textInput.text.length != 0) {
        if (_leftOverImage != nil) {
            [logo setImage:[UIImage imageNamed:_leftOverImage]];
        }
        
    }
    else{
        if (_leftImage != nil) {
            [logo setImage:[UIImage imageNamed:_leftImage]];
        }
        
    }
}

- (NSString *)text{
    return textInput.text;
}

@end
