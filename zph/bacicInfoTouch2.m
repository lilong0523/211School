//
//  bacicInfoTouch2.m
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "bacicInfoTouch2.h"

@implementation bacicInfoTouch2

{
    UIImageView *logo;
    UILabel *title;
    UIButton *touchBut;
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
        
        touchBut = [[UIButton alloc] init];
        [touchBut setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
        
        [touchBut addTarget:self action:@selector(touchButClick) forControlEvents:UIControlEventTouchUpInside];
        touchBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [touchBut.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [self addSubview:touchBut];
        
        _arrow = [[UIImageView alloc] init];
        [_arrow setImage:[UIImage imageNamed:@"icon_arrowRight"]];
        [_arrow setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_arrow];
        
        _line = [[UIView alloc] init];
        [_line setBackgroundColor:LINE_COLOR];
        [self addSubview:_line];
        
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            
            make.left.equalTo(self.mas_left).offset(20);
        }];
        [touchBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-35);
            make.left.equalTo(title.mas_right).offset(10);
        }];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.width.mas_equalTo(7);
            make.right.equalTo(self.mas_right).offset(-20);
            make.bottom.equalTo(self.mas_bottom);
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


- (void)setRightText:(NSString *)rightText{
    _rightText = rightText;
    [touchBut setTitle:_rightText forState:UIControlStateNormal];
}


/**
 点选按钮
 */
- (void)touchButClick{
    if (self.selectBlock) {
        self.selectBlock();
    }
}

@end
