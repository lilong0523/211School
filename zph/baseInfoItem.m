//
//  baseInfoItem.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "baseInfoItem.h"

@implementation baseInfoItem
{
    UILabel *leftText;
    UILabel *rightText;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        leftText = [[UILabel alloc] init];
        [leftText setTextAlignment:NSTextAlignmentLeft];
        [leftText setTextColor:COMPANY_COLOR];
        [leftText setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [self addSubview:leftText];
        rightText = [[UILabel alloc] init];
        [rightText setTextColor:COMPANY_COLOR];
        [rightText setTextAlignment:NSTextAlignmentLeft];
        [rightText setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [self addSubview:rightText];
        [leftText mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(40);
            make.top.equalTo(self.mas_top).offset(10);
            
            make.width.mas_equalTo(70);
        }];
        [rightText mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(leftText.mas_right);
            make.right.equalTo(self.mas_right).offset(-20);
            make.centerY.equalTo(leftText.mas_centerY);
      
        }];
        
    }
    return self;
}

- (void)setLeftStr:(NSString *)leftStr{
    [leftText setText:leftStr];
}

- (void)setRightStr:(NSString *)rightStr{
    [rightText setText:rightStr];
}

- (void)setTextColor:(UIColor *)textColor{
    [rightText setTextColor:textColor];
    [leftText setTextColor:textColor];
}

@end
