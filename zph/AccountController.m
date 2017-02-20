//
//  AccountController.m
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "AccountController.h"
#import "bacicInfoTouch2.h"
#import "changePassController.h"
#import "BindPhoneController.h"
#import "BindEmailController.h"
#import "BindQQController.h"

@interface AccountController ()

@end

@implementation AccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addMainView{

    __block AccountController *blockself = self;
    //绑定手机
    bacicInfoTouch2 *bindPhone = [[bacicInfoTouch2 alloc] init];
    bindPhone.leftText = @"绑定手机";
    bindPhone.selectBlock = ^(){
        BindPhoneController *bindPhone = [[BindPhoneController alloc] init];
        bindPhone.topTitle = @"绑定手机";
        [blockself.navigationController pushViewController:bindPhone animated:YES];
    };
    [self.view addSubview:bindPhone];
    
    //绑定邮箱
    bacicInfoTouch2 *bindEmail = [[bacicInfoTouch2 alloc] init];
    bindEmail.leftText = @"绑定邮箱";
    bindEmail.rightText = @"未绑定";
    bindEmail.selectBlock = ^(){
        BindEmailController *bindemail = [[BindEmailController alloc] init];
        bindemail.topTitle = @"绑定邮箱";
        [blockself.navigationController pushViewController:bindemail animated:YES];
    };
    [self.view addSubview:bindEmail];
    
    //修改密码
    bacicInfoTouch2 *change = [[bacicInfoTouch2 alloc] init];

    change.leftText = @"修改密码";
    change.selectBlock = ^(){
        changePassController *changepass = [[changePassController alloc] init];
        changepass.topTitle = @"修改密码";
        [blockself.navigationController pushViewController:changepass animated:YES];
    };
    [self.view addSubview:change];
    //绑定社交账号
    bacicInfoTouch2 *bindOther = [[bacicInfoTouch2 alloc] init];
    
    bindOther.leftText = @"绑定社交账号";
    bindOther.selectBlock = ^(){
        BindQQController *bindQQ = [[BindQQController alloc] init];
        bindQQ.topTitle = @"绑定社交账号";
        [blockself.navigationController pushViewController:bindQQ animated:YES];
    };
    [self.view addSubview:bindOther];
    
    [bindPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(10);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(49);
    }];
    [bindEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bindPhone.mas_bottom);
        make.width.mas_equalTo(bindPhone.mas_width);
        make.height.mas_equalTo(bindPhone.mas_height);
    }];
    [change mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bindEmail.mas_bottom).offset(10);
        make.width.mas_equalTo(bindEmail.mas_width);
        make.height.mas_equalTo(bindEmail.mas_height);
    }];
    [bindOther mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(change.mas_bottom).offset(10);
        make.width.mas_equalTo(change.mas_width);
        make.height.mas_equalTo(change.mas_height);
    }];
   
}


@end
