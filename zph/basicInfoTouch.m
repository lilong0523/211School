//
//  basicInfoTouch.m
//  zph
//
//  Created by 李龙 on 2016/12/30.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "basicInfoTouch.h"

@implementation basicInfoTouch

{
    
    UILabel *title;
    UIButton *touchBut;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    if (self) {
        
        UIButton *backButton = [[UIButton alloc] init];
        [backButton addTarget:self action:@selector(touchButClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:backButton];
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];
        _rightText = @"";
        _logo = [[UIImageView alloc] init];
        _logo.contentMode = UIViewContentModeScaleAspectFit;
        [backButton addSubview:_logo];
        title = [[UILabel alloc] init];
        [title setTextColor:COMPANY_COLOR];
        [title setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [title setTextAlignment:NSTextAlignmentLeft];
        [backButton addSubview:title];
        
        touchBut = [[UIButton alloc] init];
        [touchBut setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
        
        [touchBut addTarget:self action:@selector(touchButClick) forControlEvents:UIControlEventTouchUpInside];
        touchBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [touchBut.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [backButton addSubview:touchBut];
        
        UIImageView *arrow = [[UIImageView alloc] init];
        [arrow setImage:[UIImage imageNamed:@"icon_arrowRight"]];
        [arrow setContentMode:UIViewContentModeScaleAspectFit];
        [backButton addSubview:arrow];
        
        _line = [[UIView alloc] init];
        [_line setBackgroundColor:LINE_COLOR];
        [backButton addSubview:_line];
        
        [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(15);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            
            make.left.equalTo(self.mas_left).offset(20);
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(touchBut.mas_left).offset(-10);
            make.left.equalTo(_logo.mas_right).offset(10);
            
        }];
        [touchBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-35);
//            make.left.equalTo(title.mas_right).offset(10);
        }];
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
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
    _leftText = leftText;
    [title setText:leftText];
}

- (void)setLeftImage:(NSString *)leftImage{
    _leftImage = leftImage;
    [_logo setImage:[UIImage imageNamed:leftImage]];
}

- (void)setRightText:(NSString *)rightText{
    _rightText = rightText;
    if (![_rightText isEqualToString:@""]) {
        [_logo setImage:[UIImage imageNamed:@"icon_overEdit"]];
    }
    else{
        [_logo setImage:[UIImage imageNamed:_leftImage]];
    }
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
