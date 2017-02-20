//
//  BaseController.m
//  zph
//
//  Created by 李龙 on 2016/12/21.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController
{
    UILabel *title;//标题
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = YES;
    self.hidesBottomBarWhenPushed=YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    // Do any additional setup after loading the view.
    [self addTopNav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 添加nav
 */
- (void)addTopNav{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_topView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_topView];
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, _topView.frame.size.height-1, _topView.frame.size.width, 0.5)];
    [_line setBackgroundColor:LINE_COLOR];
    [_topView addSubview:_line];
    
    UIView *navView = [[UIView alloc] init];
    [_topView addSubview:navView];
    
    _leftBut = [[UIButton alloc] init];
    [_leftBut setContentMode:UIViewContentModeScaleAspectFit];
    [_leftBut addTarget:self action:@selector(backClcik) forControlEvents:UIControlEventTouchUpInside];
    [_leftBut setImage:[UIImage imageNamed:@"icon_arrowLeft"] forState:UIControlStateNormal];
    [navView addSubview:_leftBut];
    
    title = [[UILabel alloc] init];
    [title setTextColor:JOBNAME_COLOR];
     [title setText:_topTitle];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setFont:[UIFont systemFontOfSize:[myFont textFont:18.0]]];
    [navView addSubview:title];
    
    _rightBut1 = [[UIButton alloc] init];
    [_rightBut1.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [_rightBut1 setContentMode:UIViewContentModeScaleAspectFit];
    [navView addSubview:_rightBut1];
    _rightBut2 = [[UIButton alloc] init];
    [_rightBut2.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [_rightBut2 setContentMode:UIViewContentModeScaleAspectFit];
    [navView addSubview:_rightBut2];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(_topView.mas_top).offset(20);
        make.bottom.equalTo(_topView.mas_bottom);
    }];
    
    [_leftBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navView.mas_left).offset(10);
        make.centerY.equalTo(navView.mas_centerY);
        make.width.mas_equalTo(40);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(navView.mas_centerX);
        make.centerY.equalTo(navView.mas_centerY);
 
    }];
    [_rightBut1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_rightBut2.mas_left).offset(-15);
        make.centerY.equalTo(navView.mas_centerY);
        
        make.height.mas_equalTo(20);
    }];
    [_rightBut2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(navView.mas_right).offset(-20);
        make.centerY.equalTo(navView.mas_centerY);
        make.left.equalTo(_rightBut1.mas_right).offset(15);
       
        make.height.mas_equalTo(20);
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)setTopTitle:(NSString *)topTitle{
    _topTitle = topTitle;
   
}

- (void)backClcik{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setEdgesForExtendedLayout:(UIRectEdge)edgesForExtendedLayout{
    [_leftBut setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
