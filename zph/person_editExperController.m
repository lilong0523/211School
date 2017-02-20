//
//  person_editExperController.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "person_editExperController.h"
#import "basicInfoTouch.h"
#import "BaseButton.h"
#import "TimeSlotPick.h"
#import "basicInfoEdit.h"
#import "person_editReviewController.h"

@interface person_editExperController ()

@end

@implementation person_editExperController
{
    UIScrollView *mainScroll;
    
    basicInfoTouch *Time;//时间
    NSString *startTime;//开始时间
    NSString *endTime;//结束时间
    basicInfoEdit *compnay;//公司名称
    basicInfoEdit *JobName;//职位名称
    basicInfoTouch *JobDuties;//工作职责
    UILabel *JobDutText;//工作职责文字
    NSString *jobDetail;//职责详情文字
    
    BaseButton *nextBut;//删除按钮
    
    TimeSlotPick *timeSelect;//时间选择器
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.rightBut2 setTitle:@"保存" forState:UIControlStateNormal];
    [self.rightBut2 addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    
    [self addMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/**
 添加输入view
 */
- (void)addMainView{
    mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+1, self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame)-1)];
    mainScroll.bounces = NO;
    
    [self.view addSubview:mainScroll];
    __block person_editExperController *blockSelf = self;
    
    //时间
    Time = [[basicInfoTouch alloc] init];
    Time.leftImage = @"icon_edit";
    Time.leftText = @"时间";
    Time.rightText = [NSString stringWithFormat:@"%@-%@",[_JobInfo objectForKey:@"begin_date"],[_JobInfo objectForKey:@"end_date"]];
    Time.selectBlock = ^(){
        
        [blockSelf selectSchoolTime];
    };
    [mainScroll addSubview:Time];
    
    //公司名称
    compnay = [[basicInfoEdit alloc] init];
    compnay.backgroundColor = [UIColor whiteColor];
    compnay.leftImage = @"icon_edit";
    compnay.leftText = @"公司名称";
    compnay.PlaceHold = @"填写公司名称";
    compnay.leftOverImage = @"icon_overEdit";
    compnay.text = [_JobInfo objectForKey:@"company_name"];
    [mainScroll addSubview:compnay];
    
    //职位名称
    JobName = [[basicInfoEdit alloc] init];
    JobName.backgroundColor = [UIColor whiteColor];
    JobName.leftImage = @"icon_edit";
    JobName.leftText = @"职位名称";
    JobName.PlaceHold = @"填写职位名称";
    JobName.leftOverImage = @"icon_overEdit";
    JobName.text = [_JobInfo objectForKey:@"position"];
    [mainScroll addSubview:JobName];
    //工作职责
    JobDuties = [[basicInfoTouch alloc] init];
    JobDuties.leftImage = @"icon_edit";
    JobDuties.leftText = @"工作职责";
    if ([[_JobInfo objectForKey:@"introduce"] isEqualToString:@""]||[[_JobInfo objectForKey:@"introduce"] isEqual:[NSNull null]]) {
        [JobDuties.logo setImage:[UIImage imageNamed:@"icon_edit"]];
    }
    else{
        [blockSelf->JobDuties.logo setImage:[UIImage imageNamed:@"icon_overEdit"]];
    }
    JobDuties.selectBlock = ^(){
        person_editReviewController *jobDut = [[person_editReviewController alloc] init];
        jobDut.topTitle = @"工作职责";
        jobDut.detail = blockSelf->jobDetail;
        jobDut.editBlock = ^(NSString *text){
            blockSelf->jobDetail = text;
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
    JobDutText.text = [_JobInfo objectForKey:@"introduce"];
    [mainScroll addSubview:JobDutText];
    
    //删除
    nextBut = [[BaseButton alloc] init];
    nextBut.text = @"删除";
    [nextBut addTarget:self action:@selector(deleteButClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:nextBut];
    
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
    [nextBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(JobDutText.mas_bottom).offset(30);
        make.left.equalTo(JobDuties.mas_left).offset(20);
        make.right.equalTo(JobDuties.mas_right).offset(-20);
        make.height.mas_equalTo(45);
    }];
    
    
}

/**
 时间选择
 */
- (void)selectSchoolTime{
    [self.view endEditing:YES];
    __block person_editExperController *blockSelf = self;
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
 删除按钮
 */
- (void)deleteButClick{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        [self DeleteExper];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 保存按钮
 */
- (void)rightClick{
    [self EditExperience];
}


- (void)setJobInfo:(NSMutableDictionary *)JobInfo{
    if (_JobInfo == nil) {
        _JobInfo = [[NSMutableDictionary alloc] initWithDictionary:JobInfo];
    }
    startTime = [[_JobInfo objectForKey:@"begin_date"] stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    endTime = [[_JobInfo objectForKey:@"end_date"] stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    jobDetail = [_JobInfo objectForKey:@"introduce"]?[_JobInfo objectForKey:@"introduce"]:@"";
}

/**
 删除工作经历
 */
- (void)DeleteExper{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            [HUDProgress showHUD:@"删除成功!"];
            if (self.deleteBlock) {
                self.deleteBlock(_indexNum);
            }
            [self noticeInfo];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              @"flag":@"2",//1:删除教育经历，2删除工作经历
                              @"id":[_JobInfo objectForKey:@"work_id"]?[NSString stringWithFormat:@"%@",[_JobInfo objectForKey:@"work_id"]]:@"",
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:STUDELETE interfaceTag:2];
}

/**
 编辑工作经历
 */
- (void)EditExperience{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [HUDProgress hideHUD];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            [self changDate];
            [HUDProgress showHUD:@"修改成功"];
            if (self.changeBlock) {
                self.changeBlock(_indexNum,_JobInfo);
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
                              @"beginDate":startTime?startTime:@"",
                              @"endDate":endTime?endTime:@"",
                              @"workId":[_JobInfo objectForKey:@"work_id"]?[NSString stringWithFormat:@"%@",[_JobInfo objectForKey:@"work_id"]]:@"",
                              };//json data
    
    
    
    [request postAsynRequestBody:dicBody interfaceName:UPDATEWORK interfaceTag:1 parType:1];
}

/**
 通知个人信息页面刷新
 */
- (void)noticeInfo{
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"changeExp" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changDate{
    [_JobInfo setObject:compnay.text forKey:@"company_name"];
    [_JobInfo setObject:JobDutText.text forKey:@"introduce"];
    [_JobInfo setObject:[startTime stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"begin_date"];
    [_JobInfo setObject:[endTime stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"end_date"];
    [_JobInfo setObject:JobName.text forKey:@"position"];
}

@end
