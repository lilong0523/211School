//
//  BaseswitchTouch.m
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "BaseswitchTouch.h"

@implementation BaseswitchTouch
{
    UILabel *title;
    
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    if (self) {
        
        title = [[UILabel alloc] init];
        [title setTextColor:COMPANY_COLOR];
        [title setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [title setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:title];
        
        UISwitch *select = [[UISwitch alloc] init];
        [self addSubview:select];
        
        _line = [[UIView alloc] init];
        [_line setBackgroundColor:LINE_COLOR];
        [self addSubview:_line];
        
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            
            make.left.equalTo(self.mas_left).offset(20);
        }];
        [select mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(title.mas_centerY);
            
            make.right.equalTo(self.mas_right).offset(-20);
        }];
       
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(self.mas_width);
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return self;
}
- (void)setLeftText:(NSString *)leftText{
    [title setText:leftText];
}

@end
