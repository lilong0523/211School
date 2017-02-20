//
//  MyResumeController.m
//  zph
//
//  Created by 李龙 on 2017/1/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "MyResumeController.h"
#import "baseInfoCell.h"
#import "educationCell.h"
#import "JobIntentionCell.h"
#import "JobExperienceCell.h"
#import "person_basicInfoController.h"
#import "person_educationController.h"
#import "person_JobIntentionController.h"
#import "person_experienceController.h"
#import "reviewCell.h"
#import "person_editReviewController.h"


@interface MyResumeController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyResumeController
{
    CGFloat Heitht;
    UITableView *listView;
    NSMutableArray *datasource;
    NSMutableDictionary *personInfo;//个人信息
    NSMutableArray *educationInfo;//教育背景
    NSMutableDictionary *hopeInfo;//求职意向信息
    NSMutableArray *experienceArry;//工作经验数组
}
- (void)viewDidLoad {
    [super viewDidLoad];
    Heitht= 60;
    self.topView.backgroundColor = [UIColor whiteColor];
    personInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    educationInfo = [[NSMutableArray alloc] initWithCapacity:0];
    hopeInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
    experienceArry = [[NSMutableArray alloc] initWithCapacity:0];
    // Do any additional setup after loading the view.
    datasource = [[NSMutableArray alloc] initWithCapacity:0];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice) name:@"changeInfo" object:nil];
    [center addObserver:self selector:@selector(changeExp) name:@"changeExp" object:nil];
    datasource = [[NSMutableArray alloc] initWithCapacity:0];
    [self addListView];
    [self getPersonal];
    [self getEducation];
    [self getHopeInfo];
    [self getExperienceInfo];
}



/**
 刷新教育背景
 */
- (void)notice{
    [self getEducation];
}

/**
 刷新工作经历
 */
- (void)changeExp{
    [self getExperienceInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addListView{
    listView = [[UITableView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.topView.frame)+10, self.view.frame.size.width-20, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame)-10) style:UITableViewStyleGrouped];
    listView.delegate = self;
    listView.dataSource = self;
    listView.bounces = NO;
    listView.layer.cornerRadius = 3;
    listView.layer.masksToBounds = YES;
    listView.showsHorizontalScrollIndicator = NO;
    listView.showsVerticalScrollIndicator = NO;
    listView.backgroundColor = [UIColor clearColor];
    listView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:listView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //基本信息
        static NSString *ID =@"cellID1";
        
        baseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[baseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        cell.model = personInfo;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Heitht = [cell getHeightCell];
        return cell;
    }
    else if (indexPath.section == 1){
        //教育背景
        static NSString *ID =@"cellID2";
        
        educationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[educationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        cell.model = [educationInfo objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Heitht = [cell getHeightCell];
        return cell;
    }
    else if (indexPath.section == 2){
        //求职意向
        static NSString *ID =@"cellID3";
        
        JobIntentionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[JobIntentionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        cell.model = hopeInfo;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Heitht = [cell getHeightCell];
        return cell;
    }
    else {
        //工作经验
        static NSString *ID =@"cellID4";
        
        JobExperienceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[JobExperienceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        cell.model = [experienceArry objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Heitht = [cell getHeightCell];
        return cell;
    }
    
    
//    
//    else{
//        //综合评述
//        static NSString *ID =@"cellID5";
//        
//        reviewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//        if (cell == nil) {
//            cell = [[reviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
//            
//        }
//        cell.imageArry = [[NSMutableArray alloc] initWithObjects:@"personBack",@"icon_userInterview",@"personBack", nil];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        Heitht = [cell getHeightCell];
//        return cell;
//    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return educationInfo.count;
    }
    else if (section == 2)
    {
        return 1;
    }
    else if (section == 3)
    {
        return experienceArry.count;
    }
    else{
        return 1;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Heitht;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 42)];
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    UIImageView *image = [[UIImageView alloc] init];
    
    image.contentMode = UIViewContentModeScaleAspectFit;
    [sectionView addSubview:image];
    UILabel *title = [[UILabel alloc] init];
    [title setTextAlignment:NSTextAlignmentLeft];
    [title setTextColor:JOBNAME_COLOR];
    [title setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [sectionView addSubview:title];
    UILabel *bitian = [[UILabel alloc] init];
    
    [bitian setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    
    [sectionView addSubview:bitian];
    
    //编辑按钮
    UIButton *edit = [[UIButton alloc] init];
    [edit.imageView setContentMode:UIViewContentModeScaleAspectFit];
    edit.tag = section;
    [edit setImage:[UIImage imageNamed:@"icon_edit-1"] forState:UIControlStateNormal];
    [edit addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView addSubview:edit];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        
        make.left.equalTo(sectionView.mas_left).offset(10);
        make.centerY.equalTo(sectionView.mas_centerY);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(image.mas_right).offset(10);
        make.centerY.equalTo(image.mas_centerY);
    }];
    [bitian mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(title.mas_right);
        make.centerY.equalTo(title.mas_centerY);
    }];
    [edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.right.equalTo(sectionView.mas_right).offset(-10);
        make.centerY.equalTo(image.mas_centerY);
    }];
    
    
    
    if (section == 0) {
        [title setText:@"基本信息"];
        [bitian setText:@"（必填）"];
        [bitian setTextColor:BITIAN_COLOR];
        [image setImage:[UIImage imageNamed:@"icon_ID"]];
        return sectionView;
    }
    else if (section == 1){
        [title setText:@"教育背景"];
        [bitian setText:@"（必填）"];
        [bitian setTextColor:BITIAN_COLOR];
        [image setImage:[UIImage imageNamed:@"icon_edution"]];
        return sectionView;
    }
    else if (section == 2){
        [title setText:@"求职意向"];
        [bitian setText:@"（必填）"];
        [bitian setTextColor:BITIAN_COLOR];
        [image setImage:[UIImage imageNamed:@"icon_document"]];
        return sectionView;
    }
    else if (section == 3){
        [title setText:@"工作/实习经历"];
        [bitian setText:@"（选填）"];
        [bitian setTextColor:COMPANY_COLOR];
        [image setImage:[UIImage imageNamed:@"icon_JOBEXPER"]];
        return sectionView;
    }
    else{
        
        return sectionView;
    }
    
    
}



/**
 编辑按钮点击
 
 @param but 点击的section
 */
- (void)editClick:(UIButton *)but{
    
    __block MyResumeController *blockself = self;
    
    if (but.tag == 0) {
        //基本信息编辑
        person_basicInfoController *person = [[person_basicInfoController alloc] init];
        person.topTitle = @"基本信息";
        person.model = personInfo;
        person.changeBlock = ^(){
            [blockself getPersonal];
        };
        [self.navigationController pushViewController:person animated:YES];
    }
    else if (but.tag == 1)
    {
        //教育背景
        person_educationController *educate = [[person_educationController alloc] init];
        educate.topTitle = @"教育背景";
        educate.educationArry = educationInfo;
        
        [self.navigationController pushViewController:educate animated:YES];
    }
    else if (but.tag == 2)
    {
        //求职意向
        person_JobIntentionController *jobExpect = [[person_JobIntentionController alloc] init];
        jobExpect.topTitle = @"求职意向";
        jobExpect.changeBlock = ^(){
            [blockself getHopeInfo];
        };
        jobExpect.JobInfo = hopeInfo;
        [self.navigationController pushViewController:jobExpect animated:YES];
    }
    else
    {
        //工作实习
        person_experienceController *experience = [[person_experienceController alloc] init];
        experience.topTitle = @"实习/工作经历";
        experience.experienceArry = experienceArry;
        [self.navigationController pushViewController:experience animated:YES];
    }
//    else{
//        //综述
//        person_editReviewController *editReview = [[person_editReviewController alloc] init];
//        editReview.topTitle = @"综合评述";
//        [self.navigationController pushViewController:editReview animated:YES];
//    }
    
}


/**
 获取个人信息
 */
- (void)getPersonal{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            [personInfo setValuesForKeysWithDictionary:[dicData objectForKey:@"data"]];
            [listView reloadData];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:STUSTUDENT interfaceTag:1];
}

/**
 获取教育背景
 */
- (void)getEducation{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            if ([[dicData objectForKey:@"data"] count]>0) {
                [educationInfo removeAllObjects];
                [educationInfo addObjectsFromArray:[dicData objectForKey:@"data"]];
            }
            
            [listView reloadData];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:STUEDUCATION interfaceTag:2];
}

/**
 获取求职意向信息
 */
- (void)getHopeInfo{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            [hopeInfo setValuesForKeysWithDictionary:[dicData objectForKey:@"data"]];
            
            [listView reloadData];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:STUHOPE interfaceTag:3];
}

/**
 获取工作经历信息
 */
- (void)getExperienceInfo{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            if ([[dicData objectForKey:@"data"] count]>0) {
                [experienceArry removeAllObjects];
                [experienceArry addObjectsFromArray:[dicData objectForKey:@"data"]];
            }
            
            [listView reloadData];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:STUWORK interfaceTag:4];
}



@end
