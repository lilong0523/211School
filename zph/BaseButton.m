//
//  BaseButton.m
//  zph
//
//  Created by 李龙 on 2016/12/27.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton
{
    UIButton *goToMeeting;
}

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self setBackgroundColor:BUTTON_COLOR];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.adjustsImageWhenHighlighted = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:16.0]]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }
    return self;
}




- (void)setText:(NSString *)text{
    [self setTitle:text forState:UIControlStateNormal];
}

@end
