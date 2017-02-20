//
//  FindPwdController.m
//  zph
//
//  Created by 李龙 on 2016/12/29.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "FindPwdController.h"
#import "BaseLoginText.h"
#import "BaseNoImageText.h"

@interface FindPwdController ()<UITextFieldDelegate>

@end

@implementation FindPwdController
{
    UIButton *VerifyCodeBut;//验证码按钮
    NSTimer *time;//计时器
    NSInteger Timing;//计时
    
    BaseNoImageText *phone;//手机号
    BaseNoImageText *VerifyCode;//验证码
    BaseNoImageText *passWord;//密码
    BaseNoImageText *EnsurepassWord;//确认密码
    NSString *currentVerify;//获取到的验证码
}
- (void)viewDidLoad {
    [super viewDidLoad];
    Timing = 60;
    self.topView.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self addInputView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 添加输入窗口
 */
- (void)addInputView{
    
    //输入框view
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+30, self.view.frame.size.width, 49*4)];
    inputView.layer.cornerRadius = 2;
    inputView.layer.masksToBounds = YES;
    inputView.layer.borderColor = LINE_COLOR.CGColor;
    inputView.layer.borderWidth = 0.5;
    [inputView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:inputView];
    
    phone = [[BaseNoImageText alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49) placeHold:@"手机号"];
    phone.delegate = self;
    phone.keyboardType = UIKeyboardTypePhonePad;
    [phone addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [inputView addSubview:phone];
    //分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(phone.frame), self.view.frame.size.width, 1)];
    [line setBackgroundColor:LINE_COLOR];
    [inputView addSubview:line];
    VerifyCode = [[BaseNoImageText alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(phone.frame), self.view.frame.size.width, 49) placeHold:@"验证码"];
    VerifyCode.delegate = self;
    VerifyCode.keyboardType = UIKeyboardTypePhonePad;
    [VerifyCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [inputView addSubview:VerifyCode];
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
    
    //分割线
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(VerifyCode.frame), self.view.frame.size.width, 1)];
    [line2 setBackgroundColor:LINE_COLOR];
    [inputView addSubview:line2];
    passWord = [[BaseNoImageText alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(VerifyCode.frame), self.view.frame.size.width, 49) placeHold:@"请输入新密码"];
    passWord.delegate = self;
    passWord.keyboardType = UIKeyboardTypeASCIICapable;
    passWord.returnKeyType = UIReturnKeyDone;
    [passWord addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [inputView addSubview:passWord];
    //分割线
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(passWord.frame), self.view.frame.size.width, 1)];
    [line3 setBackgroundColor:LINE_COLOR];
    [inputView addSubview:line3];
    EnsurepassWord = [[BaseNoImageText alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(passWord.frame), self.view.frame.size.width, 49) placeHold:@"请确认新密码"];
    [EnsurepassWord addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    EnsurepassWord.delegate = self;
    EnsurepassWord.keyboardType = UIKeyboardTypeASCIICapable;
    EnsurepassWord.returnKeyType = UIReturnKeyDone;
    [inputView addSubview:EnsurepassWord];
    
    //提示字
    UILabel *ps = [[UILabel alloc] init];
    [ps setText:@"6-16位数字字母组合"];
    [ps setTextColor:COMPANYINT_COLOR];
    [ps setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
    [self.view addSubview:ps];
    [ps mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(inputView.mas_bottom).offset(5);
    }];
    
    
    BaseButton *nextBut = [[BaseButton alloc] init];
    [nextBut addTarget:self action:@selector(NextClick) forControlEvents:UIControlEventTouchUpInside];
    nextBut.text = @"确认";
    [self.view addSubview:nextBut];
    [nextBut mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(45);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(inputView.mas_bottom).offset(35);
    }];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *tem = kNumbers;
    NSString *tem2 = kAlphaNum;
    if (string.length>0) {
        if (textField == phone || textField == VerifyCode) {
            if ([tem containsString:string]) {
                return YES;
            }
            else{
                return NO;
            }
        }
        else if (textField == passWord || textField == EnsurepassWord){
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
    if (textField == phone) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        
    }
    else if (textField == VerifyCode){
        if (textField.text.length > 4) {
            textField.text = [textField.text substringToIndex:4];
        }
    }
    else if (textField == passWord || textField == EnsurepassWord){
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
    
}

/**
 获取验证码
 */
- (void)getVerify{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [HUDProgress hideHUD];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            currentVerify = [[dicData objectForKey:@"data"] objectForKey:@"verifyCode_debug"];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
            [VerifyCodeBut setTitle:@"获取验证码" forState:UIControlStateNormal];
            [VerifyCodeBut setTitleColor:VERFIY_COLOR forState:UIControlStateNormal];
            Timing = 60;
            VerifyCodeBut.enabled = YES;
            [time invalidate];
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        NSLog(@"%@",error.description);
        [HUDProgress hideHUD];
    };
    NSDictionary *dicBody = @{
                              
                              @"mobilePhone":phone.text//手机号
                              
                              };//json data
    
    
    [request postAsynRequestBody:dicBody interfaceName:ACCOUNTVERIFY interfaceTag:1 parType:0];
}


/**
 修改密码接口
 */
- (void)changePassWord{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [HUDProgress hideHUD];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            [HUDProgress showHUD:@"重置密码成功，请使用新密码登录"];
            [self.navigationController popViewControllerAnimated:YES];
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
                              @"verify_code":currentVerify,
                              @"contact_tel":phone.text,//手机号
                              @"password":EnsurepassWord.text,
                              };//json data
    
    
    [request postAsynRequestBody:dicBody interfaceName:CHANGEPASS interfaceTag:2 parType:0];
}


/**
 *  正则表达式验证手机号
 *
 *  @param mobile 传入手机号
 *
 *
 */
- (BOOL)validateMobile:(NSString *)mobile
{
    // 130-139  150-153,155-159  180-189  145,147  170,171,173,176,177,178
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


/**
 验证码
 */
- (void)verifyClick{
    if (phone.text.length == 0) {
        [HUDProgress showHUD:@"手机号不能为空"];
    }
    else if (![self validateMobile:phone.text])
    {
        [HUDProgress showHUD:@"请输入正确的手机号"];
    }
    else{
        VerifyCodeBut.enabled = NO;
        //        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"验证码已发送" message:@"验证码已发送到您的手机，请查收" preferredStyle:UIAlertControllerStyleAlert];
        //        NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:@"验证码已发送到您的手机，请查收"];
        //        [titleAtt addAttribute:NSForegroundColorAttributeName value:COMPANY_COLOR range:NSMakeRange(0, @"验证码已发送到您的手机，请查收".length)];
        //        [titleAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[myFont textFont:13.0]] range:NSMakeRange(0, @"验证码已发送到您的手机，请查收".length)];
        //        [alert setValue:titleAtt forKey:@"attributedMessage"];
        //        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"好的",nil) style:UIAlertActionStyleCancel handler:nil];
        //        [alert addAction:alertAction];
        //        [self presentViewController:alert animated:YES completion:nil];
        
        time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(CountDown) userInfo:nil repeats:YES];
        
        [self getVerify];
    }
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

/**
 下一步
 */
- (void)NextClick{
    if (![currentVerify isEqualToString:VerifyCode.text]) {
        [HUDProgress showHUD:@"验证码错误"];
    }
    else if (passWord.text.length<6){
        [HUDProgress showHUD:@"密码为6-16位数字字母组合"];
    }
    else if (![passWord.text isEqualToString:EnsurepassWord.text]){
        [HUDProgress showHUD:@"请保持密码输入一致"];
    }
    else{
        [HUDProgress showHDWithString:@"请稍后..." coverView:self.view];
        [self changePassWord];
    }
    
}

@end
