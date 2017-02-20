//
//  BaseNoImageText.m
//  zph
//
//  Created by 李龙 on 2016/12/29.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "BaseNoImageText.h"

@implementation BaseNoImageText

- (id)initWithFrame:(CGRect)frame placeHold:(NSString *)placeHold{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPlaceholder:placeHold];
        [self setFont:[UIFont systemFontOfSize:15.0]];
        UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, self.frame.size.height)];
        
        self.leftView = leftView2;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

@end
