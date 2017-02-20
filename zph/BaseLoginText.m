//
//  BaseLoginText.m
//  zph
//
//  Created by 李龙 on 2016/12/29.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "BaseLoginText.h"

@implementation BaseLoginText

- (id)initWithFrame:(CGRect)frame placeHold:(NSString *)placeHold image:(NSString *)image{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPlaceholder:placeHold];
        [self setFont:[UIFont systemFontOfSize:15.0]];
        UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, self.frame.size.height)];
        UIImageView *passWordImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 0, 16, leftView2.frame.size.height)];
        [passWordImage setContentMode:UIViewContentModeScaleAspectFit];
        [passWordImage setImage:[UIImage imageNamed:image]];
        [leftView2 addSubview:passWordImage];
        self.leftView = leftView2;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

@end
