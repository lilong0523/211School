//
//  LoginController.m
//  zph
//
//  Created by 李龙 on 2016/12/29.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "LoginController.h"
#import "BaseButton.h"
#import <UMSocialCore/UMSocialCore.h>
#import "MainController.h"
#import "BaseLoginText.h"
#import "FastRegController.h"
#import "FindPwdController.h"
#import "zlib.h"
#import "ExpectJobController.h"
#import "EMManager.h"

@interface LoginController ()<UITextFieldDelegate>

@end

@implementation LoginController
{
    BaseLoginText *user;//用户名
    BaseLoginText *passWord;//密码
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    // Do any additional setup after loading the view.
    [self addMainView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 添加
 */
- (void)addMainView{
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(110, 80, self.view.frame.size.width-220, 80)];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [logo setImage:[UIImage imageNamed:@"LOGO"]];
    
    [self.view addSubview:logo];
    //输入框view
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(logo.frame)+30, self.view.frame.size.width-32, 49*2)];
    inputView.layer.cornerRadius = 2;
    inputView.layer.masksToBounds = YES;
    inputView.layer.borderColor = LINE_COLOR.CGColor;
    inputView.layer.borderWidth = 0.5;
    [inputView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:inputView];
    
    //用户名输入框
    user = [[BaseLoginText alloc] initWithFrame:CGRectMake(0, 0, inputView.frame.size.width, 49) placeHold:@"请输入用户名" image:@"icon_user"];
    user.delegate = self;
    
    user.returnKeyType = UIReturnKeyDone;
    [user addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [inputView addSubview:user];
    
    //分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(user.frame), inputView.frame.size.width, 1)];
    [line setBackgroundColor:LINE_COLOR];
    [inputView addSubview:line];
    //密码输入
    passWord = [[BaseLoginText alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(user.frame), inputView.frame.size.width, user.frame.size.height) placeHold:@"请输入密码" image:@"icon_password"];
    passWord.delegate = self;
    passWord.secureTextEntry = YES;
    passWord.keyboardType = UIKeyboardTypeASCIICapable;
    passWord.returnKeyType = UIReturnKeyDone;
    [passWord addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [inputView addSubview:passWord];
    
    //登录按钮
    BaseButton *loginBut = [[BaseButton alloc] initWithFrame:CGRectMake(inputView.frame.origin.x, CGRectGetMaxY(inputView.frame)+32, inputView.frame.size.width, 44)];
    loginBut.text = @"登录";
    [loginBut addTarget:self action:@selector(loginButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBut];
    //快速注册
    UIButton *fastReg = [[UIButton alloc] initWithFrame:CGRectMake(loginBut.frame.origin.x+10, CGRectGetMaxY(loginBut.frame)+16, 100, 30)];
    [fastReg.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [fastReg setTitle:@"快速注册" forState:UIControlStateNormal];
    [fastReg addTarget:self action:@selector(fastRegClick) forControlEvents:UIControlEventTouchUpInside];
    [fastReg setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
    fastReg.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:fastReg];
    //忘记密码
    UIButton *forgetPass = [[UIButton alloc] initWithFrame:CGRectMake(loginBut.frame.size.width-100, CGRectGetMaxY(loginBut.frame)+16, 100, 30)];
    [forgetPass.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [forgetPass setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPass addTarget:self action:@selector(forgetButClick) forControlEvents:UIControlEventTouchUpInside];
    [forgetPass setTitleColor:FORGETPASW forState:UIControlStateNormal];
    forgetPass.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:forgetPass];
    
    //第三方登录
    UIView *thirdView = [[UIView alloc] init];
    [self.view addSubview:thirdView];
    UIView *leftLine = [[UIView alloc] init];
    [leftLine setBackgroundColor:[UIColor blackColor]];
    [thirdView addSubview:leftLine];
    UILabel *thirdText = [[UILabel alloc] init];
    [thirdText setTextAlignment:NSTextAlignmentCenter];
    [thirdText setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [thirdText setTextColor:COMPANY_COLOR];
    [thirdText setText:@"使用第三方账号登录"];
    [thirdView addSubview:thirdText];
    UIView *rightLine = [[UIView alloc] init];
    [rightLine setBackgroundColor:[UIColor blackColor]];
    [thirdView addSubview:rightLine];
    
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        
        make.right.equalTo(self.view.mas_right);
        
        make.top.equalTo(forgetPass.mas_bottom).offset(30);
    }];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thirdView.mas_left);
        
        make.right.equalTo(thirdText.mas_left).offset(-10);
        make.height.mas_equalTo(0.5);
        make.centerY.equalTo(thirdView.mas_centerY);
    }];
    [thirdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLine.mas_right).offset(10);
        
        make.right.equalTo(rightLine.mas_left).offset(-10);
        make.centerY.equalTo(thirdView.mas_centerY);
    }];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thirdText.mas_right).offset(10);
        
        make.right.equalTo(thirdView.mas_right);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(leftLine.mas_width);
        make.centerY.equalTo(thirdView.mas_centerY);
    }];
    
    //第三方登录按钮
    UIButton *qq = [[UIButton alloc] init];
    [qq setImage:[UIImage imageNamed:@"umsocial_qq"] forState:UIControlStateNormal];
    qq.tag = UMSocialPlatformType_QQ;
    qq.adjustsImageWhenHighlighted = NO;
    [qq addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
    [qq.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:qq];
    UIButton *weixin = [[UIButton alloc] init];
    weixin.tag = UMSocialPlatformType_WechatSession;
    weixin.adjustsImageWhenHighlighted = NO;
    [weixin setImage:[UIImage imageNamed:@"umsocial_wechat"] forState:UIControlStateNormal];
    [weixin addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
    [weixin.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:weixin];
    [qq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginBut.mas_left);
        make.top.equalTo(rightLine.mas_bottom).offset(30);
        make.right.equalTo(loginBut.mas_centerX);
        make.height.mas_equalTo(50);
    }];
    [weixin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(qq.mas_right);
        
        make.right.equalTo(loginBut.mas_right);
        make.height.mas_equalTo(qq.mas_height);
        make.centerY.equalTo(qq.mas_centerY);
    }];
    
    UILabel *qqText = [[UILabel alloc] init];
    [qqText setText:@"QQ登录"];
    [qqText setFont:[UIFont systemFontOfSize:[myFont textFont:11.0]]];
    [qqText setTextColor:COMPANY_COLOR];
    [self.view addSubview:qqText];
    UILabel *weixinText = [[UILabel alloc] init];
    [weixinText setText:@"微信登录"];
    [weixinText setFont:[UIFont systemFontOfSize:[myFont textFont:11.0]]];
    [weixinText setTextColor:COMPANY_COLOR];
    [self.view addSubview:weixinText];
    [qqText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(qq.mas_bottom).offset(15);
        make.centerX.equalTo(qq.mas_centerX);
    }];
    [weixinText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weixin.mas_bottom).offset(15);
        make.centerX.equalTo(weixin.mas_centerX);
    }];
}


/**
 登录按钮
 */
- (void)loginButClick{
    [HUDProgress showHDWithString:@"登录中..." coverView:self.view];
    [self getToken];
}

/**
 快速注册
 */
- (void)fastRegClick{
    
    FastRegController *fastReg = [[FastRegController alloc] init];
    fastReg.topTitle = @"注册";
    [self.navigationController pushViewController:fastReg animated:YES];
}


/**
 忘记密码
 */
- (void)forgetButClick{
    FindPwdController *forget = [[FindPwdController alloc] init];
    forget.topTitle = @"重置密码";
    [self.navigationController pushViewController:forget animated:YES];
}

/**
 qq和微信点击
 
 @param but 点击的but
 */
- (void)thirdLogin:(UIButton *)but{
    [self getUserInfoForPlatform:but.tag];
}


/**
 登录获取token
 */
- (void)getToken{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [HUDProgress hideHUD];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            ((AppDelegate *)[UIApplication sharedApplication].delegate).userModel.model = [dicData objectForKey:@"data"];
            MainController *homePage = [[MainController alloc] init];
            UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:homePage];
            mainNav.navigationBarHidden = YES;
            [UIApplication sharedApplication].delegate.window.rootViewController = mainNav;
            // 实时通话单例与工程根控制器关联(很重要)
            [[DemoCallManager sharedManager] setMainController:homePage];
            //创建环信登录管理类并且登录
            EMManager *EM = [[EMManager alloc] init];
            [EM login:((AppDelegate *)[UIApplication sharedApplication].delegate).userModel.HX_user pass:((AppDelegate *)[UIApplication sharedApplication].delegate).userModel.HX_pass];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
            
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        NSLog(@"%@",error.description);
        [HUDProgress hideHUD];
    };
    NSDictionary *dicBody = @{
                              
                              @"user_id":user.text,//手机号
                              @"user_pass":passWord.text,//密码
                              };//json data
    
    
    [request postAsynRequestBody:dicBody interfaceName:LOGOIN interfaceTag:1 parType:0];
}

//友盟第三方登录
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        if (resp != NULL) {
            MainController *mainControll = [[MainController alloc] init];
            
            UINavigationController *_mainNav = [[UINavigationController alloc] initWithRootViewController:mainControll];
            _mainNav.navigationBarHidden = YES;
            
            [UIApplication sharedApplication].delegate.window.rootViewController = _mainNav;
        }
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.gender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *tem = kNumbers;
    NSString *tem2 = kAlphaNum;
    if (string.length>0) {
        if (textField == user) {
            if ([tem containsString:string]) {
                return YES;
            }
            else{
                return NO;
            }
        }
        else if (textField == passWord){
            if ([tem2 containsString:string]) {
                return YES;
            }
            else{
                return NO;
            }
        }
        
    }
    
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == user) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        
    }
    
    else if (textField == passWord){
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
    
}


@end
