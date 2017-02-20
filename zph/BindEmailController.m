//
//  BindEmailController.m
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "BindEmailController.h"
#import "BaseTextfield3.h"

@interface BindEmailController ()

@end

@implementation BindEmailController

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
    BaseTextfield3 *textInput = [[BaseTextfield3 alloc] init];
    textInput.placeHold = @"请输入邮箱号";
    [self.view addSubview:textInput];
    
    [textInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(10);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(49);
    }];
    
    
    
}

@end
