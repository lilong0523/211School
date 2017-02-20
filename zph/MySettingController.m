//
//  MySettingController.m
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "MySettingController.h"
#import "bacicInfoTouch2.h"
#import "BaseswitchTouch.h"
#import "BaseButton.h"
#import "AccountController.h"
#import "LoginController.h"
#import "suggestController.h"

@interface MySettingController ()

@end

@implementation MySettingController

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
    __block MySettingController *blockself = self;
    //账号设置
    bacicInfoTouch2 *userResume = [[bacicInfoTouch2 alloc] init];
    
    
    userResume.leftText = @"账号设置";
    userResume.selectBlock = ^(){
        AccountController *account = [[AccountController alloc] init];
        account.topTitle = @"账号设置";
        [blockself.navigationController pushViewController:account animated:YES];
    };
    [self.view addSubview:userResume];
    
    //推送消息
    BaseswitchTouch *select = [[BaseswitchTouch alloc] init];
    select.leftText = @"推送消息设置";
    [self.view addSubview:select];
    
    //清除缓存
    bacicInfoTouch2 *clearBut = [[bacicInfoTouch2 alloc] init];
    clearBut.arrow.hidden = YES;
    clearBut.leftText = @"清除缓存";
    clearBut.selectBlock = ^(){
        [HUDProgress showHUD:@"缓存已清除"];
        
        
    };
    [self.view addSubview:clearBut];
    
    //意见反馈
    bacicInfoTouch2 *suggest = [[bacicInfoTouch2 alloc] init];
    
    suggest.leftText = @"意见反馈";
    suggest.selectBlock = ^(){
        suggestController *suggestEdit = [[suggestController alloc] init];
        suggestEdit.topTitle = @"意见反馈";
        [blockself.navigationController pushViewController:suggestEdit animated:YES];
    };
    [self.view addSubview:suggest];
    
    
    //关于我们
    bacicInfoTouch2 *aboutUs = [[bacicInfoTouch2 alloc] init];
    
    aboutUs.leftText = @"关于我们";
    aboutUs.selectBlock = ^(){
        
    };
    [self.view addSubview:aboutUs];
    
    BaseButton *nextBut = [[BaseButton alloc] init];
    [nextBut addTarget:self action:@selector(exitBut) forControlEvents:UIControlEventTouchUpInside];
    nextBut.text = @"退出账号";
    [nextBut setBackgroundColor:BITIAN_COLOR];
    [self.view addSubview:nextBut];
    
    
    [userResume mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(10);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(49);
    }];
    [select mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userResume.mas_bottom).offset(10);
        make.width.mas_equalTo(userResume.mas_width);
        make.height.mas_equalTo(userResume.mas_height);
    }];
    [clearBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(select.mas_bottom);
        make.width.mas_equalTo(userResume.mas_width);
        make.height.mas_equalTo(userResume.mas_height);
    }];
    [suggest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clearBut.mas_bottom);
        make.width.mas_equalTo(userResume.mas_width);
        make.height.mas_equalTo(userResume.mas_height);
    }];
    [aboutUs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(suggest.mas_bottom).offset(10);
        make.width.mas_equalTo(userResume.mas_width);
        make.height.mas_equalTo(userResume.mas_height);
    }];
    [nextBut mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(45);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(aboutUs.mas_bottom).offset(35);
    }];
}


/**
 退出账号
 */
- (void)exitBut{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出账号？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        LoginController *loginView = [[LoginController alloc] init];
        UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:loginView];
        mainNav.navigationBarHidden = YES;
        [UIApplication sharedApplication].delegate.window.rootViewController = mainNav;
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
