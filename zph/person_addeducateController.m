//
//  person_addeducateController.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "person_addeducateController.h"
#import "basicInfoTouch.h"
#import "basicInfoEdit.h"
#import "TimeSlotPick.h"
#import "SelectSchoolController.h"
#import "BasePicker.h"


@interface person_addeducateController ()

@end

@implementation person_addeducateController
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
    schoolID = @"";
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
     __block person_addeducateController *blockSelf = self;
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
    
    
}

/**
 选择在校时间
 */
- (void)selectSchoolTime{
    __block person_addeducateController *blockSelf = self;
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
    __block person_addeducateController *blockSelf = self;
    
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
        [self AddEducation];
    }
}

/**
 添加教育背景
 */
- (void)AddEducation{
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
                              @"schoolId":schoolID,
                              @"schoolName":schoolName.rightText,
                              @"level":educationID,
                              @"profession":major.text,
                              @"beginDate":startTime,
                              @"endDate":endTime,
                              };//json data
    
    
    
    [request postAsynRequestBody:dicBody interfaceName:REGISTEDUCATION interfaceTag:1 parType:1];
}

- (NSMutableDictionary *)AddDate:(NSDictionary *)dic{
    NSMutableDictionary *addDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [addDic setObject:major.text forKey:@"profession"];
    [addDic setObject:Education.rightText forKey:@"educations"];
    [addDic setObject:educationID forKey:@"education"];
    [addDic setObject:[startTime stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"begin_date"];
    [addDic setObject:[endTime stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"end_date"];
    [addDic setObject:schoolID forKey:@"school_id"];
    [addDic setObject:schoolName.rightText forKey:@"school_name"];
    [addDic setObject:[dic objectForKey:@"eduId"]?[dic objectForKey:@"eduId"]:@"" forKey:@"eduId"];
    return addDic;
}

/**
 通知个人信息页面刷新背景
 */
- (void)noticeInfo{
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"changeInfo" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
