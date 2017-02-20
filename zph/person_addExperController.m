//
//  person_addExperController.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "person_addExperController.h"
#import "basicInfoTouch.h"
#import "BaseButton.h"
#import "TimeSlotPick.h"
#import "basicInfoEdit.h"
#import "person_editReviewController.h"

@interface person_addExperController ()

@end

@implementation person_addExperController
{
    UIScrollView *mainScroll;
    
    basicInfoTouch *Time;//时间
    NSString *startTime;//开始时间
    NSString *endTime;//结束时间
    basicInfoEdit *compnay;//公司名称
    basicInfoEdit *JobName;//职位名称
    basicInfoTouch *JobDuties;//工作职责
    
    BaseButton *nextBut;//下一步
    UILabel *JobDutText;//工作职责文字
    
    TimeSlotPick *timeSelect;//时间选择器
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.rightBut2 setTitle:@"保存" forState:UIControlStateNormal];
    [self.rightBut2 addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    startTime = @"";
    endTime = @"";
    [self addMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 保存按钮
 */
- (void)rightClick{
    [self AddExperience];
}

/**
 添加输入view
 */
- (void)addMainView{
    mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+1, self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame)-1)];
    mainScroll.bounces = NO;
    mainScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainScroll];
    
    
    __block person_addExperController *blockSelf = self;
    
    //时间
    Time = [[basicInfoTouch alloc] init];
    Time.leftImage = @"icon_edit";
    Time.leftText = @"时间";
    
    Time.selectBlock = ^(){
        
        [blockSelf selectSchoolTime];
    };
    [mainScroll addSubview:Time];
    
    //公司名称
    compnay = [[basicInfoEdit alloc] init];
    compnay.leftImage = @"icon_edit";
    compnay.leftText = @"公司名称";
    compnay.PlaceHold = @"填写公司名称";
    compnay.leftOverImage = @"icon_overEdit";
 
    [mainScroll addSubview:compnay];
    
    //职位名称
    JobName = [[basicInfoEdit alloc] init];
    JobName.leftImage = @"icon_edit";
    JobName.leftText = @"职位名称";
    JobName.PlaceHold = @"填写职位名称";
    JobName.leftOverImage = @"icon_overEdit";
  
    [mainScroll addSubview:JobName];
    //工作职责
    JobDuties = [[basicInfoTouch alloc] init];
    JobDuties.leftImage = @"icon_edit";
    JobDuties.leftText = @"工作职责";
    
    JobDuties.selectBlock = ^(){
        person_editReviewController *jobDut = [[person_editReviewController alloc] init];
        jobDut.topTitle = @"工作职责";
   
        jobDut.editBlock = ^(NSString *text){
          
            [blockSelf->JobDutText setText:text];
            if (![text isEqualToString:@""]) {
                [blockSelf->JobDuties.logo setImage:[UIImage imageNamed:@"icon_overEdit"]];
            }
            else{
                [blockSelf->JobDuties.logo setImage:[UIImage imageNamed:@"icon_edit"]];
            }
        };
        [blockSelf.navigationController pushViewController:jobDut animated:YES];
        
    };
    [mainScroll addSubview:JobDuties];
    
    JobDutText = [[UILabel alloc] init];
    [JobDutText setTextColor:JOBDETAIL_COLOR];
    [JobDutText setFont:[UIFont systemFontOfSize:14.0]];
    [JobDutText setTextAlignment:NSTextAlignmentLeft];
    JobDutText.numberOfLines = 0;
  
    [mainScroll addSubview:JobDutText];
    
  
    [Time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainScroll.mas_bottom);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(45);
    }];
    [compnay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Time.mas_bottom);
        make.width.mas_equalTo(Time.mas_width);
        make.height.mas_equalTo(Time.mas_height);
    }];
    [JobName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(compnay.mas_bottom);
        make.width.mas_equalTo(compnay.mas_width);
        make.height.mas_equalTo(compnay.mas_height);
    }];
    [JobDuties mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(JobName.mas_bottom);
        make.width.mas_equalTo(JobName.mas_width);
        make.height.mas_equalTo(JobName.mas_height);
    }];
    [JobDutText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(JobDuties.mas_bottom).offset(10);
        make.left.equalTo(JobDuties.mas_left).offset(20);
        make.right.equalTo(JobDuties.mas_right).offset(-20);
    }];
    
    
}

/**
 时间选择
 */
- (void)selectSchoolTime{
    [self.view endEditing:YES];
    __block person_addExperController *blockSelf = self;
    if (timeSelect == nil) {
        timeSelect = [[TimeSlotPick alloc] initWithFrame:self.view.frame];
    }
    
    [timeSelect show];
    timeSelect.selectBlock = ^(NSString *time,NSString *startTimeStr,NSString *endTimeStr){
        blockSelf->Time.rightText = time;
        blockSelf->startTime = startTimeStr;
        blockSelf->endTime = endTimeStr;
    };
    
}

/**
 添加工作经历
 */
- (void)AddExperience{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [HUDProgress hideHUD];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            [HUDProgress showHUD:@"添加成功"];
            if (self.addBlock) {
                self.addBlock([self AddDate:[dicData objectForKey:@"data"]]);
            }
            [self noticeInfo];
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
                              @"companyName":compnay.text,
                              @"position":JobName.text,
                              @"introduce":JobDutText.text,
                              @"beginDate":startTime,
                              @"endDate":endTime,
                              
                              };//json data
    
    
    
    [request postAsynRequestBody:dicBody interfaceName:REGISTJOBEXPERIENCE interfaceTag:1 parType:1];
}


- (NSMutableDictionary *)AddDate:(NSDictionary *)dic{
    NSMutableDictionary *addDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [addDic setObject:compnay.text forKey:@"company_name"];
    [addDic setObject:JobDutText.text forKey:@"introduce"];
    [addDic setObject:[startTime stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"begin_date"];
    [addDic setObject:[endTime stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"end_date"];
    [addDic setObject:JobName.text forKey:@"position"];
    [addDic setObject:[dic objectForKey:@"workId"] forKey:@"workId"];
    return addDic;
}

/**
 通知个人信息页面刷新背景
 */
- (void)noticeInfo{
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"changeExp" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
