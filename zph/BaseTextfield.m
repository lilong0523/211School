//
//  BaseTextfield.m
//  zph
//
//  Created by 李龙 on 2016/12/21.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "BaseTextfield.h"

@implementation BaseTextfield
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
    [_outView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]];
   
    _outView.layer.cornerRadius = 16;
    [self addSubview:_outView];
    SearchField = [[UITextField alloc] init];
    SearchField.delegate = self;
    SearchField.font = [UIFont systemFontOfSize:[myFont textFont:13.0]];
    [SearchField setTextColor:[UIColor whiteColor]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:@"" attributes:dict];
    [SearchField setAttributedPlaceholder:attribute];

    [_outView addSubview:SearchField];
    
    [_outView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    [SearchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_outView.mas_left).offset(10);
        make.top.equalTo(_outView.mas_top);
        make.right.equalTo(_outView.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
}

- (void)setPlaceHold:(NSString *)placeHold{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:placeHold attributes:dict];
    [SearchField setAttributedPlaceholder:attribute];
    
}

- (void)setReturnType:(UIReturnKeyType)returnType{
    SearchField.returnKeyType = returnType;
}

- (void)setText:(NSString *)text{
    [SearchField setText:text];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.touchBlock) {
        self.touchBlock();
        return NO;
    }
    else{
        return YES;
    }
    
}

@end
