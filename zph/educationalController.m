//
//  educationalController.m
//  zph
//
//  Created by 李龙 on 2016/12/31.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "educationalController.h"
#import "basicInfoTouch.h"
#import "BaseButton.h"
#import "ExpectJobController.h"
#import "TimeSlotPick.h"
#import "SelectSchoolController.h"
#import "BasePicker.h"
#import "basicInfoEdit.h"

@interface educationalController ()

@end

@implementation educationalController
{
    UIScrollView *mainScroll;
    
    basicInfoTouch *schoolTime;//在校时间
    NSString *startTime;//开始时间
    NSString *endTime;//结束时间
    basicInfoTouch *schoolName;//学校名称
    NSString *schoolID;//学校id
    basicInfoTouch *Education;//学历
    NSString *educationID;//学历id
    basicInfoEdit *major;//专业
    
    BaseButton *nextBut;//下一步
    
    TimeSlotPick *timeSelect;//在校时间选择器
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.topView.backgroundColor = [UIColor whiteColor];
    self.leftBut.hidden = YES;
    // Do any additional setup after loading the view.
    [self addMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

/**
 添加输入view
 */
- (void)addMainView{
    
    __block educationalController *blockSelf = self;
    mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+1, self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame)-1)];
    mainScroll.bounces = NO;
    mainScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainScroll];
    
    
    //在校时间
    schoolTime = [[basicInfoTouch alloc] init];
    schoolTime.leftImage = @"icon_edit";
    schoolTime.leftText = @"在校时间";
    schoolTime.selectBlock = ^(){
        //在校时间
        [blockSelf.view endEditing:YES];
        [blockSelf selectSchoolTime];
    };
    [mainScroll addSubview:schoolTime];
    
    //学校名称
    schoolName = [[basicInfoTouch alloc] init];
    schoolName.leftImage = @"icon_edit";
    schoolName.leftText = @"学校名称";
    schoolName.selectBlock = ^(){
        SelectSchoolController *schoolSelect = [[SelectSchoolController alloc] init];
        schoolSelect.topTitle = @"学校选择";
        schoolSelect.searchBlock = ^(NSMutableDictionary *text){
            [blockSelf->schoolName setRightText:[text objectForKey:@"name"]];
            blockSelf->schoolID = [text objectForKey:@"id"];
        };
        [blockSelf.navigationController pushViewController:schoolSelect animated:YES];
        
    };
    [mainScroll addSubview:schoolName];
    
    //学历
    Education = [[basicInfoTouch alloc] init];
    Education.leftImage = @"icon_edit";
    Education.leftText = @"学历";
    Education.selectBlock = ^(){
        
        [blockSelf.view endEditing:YES];
        [blockSelf selectEducation];
    };
    [mainScroll addSubview:Education];
    //专业
    major = [[basicInfoEdit alloc] init];
    major.leftImage = @"icon_edit";
    major.leftText = @"专业";
    major.leftOverImage = @"icon_overEdit";
    major.PlaceHold = @"请输入专业";
    [mainScroll addSubview:major];
    
    //下一步
    nextBut = [[BaseButton alloc] init];
    nextBut.text = @"下一步";
    [nextBut addTarget:self action:@selector(NextButClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:nextBut];
    
    [schoolTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainScroll.mas_bottom);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(45);
    }];
    [schoolName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(schoolTime.mas_bottom);
        make.width.mas_equalTo(schoolTime.mas_width);
        make.height.mas_equalTo(schoolTime.mas_height);
    }];
    [Education mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(schoolName.mas_bottom);
        make.width.mas_equalTo(schoolName.mas_width);
        make.height.mas_equalTo(schoolName.mas_height);
    }];
    [major mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Education.mas_bottom);
        make.width.mas_equalTo(Education.mas_width);
        make.height.mas_equalTo(Education.mas_height);
    }];
    [nextBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(major.mas_bottom).offset(30);
        make.left.equalTo(major.mas_left).offset(20);
        make.right.equalTo(major.mas_right).offset(-20);
        make.height.mas_equalTo(45);
    }];
    
}


/**
 选择在校时间
 */
- (void)selectSchoolTime{
    __block educationalController *blockSelf = self;
    if (timeSelect == nil) {
        timeSelect = [[TimeSlotPick alloc] initWithFrame:self.view.frame];
    }
    
    [timeSelect show];
    timeSelect.selectBlock = ^(NSString *time,NSString *startTimeStr,NSString *endTimeStr){
        [blockSelf->schoolTime setRightText:time];
        blockSelf->startTime = startTimeStr;
        blockSelf->endTime = endTimeStr;
    };
}

/**
 最高学历选择
 */
- (void)selectEducation{
    __block educationalController *blockSelf = self;
    if (self.eductionArry.count>0) {
        BasePicker *EducationPick = [[BasePicker alloc] initWithDic:_eductionArry copNum:1];
        EducationPick.defaultNum = 1;
        [EducationPick show];
        
        EducationPick.selectBlock = ^(NSString *text){
            NSLog(@"%@",text);
            [blockSelf->Education setRightText:text];
        };
        EducationPick.FullIdBlock = ^(NSString *text){
            NSLog(@"%@",text);
            blockSelf->educationID = text;
        };
    }
    
}


- (NSMutableArray *)eductionArry{
    if (_eductionArry==nil) {
        _eductionArry= [[NSMutableArray alloc] initWithObjects:@{@"name":@"研究生",@"id":@"level_01"},@{@"name":@"本科",@"id":@"level_02"},@{@"name":@"大专",@"id":@"level_07"},@{@"name":@"高职",@"id":@"level_03"}, nil];
    }
    return _eductionArry;
}


/**
 下一步
 */
- (void)NextButClick{
    if ([schoolTime.rightText isEqualToString:@""]) {
        [HUDProgress showHUD:@"请选择在校时间"];
    }
    else if ([schoolName.rightText isEqualToString:@""]){
        [HUDProgress showHUD:@"请输入学校名称"];
    }
    else if ([Education.rightText isEqualToString:@""]){
        [HUDProgress showHUD:@"请选择学历"];
    }
    else if ([major.text isEqualToString:@""]){
        [HUDProgress showHUD:@"请输入专业"];
    }
    else{
        [HUDProgress showHDWithString:@"请稍后..." coverView:self.view];
        [self RegistEducation];
    }
    
    
}


/**
 注册最高学历
 */
- (void)RegistEducation{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [HUDProgress hideHUD];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            ExpectJobController *expectJob = [[ExpectJobController alloc] init];
            expectJob.topTitle = @"求职意向(2/3)";
            [self.navigationController pushViewController:expectJob animated:YES];
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
                              @"schoolId":schoolID,
                              @"schoolName":schoolName.rightText,
                              @"level":educationID,
                              @"profession":major.text,
                              @"beginDate":startTime,
                              @"endDate":endTime,
                              };//json data
    
    
    
    [request postAsynRequestBody:dicBody interfaceName:REGISTEDUCATION interfaceTag:1 parType:1];
}


@end
