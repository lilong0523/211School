//
//  BindQQController.m
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "BindQQController.h"
#import "BaseswitchTouch.h"
@interface BindQQController ()

@end

@implementation BindQQController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.rightBut2 setTitle:@"确定" forState:UIControlStateNormal];
    [self.rightBut2 addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setTitleColor:COMPANYINT_COLOR forState:UIControlStateNormal];
    [self addMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 确定
 */
- (void)rightClick{
    
}

- (void)addMainView{
    
    //绑定QQ
    BaseswitchTouch *QQ = [[BaseswitchTouch alloc] init];
    QQ.leftText = @"QQ";
    [self.view addSubview:QQ];
    //绑定微信
    BaseswitchTouch *weixin = [[BaseswitchTouch alloc] init];
    weixin.leftText = @"微信";
    [self.view addSubview:weixin];
    [QQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(10);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(49);
    }];
    
    [weixin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(QQ.mas_bottom);
        make.width.mas_equalTo(QQ.mas_width);
        make.height.mas_equalTo(QQ.mas_height);
    }];
}

@end
