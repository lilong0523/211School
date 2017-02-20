//
//  AlertView.m
//  Alert
//
//  Created by DreamOnes on 17/1/9.
//  Copyright © 2017年 DreamOnes. All rights reserved.
//

#import "AlertView.h"
#define RGB(r, g, b) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
@implementation AlertView
- (id)initWithFrame:(CGRect)frame withTopTitleStr:(NSString *)ToptitleStr withContentStr:(NSString *)contentStr withPromptStr:(NSString *)PromptStr WithLoginButtonStr:(NSString *)LoginButtonStr WithAppointmentButtonStr:(NSString *)AppointmentButtonStr{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _topTitleStr = ToptitleStr;
        _contentStr = contentStr;
        _PromptStr = PromptStr;
        _LoginButtonStr = LoginButtonStr;
        _AppointmentButtonStr = AppointmentButtonStr;
        [self creatAnyWithView];
    }
    return self;

}
-(void)creatAnyWithView{

    _subView = [[UIView alloc]initWithFrame:self.frame];
    _subView.backgroundColor = [UIColor blackColor];
    _subView.alpha = 0;
    [self addSubview:_subView];
    
    UIView *backView = [[UIView alloc] init];
    backView.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0 - 50);
    backView.bounds = CGRectMake(0, 0, 250,167);
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    _backView = backView;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 250, 16)];
    titleLabel.text = _topTitleStr;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = RGB(86, 86, 86);
    [backView addSubview:titleLabel];
    
    UILabel *contentLabel= [[UILabel alloc] initWithFrame:CGRectMake(0,53, 250, 13)];
    contentLabel.text = _contentStr;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.font = [UIFont systemFontOfSize:13.0f];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.textColor = RGB(165, 165, 165);
    [backView addSubview:contentLabel];
    
    UILabel *PromptStrLabel= [[UILabel alloc] initWithFrame:CGRectMake(0,83, 250, 13)];
    PromptStrLabel.text = _PromptStr;
    PromptStrLabel.textAlignment = NSTextAlignmentCenter;
    PromptStrLabel.font = [UIFont systemFontOfSize:12.0f];
    PromptStrLabel.backgroundColor = [UIColor clearColor];
    PromptStrLabel.textColor = RGB(250 ,86, 102);
    [backView addSubview:PromptStrLabel];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 113, 250, 1)];
    image.image = [UIImage imageNamed:@"虚线"];
    [backView addSubview:image];
    
    
    UIButton *LoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    LoginButton.frame = CGRectMake(0, 115, 125, 167-115);
    [LoginButton setTitleColor:RGB(2, 192, 132) forState:UIControlStateNormal];
    [LoginButton setTitle:_LoginButtonStr forState:UIControlStateNormal];
    [LoginButton addTarget:self action:@selector(certainButtonClick ) forControlEvents:UIControlEventTouchUpInside];
    LoginButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [backView addSubview:LoginButton];
    
    UIButton *AppointmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    AppointmentButton.frame = CGRectMake(125, 115, 125, 167-115);
    [AppointmentButton setTitleColor:RGB(2, 192, 132) forState:UIControlStateNormal];
    [AppointmentButton setTitle:_AppointmentButtonStr forState:UIControlStateNormal];
    [AppointmentButton addTarget:self action:@selector(enterButtonClick ) forControlEvents:UIControlEventTouchUpInside];
    AppointmentButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [backView addSubview:AppointmentButton];
    
    UILabel *lable  = [[UILabel alloc]initWithFrame:CGRectMake(124, 125, 0.5, 30)];
    lable.backgroundColor = RGB(178, 178, 178);
    [backView addSubview:lable];
    
    
    
}
-(void)certainButtonClick {

    [UIView animateWithDuration:0.4 animations:^{
        _backView.alpha = 0.0;
        _backView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}


/**
 确认预约
 */
- (void)enterButtonClick{
    [UIView animateWithDuration:0.4 animations:^{
        _backView.alpha = 0.0;
        _backView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    if (self.enterBlock) {
        self.enterBlock();
    }
}

-(UIView*)topView{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return  window.subviews[0];
}
-(void)show{


    [UIView animateWithDuration:0.5 animations:^{
        _backView.alpha =1;
        _subView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        
    }];
    [[self topView] addSubview:self];
    [self showAnimation];
     [[self topView] addSubview:self];

}
- (void)showAnimation {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_backView.layer addAnimation:popAnimation forKey:nil];
}

- (void)hideAnimation{
    [UIView animateWithDuration:0.4 animations:^{
        _subView.alpha = 0.0;
        _backView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
