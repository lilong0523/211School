//
//  person_editEducateController.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "person_editEducateController.h"
#import "basicInfoTouch.h"
#import "BaseButton.h"
#import "BasePicker.h"
#import "basicInfoEdit.h"
#import "TimeSlotPick.h"
#import "SelectSchoolController.h"

@interface person_editEducateController ()

@end

@implementation person_editEducateController
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
    
    BaseButton *deleteBut;//删除按钮
    
    TimeSlotPick *timeSelect;//在校时间选择器
    NSMutableArray *eductionArry;//学历数组
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.rightBut2 setTitle:@"保存" forState:UIControlStateNormal];
    [self.rightBut2 addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    
    eductionArry= [[NSMutableArray alloc] initWithObjects:@{@"name":@"研究生",@"id":@"level_01"},@{@"name":@"本科",@"id":@"level_02"},@{@"name":@"大专",@"id":@"level_07"},@{@"name":@"高职",@"id":@"level_03"}, nil];
    [self addMainView];
    
}

- (void)dealloc{
    NSLog(@"销毁");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 添加输入view
 */
- (void)addMainView{
    __block person_editEducateController *blockSelf = self;
    mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+1, self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame)-1)];
    mainScroll.bounces = NO;
    mainScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainScroll];
    
    
    //在校时间
    schoolTime = [[basicInfoTouch alloc] init];
    schoolTime.leftImage = @"icon_edit";
    schoolTime.leftText = @"在校时间";
    schoolTime.rightText = [NSString stringWithFormat:@"%@-%@",[_educationInfo objectForKey:@"begin_date"],[_educationInfo objectForKey:@"end_date"]];
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
    schoolName.rightText = [_educationInfo objectForKey:@"school_name"]?[_educationInfo objectForKey:@"school_name"]:@"";
    
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
    Education.rightText = [_educationInfo objectForKey:@"educations"]?[_educationInfo objectForKey:@"educations"]:@"";
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
    major.text = [_educationInfo objectForKey:@"profession"]?[_educationInfo objectForKey:@"profession"]:@"";
    [mainScroll addSubview:major];
    
    //删除
    deleteBut = [[BaseButton alloc] init];
    deleteBut.text = @"删除此教育背景";
    [deleteBut setBackgroundColor:BITIAN_COLOR];
    [deleteBut addTarget:self action:@selector(deleteButClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:deleteBut];
    
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
    [deleteBut mas_makeConstraints:^(MASConstraintMaker *make) {
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
    __block person_editEducateController *blockSelf = self;
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
    __block person_editEducateController *blockSelf = self;
    
    BasePicker *EducationPick = [[BasePicker alloc] initWithDic:eductionArry copNum:1];
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




/**
 删除按钮
 */
- (void)deleteButClick{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        [self DeleteEducation];
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
        [self EditEducation];
    }
    
}

- (void)setEducationInfo:(NSMutableDictionary *)educationInfo{
    if (_educationInfo == nil) {
        _educationInfo = [[NSMutableDictionary alloc] initWithDictionary:educationInfo];
    }
    startTime = [[educationInfo objectForKey:@"begin_date"] stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    endTime = [[educationInfo objectForKey:@"end_date"] stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    schoolID = [educationInfo objectForKey:@"school_id"];
    educationID = [educationInfo objectForKey:@"education"]?[educationInfo objectForKey:@"education"]:@"";
}

/**
 删除教育背景
 */
- (void)DeleteEducation{
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
                              @"flag":@"1",//1:删除教育经历，2删除工作经历
                              @"id":[_educationInfo objectForKey:@"edu_id"]?[NSString stringWithFormat:@"%@",[_educationInfo objectForKey:@"edu_id"]]:@"",
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:STUDELETE interfaceTag:2];
}

/**
 编辑教育背景
 */
- (void)EditEducation{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [HUDProgress hideHUD];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            [self changDate];
            [HUDProgress showHUD:@"修改成功"];
            if (self.changeBlock) {
                self.changeBlock(_indexNum,_educationInfo);
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
                              @"eduId":[_educationInfo objectForKey:@"edu_id"]?[_educationInfo objectForKey:@"edu_id"]:@"",//条目id
                              @"schoolId":schoolID?schoolID:@"",//学校id
                              @"schoolName":schoolName.rightText,//学校名称
                              @"level":educationID?educationID:@"",//学历id
                              @"profession":major.text,//专业
                              @"beginDate":startTime,//开始时间
                              @"endDate":endTime,//结束时间
                              };//json data
    
    [request postAsynRequestBody:dicBody interfaceName:UPDATEEDU interfaceTag:1 parType:1];
}


/**
 通知个人信息页面刷新
 */
- (void)noticeInfo{
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"changeInfo" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changDate{
    [_educationInfo setObject:major.text forKey:@"profession"];
    [_educationInfo setObject:Education.rightText forKey:@"educations"];
    [_educationInfo setObject:educationID forKey:@"education"];
    [_educationInfo setObject:[startTime stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"begin_date"];
    [_educationInfo setObject:[endTime stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"end_date"];
    [_educationInfo setObject:schoolID forKey:@"school_id"];
    [_educationInfo setObject:schoolName.rightText forKey:@"school_name"];
}

@end
