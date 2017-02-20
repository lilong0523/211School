//
//  PersonalCenterController.m
//  zph
//
//  Created by 李龙 on 2017/1/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "PersonalCenterController.h"
#import "basicInfoTouch.h"
#import "MyResumeController.h"
#import "DeliveryRecordController.h"
#import "messageController.h"
#import "MyCollectionController.h"
#import "MySettingController.h"

@interface PersonalCenterController ()

@end

@implementation PersonalCenterController
{
    UIButton *userLogo;//头像
    UILabel *UserName;//姓名
    UILabel *UserAddress;//地点
    basicInfoTouch *userResume;//我的简历
    basicInfoTouch *DeliveryRecord;//我的投递记录
    basicInfoTouch *UserMessage;//我的消息
    basicInfoTouch *UserInterview;//我的面试
    basicInfoTouch *UserCollection;//我的收藏
    
    NSMutableDictionary *allDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.topView.backgroundColor = [UIColor clearColor];
    self.leftBut.hidden = YES;
    self.line.hidden = YES;
    allDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice) name:@"changeSelf" object:nil];
    // Do any additional setup after loading the view.
    [self addMainView];
    [self getPersonal];
}

/**
 更新个人信息
 */
- (void)notice{
    [self getPersonal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addMainView {
    UIImageView *topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 214)];
    [topImage setImage:[UIImage imageNamed:@"personBack"]];
    topImage.userInteractionEnabled = YES;
    [topImage setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:topImage];
    
    UIButton *setBut = [[UIButton alloc] init];
    [setBut setImage:[UIImage imageNamed:@"icon_set"] forState:UIControlStateNormal];
    [setBut.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [setBut addTarget:self action:@selector(setButClick) forControlEvents:UIControlEventTouchUpInside];
    [topImage addSubview:setBut];
    [setBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImage.mas_top).offset(30);
        make.right.equalTo(topImage.mas_right).offset(-15);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    
    //头部
    userLogo = [[UIButton alloc] init];
    
    userLogo.layer.masksToBounds = YES;
    [userLogo addTarget:self action:@selector(userImageSelect) forControlEvents:UIControlEventTouchUpInside];
    [userLogo.imageView setContentMode:UIViewContentModeScaleToFill];
    [userLogo sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_userImage"]];
    [topImage addSubview:userLogo];
    
    //姓名
    UserName = [[UILabel alloc] init];
    [UserName setText:@""];
    [UserName setTextAlignment:NSTextAlignmentCenter];
    [UserName setTextColor:[UIColor whiteColor]];
    [UserName setFont:[UIFont systemFontOfSize:[myFont textFont:16.0]]];
    [topImage addSubview:UserName];
    //地点
    UserAddress = [[UILabel alloc] init];
    [UserAddress setTextAlignment:NSTextAlignmentCenter];
    [UserAddress setTextColor:[UIColor whiteColor]];
    [UserAddress setText:@""];
    [UserAddress setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
    [topImage addSubview:UserAddress];
    
    [userLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.top.equalTo(setBut.mas_bottom).offset(10);
        make.centerX.equalTo(topImage.mas_centerX);
    }];
    [UserName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(userLogo.mas_bottom).offset(15);
        make.centerX.equalTo(topImage.mas_centerX);
    }];
    [UserAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topImage.mas_bottom).offset(-15);
        make.top.equalTo(UserName.mas_bottom).offset(10);
        make.centerX.equalTo(topImage.mas_centerX);
    }];
    
    __block PersonalCenterController *block = self;
    //我的简历
    userResume = [[basicInfoTouch alloc] init];
    userResume.leftImage = @"icon_userResume";
    userResume.line.hidden = YES;
    userResume.leftText = @"我的简历";
    userResume.selectBlock = ^(){
        MyResumeController *myResume = [[MyResumeController alloc] init];
        myResume.topTitle = @"我的简历";
        [block.navigationController pushViewController:myResume animated:YES];
    };
    [self.view addSubview:userResume];
    
    //我的投递记录
    DeliveryRecord = [[basicInfoTouch alloc] init];
    DeliveryRecord.leftImage = @"icon_record";
    DeliveryRecord.leftText = @"我的投递记录";
    DeliveryRecord.line.hidden = YES;
    DeliveryRecord.selectBlock = ^(){
        DeliveryRecordController *delivery = [[DeliveryRecordController alloc] init];
        delivery.topTitle = @"投递记录";
        [block.navigationController pushViewController:delivery animated:YES];
    };
    [self.view addSubview:DeliveryRecord];
    
    //我的消息
    UserMessage = [[basicInfoTouch alloc] init];
    UserMessage.leftImage = @"icon_message";
    UserMessage.leftText = @"我的消息";
    UserMessage.line.hidden = YES;
    UserMessage.selectBlock = ^(){
        messageController *message = [[messageController alloc] init];
        message.currentType = 1;
        [block.navigationController pushViewController:message animated:YES];
    };
    [self.view addSubview:UserMessage];
    
    //我的面试
    UserInterview = [[basicInfoTouch alloc] init];
    UserInterview.leftImage = @"icon_userInterview";
    UserInterview.leftText = @"我的面试";
    UserInterview.line.hidden = YES;
    UserInterview.selectBlock = ^(){
        messageController *message = [[messageController alloc] init];
        message.currentType = 0;
        [block.navigationController pushViewController:message animated:YES];
    };
    [self.view addSubview:UserInterview];
    
    //我的收藏
    UserCollection = [[basicInfoTouch alloc] init];
    UserCollection.leftImage = @"icon_star";
    UserCollection.leftText = @"我的收藏";
    UserCollection.line.hidden = YES;
    UserCollection.selectBlock = ^(){
        MyCollectionController *collection = [[MyCollectionController alloc] init];
        collection.topTitle = @"我的收藏";
        [block.navigationController pushViewController:collection animated:YES];
    };
    [self.view addSubview:UserCollection];
    
    [userResume mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topImage.mas_centerX);
        make.top.equalTo(topImage.mas_bottom);
        make.width.mas_equalTo(topImage.mas_width);
        make.height.mas_equalTo(49);
    }];
    [DeliveryRecord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topImage.mas_centerX);
        make.top.equalTo(userResume.mas_bottom).offset(2);
        make.width.mas_equalTo(userResume.mas_width);
        make.height.mas_equalTo(userResume.mas_height);
    }];
    [UserMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topImage.mas_centerX);
        make.top.equalTo(DeliveryRecord.mas_bottom).offset(2);
        make.width.mas_equalTo(DeliveryRecord.mas_width);
        make.height.mas_equalTo(DeliveryRecord.mas_height);
    }];
    [UserInterview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topImage.mas_centerX);
        make.top.equalTo(UserMessage.mas_bottom).offset(10);
        make.width.mas_equalTo(UserMessage.mas_width);
        make.height.mas_equalTo(UserMessage.mas_height);
    }];
    [UserCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topImage.mas_centerX);
        make.top.equalTo(UserInterview.mas_bottom).offset(10);
        make.width.mas_equalTo(UserInterview.mas_width);
        make.height.mas_equalTo(UserInterview.mas_height);
    }];
}


/**
 设置
 */
- (void)setButClick{
    MySettingController *setting = [[MySettingController alloc] init];
    setting.topTitle = @"设置";
    [self.navigationController pushViewController:setting animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


/**
 头像点击
 */
- (void)userImageSelect{
    
}



- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    userLogo.layer.cornerRadius = userLogo.frame.size.width/2;
    
}

/**
 获取个人中心信息
 */
- (void)getPersonal{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            [allDic setValuesForKeysWithDictionary:[dicData objectForKey:@"data"]];
            [self setAllValue];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:GETPERSONAL interfaceTag:1];
}


- (void)setAllValue{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HEADDOWNLOAD,[allDic objectForKey:@"head_pic"]]];
    [userLogo sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_userImage"]];
    [UserName setText:[allDic objectForKey:@"name"]];
    [UserAddress setText:[NSString stringWithFormat:@"%@  %@",[allDic objectForKey:@"province"],[allDic objectForKey:@"city"]]];
}

@end
