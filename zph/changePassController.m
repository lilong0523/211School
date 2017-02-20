//
//  changePassController.m
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "changePassController.h"
#import "BaseTextfield3.h"
#import "LoginController.h"

@interface changePassController ()<baseText3Delegate>

@end

@implementation changePassController
{
    BaseTextfield3 *textInput;
    BaseTextfield3 *NewIPwd;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.rightBut2 setTitle:@"确定" forState:UIControlStateNormal];
    [self.rightBut2 addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    [self addMainView];
}


/**
 确定
 */
- (void)rightClick{
    if (textInput.text.length==0) {
        [HUDProgress showHUD:@"请输入原始密码"];
    }
    else if (NewIPwd.text.length==0){
        [HUDProgress showHUD:@"请输入新密码"];
    }
    else if (![textInput.text isEqualToString:NewIPwd.text]){
        [HUDProgress showHUD:@"两次密码不一致"];
    }
    else{
        [self changePassWord];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addMainView{
    textInput = [[BaseTextfield3 alloc] init];
    textInput.placeHold = @"请输入新密码";
    textInput.delegate = self;
    textInput.keybordType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:textInput];
    NewIPwd = [[BaseTextfield3 alloc] init];
    NewIPwd.placeHold = @"请确认新密码";
    NewIPwd.delegate = self;
    NewIPwd.keybordType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:NewIPwd];
    
    UILabel *ps = [[UILabel alloc] init];
    [ps setText:@"6-20位字母数字组合"];
    [ps setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
    [ps setTextColor:COMPANYINT_COLOR];
    [self.view addSubview:ps];
    
    [textInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(10);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(49);
    }];
    
    [NewIPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textInput.mas_bottom);
        make.width.mas_equalTo(textInput.mas_width);
        make.height.mas_equalTo(textInput.mas_height);
    }];
    [ps mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NewIPwd.mas_bottom).offset(10);
        make.left.equalTo(NewIPwd.mas_left).offset(20);
        
    }];
    
}

- (void)changeText:(NSString *)text textfield:(UITextField *)inputText{
    if (inputText.text.length > 11) {
        inputText.text = [inputText.text substringToIndex:11];
    }
}

- (BOOL)changeText2:(NSString *)text textfield:(UITextField *)inputText{
    NSString *tem = kAlphaNum;
    if (text.length>0) {
        
        if ([tem containsString:text]) {
            return YES;
        }
        else{
            return NO;
        }
        
    }
    
    return YES;
}

/**
 修改密码
 */
- (void)changePassWord{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [HUDProgress hideHUD];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            
            LoginController *login = [[LoginController alloc] init];
            UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:login];
            mainNav.navigationBarHidden = YES;
            [UIApplication sharedApplication].delegate.window.rootViewController = mainNav;
            [HUDProgress showHUD:@"修改成功，请重新登录"];
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
                              
                              @"password":NewIPwd.text,//密码
                              
                              };//json data
    
    
    [request postAsynRequestBody:dicBody interfaceName:UPDATEPASS interfaceTag:1 parType:0];
}


@end
