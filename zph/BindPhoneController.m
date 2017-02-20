//
//  BindPhoneController.m
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "BindPhoneController.h"
#import "BaseLoginText.h"


@interface BindPhoneController ()

@end

@implementation BindPhoneController
{
    UIButton *VerifyCodeBut;//验证码按钮
    NSTimer *time;//计时器
    NSInteger Timing;//计时
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.rightBut2 setTitle:@"确定" forState:UIControlStateNormal];
    [self.rightBut2 addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setTitleColor:COMPANYINT_COLOR forState:UIControlStateNormal];
    [self addMainView];
}


/**
 确定按钮
 */
- (void)rightClick{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addMainView{
    
    BaseLoginText *phone = [[BaseLoginText alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+10, self.view.frame.size.width, 49) placeHold:@"手机号" image:@"icon_phone"];
    phone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phone];
    //分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(phone.frame), self.view.frame.size.width, 1)];
    [line setBackgroundColor:LINE_COLOR];
    [self.view addSubview:line];
    
    BaseLoginText *VerifyCode = [[BaseLoginText alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), self.view.frame.size.width, 49) placeHold:@"验证码" image:@"icon_Verify"];
    VerifyCode.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:VerifyCode];
    //验证码按钮
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, VerifyCode.frame.size.height)];
    VerifyCode.rightView = rightView;
    VerifyCode.rightViewMode = UITextFieldViewModeAlways;
    VerifyCodeBut = [[UIButton alloc] init];
    VerifyCodeBut.layer.cornerRadius = 5;
    [VerifyCodeBut setTitleColor:VERFIY_COLOR forState:UIControlStateNormal];
    VerifyCodeBut.layer.borderColor = VERFIY_COLOR.CGColor;
    VerifyCodeBut.layer.borderWidth = 0.5;
    VerifyCodeBut.layer.masksToBounds = YES;
    [VerifyCodeBut addTarget:self action:@selector(verifyClick) forControlEvents:UIControlEventTouchUpInside];
    [VerifyCodeBut.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [VerifyCodeBut setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightView addSubview:VerifyCodeBut];
    [VerifyCodeBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        make.right.equalTo(rightView.mas_right).offset(-15);
        make.centerY.equalTo(rightView.mas_centerY);
    }];
    
    UILabel *ps = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(VerifyCode.frame)+5, self.view.frame.size.width-10, 15)];
    [ps setText:@"(手机号便于登录和找回密码，成功后，请使用绑定的手机号登录)"];
    [ps setTextColor:COMPANYINT_COLOR];
    [ps setTextAlignment:NSTextAlignmentCenter];
    [ps setFont:[UIFont systemFontOfSize:[myFont textFont:10.0]]];
    [self.view addSubview:ps];
}

/**
 验证码
 */
- (void)verifyClick{
    VerifyCodeBut.enabled = NO;
    time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(CountDown) userInfo:nil repeats:YES];
    
    
}


- (void)CountDown{
    Timing--;
    if (Timing == 0) {
        [VerifyCodeBut setTitle:@"获取验证码" forState:UIControlStateNormal];
        [VerifyCodeBut setTitleColor:VERFIY_COLOR forState:UIControlStateNormal];
        Timing = 60;
        VerifyCodeBut.enabled = YES;
        [time invalidate];
    }
    else{
        [VerifyCodeBut setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
        [VerifyCodeBut setTitle:[NSString stringWithFormat:@"%ldS",(long)Timing] forState:UIControlStateNormal];
    }
    
}

@end
