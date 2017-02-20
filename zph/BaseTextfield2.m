//
//  BaseTextfield2.m
//  zph
//
//  Created by 李龙 on 2016/12/26.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "BaseTextfield2.h"

@implementation BaseTextfield2
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
    UIView *outView = [[UIView alloc] init];
    [outView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]];
    outView.layer.borderColor = BUTTON_COLOR.CGColor;
    outView.layer.masksToBounds = YES;
    outView.layer.borderWidth = 1;
    outView.layer.cornerRadius = 16;
    [self addSubview:outView];
    SearchField = [[UITextField alloc] init];
    SearchField.delegate = self;
    SearchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    SearchField.font = [UIFont systemFontOfSize:[myFont textFont:13.0]];
    [SearchField setTextColor:[UIColor blackColor]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:@"" attributes:dict];
    [SearchField setAttributedPlaceholder:attribute];
    
    [outView addSubview:SearchField];
    
    UIButton *rightView = [[UIButton alloc] init];
    [rightView setBackgroundColor:BUTTON_COLOR];
    [rightView.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [rightView setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    [outView addSubview:rightView];
    
    
    
    [outView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(18);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right).offset(-18);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    [SearchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(outView.mas_left).offset(15);
        make.top.equalTo(outView.mas_top);
        make.right.equalTo(rightView.mas_left).offset(-5);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SearchField.mas_right).offset(5);
        make.top.equalTo(outView.mas_top);
        make.right.equalTo(outView.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(50);
    }];
}

- (void)setPlaceHold:(NSString *)placeHold{
    
    SearchField.placeholder = placeHold;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.SearchBlock) {
        self.SearchBlock(textField.text);
    }
}

- (NSString *)text{
    return SearchField.text;
}


@end
