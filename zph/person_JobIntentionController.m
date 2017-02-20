//
//  person_JobIntentionController.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "person_JobIntentionController.h"
#import "basicInfoTouch.h"
#import "BaseButton.h"
#import "PracticeController.h"
#import "BasePicker.h"
#import "WorkAreaSelectController.h"
#import "industrySelectController.h"

@interface person_JobIntentionController ()

@end

@implementation person_JobIntentionController
{
    UIScrollView *mainScroll;
    NSMutableArray *WorkNatureArry;//工作性质数组
    NSMutableArray *SalaryArry;//薪资数组
    
    basicInfoTouch *JobName;//职位名称
    NSString *jobStr;//工作职位id
    basicInfoTouch *Jobproperty;//工作性质
    basicInfoTouch *Jobindustry;//工作行业
    basicInfoTouch *JobAddress;//工作地点
    NSString *jobAddressId;
    basicInfoTouch *expectSalary;//期望薪资
    
    NSMutableArray *jobAddressArry;//工作地点数组
    NSMutableArray *industryArry;//工作职位数组
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.rightBut2 setTitle:@"保存" forState:UIControlStateNormal];
    [self.rightBut2 addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    
    WorkNatureArry = [[NSMutableArray alloc] initWithObjects:@{@"name":@"全职",@"id":@"0"},@{@"name":@"兼职",@"id":@"1"}, @{@"name":@"实习生",@"id":@"2"},nil];
    SalaryArry =  [[NSMutableArray alloc] initWithObjects:@{@"name":@"2000-3000",@"id":@"0"},@{@"name":@"3000-5000",@"id":@"1"}, @{@"name":@"5000-8000",@"id":@"2"},@{@"name":@"8000-10000",@"id":@"3"}, @{@"name":@"10000以上",@"id":@"4"},nil];
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
    mainScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainScroll];
    
    __block person_JobIntentionController *blockSelf = self;
    //工作性质
    JobName = [[basicInfoTouch alloc] init];
    JobName.leftImage = @"icon_edit";
    JobName.leftText = @"工作性质";
    JobName.rightText = [_JobInfo objectForKey:@"hope_type"];
    JobName.selectBlock = ^(){
        [blockSelf selectWorkNature];
        
    };
    [mainScroll addSubview:JobName];
    
   
    //职位名称
    Jobindustry = [[basicInfoTouch alloc] init];
    Jobindustry.leftImage = @"icon_edit";
    Jobindustry.leftText = @"职位名称";
    Jobindustry.rightText = [_JobInfo objectForKey:@"hope_positions"];
    Jobindustry.selectBlock = ^(){
        industrySelectController *industrySelect = [[industrySelectController alloc] init];
        industrySelect.numberArry = blockSelf->industryArry;
        industrySelect.topTitle = @"职位选择";
        industrySelect.selectCityBlock = ^(NSMutableArray *arry){
            NSString *str = @"";
            NSString *temStr=@"";
            if (arry.count > 0) {
                if (arry.count == 1) {
                    str = [[arry objectAtIndex:0] objectForKey:@"name"];
                    temStr = [NSString stringWithFormat:@"%@",[[arry objectAtIndex:0] objectForKey:@"full_id"]];
                }
                else{
                    for (NSMutableDictionary *bbq in arry) {
                        if ([arry firstObject] == bbq) {
                            str = [NSString stringWithFormat:@"%@",[bbq objectForKey:@"name"]];
                            temStr = [NSString stringWithFormat:@"%@",[bbq objectForKey:@"full_id"]];
                        }
                        else{
                            str = [NSString stringWithFormat:@"%@、%@",str,[bbq objectForKey:@"name"]];
                            temStr = [NSString stringWithFormat:@"%@,%@",temStr,[bbq objectForKey:@"full_id"]];
                        }
                        
                    }
                }
                
            }
            
            blockSelf->jobStr = temStr;
            blockSelf->industryArry = arry;
            [blockSelf->Jobindustry setRightText:str];
        };
        [blockSelf.navigationController pushViewController:industrySelect animated:YES];
        
    };
    [mainScroll addSubview:Jobindustry];
    //工作地区
    JobAddress = [[basicInfoTouch alloc] init];
    JobAddress.leftImage = @"icon_edit";
    JobAddress.leftText = @"工作地区";
    JobAddress.rightText = [_JobInfo objectForKey:@"hope_areas"];
    JobAddress.selectBlock = ^(){
        WorkAreaSelectController *workArea = [[WorkAreaSelectController alloc] init];
        workArea.numberArry = blockSelf->jobAddressArry;
        workArea.topTitle = @"选择城市";
        workArea.selectCityBlock = ^(NSMutableArray *arry){
            NSString *str = @"";
            NSString *temStr=@"";
            if (arry.count > 0) {
                if (arry.count == 1) {
                    str = [[arry objectAtIndex:0] objectForKey:@"name"];
                    temStr = [NSString stringWithFormat:@"%@",[[arry objectAtIndex:0] objectForKey:@"full_id"]];
                }
                else{
                    for (NSMutableDictionary *bbq in arry) {
                        if ([arry firstObject] == bbq) {
                            str = [NSString stringWithFormat:@"%@",[bbq objectForKey:@"name"]];
                            temStr = [NSString stringWithFormat:@"%@",[bbq objectForKey:@"full_id"]];
                        }
                        else{
                            str = [NSString stringWithFormat:@"%@、%@",str,[bbq objectForKey:@"name"]];
                            temStr = [NSString stringWithFormat:@"%@,%@",temStr,[bbq objectForKey:@"full_id"]];
                        }
                        
                    }
                }
                
            }
            
            blockSelf->jobAddressId = temStr;
            blockSelf->jobAddressArry = arry;
            [blockSelf->JobAddress setRightText:str];
        };
        [blockSelf.navigationController pushViewController:workArea animated:YES];
    };
    [mainScroll addSubview:JobAddress];
    
    //期望薪资
    expectSalary = [[basicInfoTouch alloc] init];
    expectSalary.leftImage = @"icon_edit";
    expectSalary.leftText = @"期望薪资";
    expectSalary.rightText = [_JobInfo objectForKey:@"hope_salary"];
    expectSalary.selectBlock = ^(){
        
        [blockSelf selectSalary];
    };
    [mainScroll addSubview:expectSalary];
    
    [JobName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainScroll.mas_bottom);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(45);
    }];
  
    [Jobindustry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(JobName.mas_bottom);
        make.width.mas_equalTo(JobName.mas_width);
        make.height.mas_equalTo(JobName.mas_height);
    }];
    [JobAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Jobindustry.mas_bottom);
        make.width.mas_equalTo(Jobindustry.mas_width);
        make.height.mas_equalTo(Jobindustry.mas_height);
    }];
    [expectSalary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(JobAddress.mas_bottom);
        make.width.mas_equalTo(JobAddress.mas_width);
        make.height.mas_equalTo(JobAddress.mas_height);
    }];
    
   
    
}

/**
 工作性质选择
 */
- (void)selectWorkNature
{
    BasePicker *sexPick = [[BasePicker alloc] initWithDic:WorkNatureArry copNum:1];
    [sexPick show];
    
    sexPick.selectBlock = ^(NSString *text){
        NSLog(@"%@",text);
        [JobName setRightText:text];
    };
}




/**
 选择薪资范围
 */
- (void)selectSalary{
    BasePicker *SalaryPick = [[BasePicker alloc] initWithDic:SalaryArry copNum:1];
    [SalaryPick show];
    
    SalaryPick.selectBlock = ^(NSString *text){
        NSLog(@"%@",text);
        [expectSalary setRightText:text];
    };
}


/**
 保存按钮
 */
- (void)rightClick{
    if ([JobName.rightText isEqualToString:@""]) {
        [HUDProgress showHUD:@"请选择行业性质"];
    }
    else if ([Jobindustry.rightText isEqualToString:@""]){
        [HUDProgress showHUD:@"请选择职位名称"];
    }
    else if ([JobAddress.rightText isEqualToString:@""]){
        [HUDProgress showHUD:@"请选择工作地区"];
    }
    else if ([expectSalary.rightText isEqualToString:@""]){
        [HUDProgress showHUD:@"请选期望薪资"];
    }
    else{
        [self EditEducation];
    }
}

/**
 修改期望工作
 */
- (void)EditEducation{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [HUDProgress hideHUD];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            if (self.changeBlock) {
                self.changeBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
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
                              @"type":JobName.rightText,
                              @"area":jobAddressId,
                              @"salary":expectSalary.rightText,
                              @"position":jobStr,
                              
                              };//json data
    
    
    
    [request postAsynRequestBody:dicBody interfaceName:UPDATEHOPE interfaceTag:1 parType:1];
}


/**
 载入初始数据

 @param JobInfo cansu
 */
- (void)setJobInfo:(NSMutableDictionary *)JobInfo{
    _JobInfo = JobInfo;
    jobStr = [JobInfo objectForKey:@"hope_position"];
    jobAddressId = [JobInfo objectForKey:@"hope_area"];
    jobAddressArry = [[NSMutableArray alloc] initWithCapacity:0];
    industryArry = [[NSMutableArray alloc] initWithCapacity:0];
    //地区
    NSArray *address = [[JobInfo objectForKey:@"hope_areas"] componentsSeparatedByString:@","];
    //地区id
    NSArray *addressId = [[JobInfo objectForKey:@"hope_area"] componentsSeparatedByString:@","];
    for (int i = 0; i<address.count; i++) {
        NSMutableDictionary *tem = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[address objectAtIndex:i],@"name",[addressId objectAtIndex:i],@"full_id", nil];
        [jobAddressArry addObject:tem];
    }
    //职位名称
    NSArray *position = [[JobInfo objectForKey:@"hope_positions"] componentsSeparatedByString:@","];
    //职位id
    NSArray *positionId = [[JobInfo objectForKey:@"hope_position"] componentsSeparatedByString:@","];
    for (int i = 0; i<position.count; i++) {
        NSMutableDictionary *tem = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[position objectAtIndex:i],@"name",[positionId objectAtIndex:i],@"full_id", nil];
        [industryArry addObject:tem];
    }
}

@end
