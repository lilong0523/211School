//
//  BaseTextfield3.m
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "BaseTextfield3.h"

@implementation BaseTextfield3

{
    UITextField *SearchField;//输入框
    NSString *placeText;//提示内容
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addTextfield];
    }
    return self;
}


- (void)addTextfield{
    _outView = [[UIView alloc] init];
    [_outView setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:_outView];
    SearchField = [[UITextField alloc] init];
    SearchField.delegate = self;
    
    SearchField.font = [UIFont systemFontOfSize:[myFont textFont:14.0]];
    [SearchField setTextColor:[UIColor blackColor]];
    SearchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [SearchField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_outView addSubview:SearchField];
    
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:LINE_COLOR];
    [_outView addSubview:line];
    
    [_outView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    [SearchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_outView.mas_left).offset(20);
        make.top.equalTo(_outView.mas_top);
        make.right.equalTo(_outView.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_outView.mas_left);
        make.height.mas_equalTo(1);
        make.right.equalTo(_outView.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
}

- (void)setPlaceHold:(NSString *)placeHold{
    SearchField.placeholder = placeHold;
}

- (void)setReturnType:(UIReturnKeyType)returnType{
    SearchField.returnKeyType = returnType;
}

- (void)setText:(NSString *)text{
    [SearchField setText:text];
}

- (NSString *)text{
    return SearchField.text;
}

- (void)setClear:(NSString *)clear{
    
}

- (void)setKeybordType:(UIKeyboardType)keybordType{
    SearchField.keyboardType = keybordType;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.delegate respondsToSelector:@selector(changeText2:textfield:)]) {
        return [self.delegate changeText2:string textfield:textField];
    }
    else{
        return YES;
    }
    
}


- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.searchBlock) {
        self.searchBlock(textField.text);
    }
    if ([self.delegate respondsToSelector:@selector(changeText:textfield:)]) {
        [self.delegate changeText:textField.text textfield:textField];
    }
    if (textField == SearchField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        
    }
    
}



@end
