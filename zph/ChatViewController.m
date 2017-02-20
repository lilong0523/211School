//
//  ChatViewController.m
//  zph
//
//  Created by 李龙 on 2017/1/5.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<EaseMessageViewControllerDataSource>

@end

@implementation ChatViewController
{
    UIView *_topView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.title = _topTitle;
    self.dataSource = self;
    self.showRefreshHeader = YES;
    //删除不需要的功能
//    [self.chatBarMoreView removeItematIndex:1];
//    [self.chatBarMoreView removeItematIndex:3];
//    [self.chatBarMoreView removeItematIndex:2];
    [self _setupBarButtonItem];
    [self addTableHead];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 添加表头
 */
- (void)addTableHead{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    self.tableView.tableHeaderView = headView;
    self.tableView.backgroundColor = BACKGROUND_COLOR;
    UIView *conterView = [[UIView alloc] initWithFrame:CGRectMake(headView.frame.size.width/2-120, 10, 240, 60)];
    [conterView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    conterView.layer.cornerRadius = 10;
    conterView.layer.masksToBounds = YES;
    [headView addSubview:conterView];
    //公司地址
    UILabel *address = [[UILabel alloc] init];
    [address setText:@"公司地址:"];

    [address setTextColor:[UIColor whiteColor]];
    [address setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [conterView addSubview:address];
    
    UILabel *companyAddress = [[UILabel alloc] init];
    [companyAddress setText:_address];
    companyAddress.numberOfLines = 0;
    [companyAddress setTextColor:[UIColor whiteColor]];
    [companyAddress setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [conterView addSubview:companyAddress];
    
    //公司电话
    UILabel *comp = [[UILabel alloc] init];
    [comp setText:@"公司电话:"];
    [comp setTextColor:[UIColor whiteColor]];
    [comp setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [conterView addSubview:comp];
    
    UILabel *comphone = [[UILabel alloc] init];
    [comphone setText:_phone];
    [comphone setTextColor:[UIColor whiteColor]];
    [comphone setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [conterView addSubview:comphone];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(conterView.mas_top).offset(5);
        make.right.equalTo(companyAddress.mas_left).offset(-5);
        make.left.equalTo(conterView.mas_left).offset(10);
    }];
    [companyAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(address.mas_top);
        make.right.equalTo(conterView.mas_right).offset(-10);
        make.left.equalTo(address.mas_right).offset(5);
    }];
    [comp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(companyAddress.mas_bottom).offset(5);
        make.right.equalTo(address.mas_right);
        make.left.equalTo(address.mas_left);
        make.bottom.mas_lessThanOrEqualTo(conterView.mas_bottom).offset(-2);
    }];
    [comphone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(comp.mas_top);
        make.right.equalTo(companyAddress.mas_right);
        make.left.equalTo(companyAddress.mas_left);
        make.bottom.equalTo(comp.mas_bottom);
    }];
    
}



- (void)_setupBarButtonItem
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backButton.accessibilityIdentifier = @"back";
    [backButton setImage:[UIImage imageNamed:@"icon_arrowLeft"] forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    

}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)setTopTitle:(NSString *)topTitle{
    _topTitle = topTitle;
    
}

- (void)setAddress:(NSString *)address{
    _address = address;
}

- (void)setPhone:(NSString *)phone{
    _phone = phone;
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:NO];
}


@end
