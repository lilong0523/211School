//
//  JobDetailController.m
//  zph
//
//  Created by 李龙 on 2016/12/24.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "JobDetailController.h"
#import "companyController.h"
#import "ChatViewController.h"
#import "JobRecenceController.h"
#import <UShareUI/UShareUI.h>
#import "AlertViewY.h"
#import "AlertView.h"

@interface JobDetailController ()

@end

@implementation JobDetailController
{
    UIScrollView *mainScroll;
    UIView *TopView;//下部按钮view
    UIView *Covline;//头部和中间详情分割线
    UIView *midView;
    
    UILabel *JobName;//职位名称
    UILabel *ps;//总共多少场招聘会有该职务
    UILabel *date;//发布时间
    UILabel *salary;//薪资
    UIButton *location;//位置
    UILabel *positionDetail;//岗位职责
    UIButton *Year;//工作年限
    UILabel *OfficeDetail;//任职资格
    UIButton *Degree;//学历
    UILabel *companyName;//公司名
    UILabel *address;//工作地址
    UILabel *workTimeDetail;//上班时间
    
    NSMutableDictionary *datasource;//详情数据
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    datasource = [[NSMutableDictionary alloc] initWithCapacity:0];
    [self.rightBut1 setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    [self.rightBut1 addTarget:self action:@selector(shareBut) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setBackgroundImage:[UIImage imageNamed:@"icon_star"] forState:UIControlStateNormal];
    [self.rightBut2 setBackgroundImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateSelected];
    [self.rightBut2 setBackgroundImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateHighlighted];
    
    [self.rightBut2 addTarget:self action:@selector(CollectionBut) forControlEvents:UIControlEventTouchUpInside];
    mainScroll  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.topView.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame)-60)];
    mainScroll.showsVerticalScrollIndicator = NO;
    mainScroll.bounces = NO;
    
    mainScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:mainScroll];
    
    [self addHeadView];
    [self addBottomView];
    [self getJobDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 分享
 */
- (void)shareBut{
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];

}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享的标题" descr:@"这是分享的人荣" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://www.baidu.com";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [HUDProgress showHUD:error.description];
    }];
}

/**
 收藏职位
 */
- (void)CollectionBut{
    [self AddJobRecu];
}

/**
 上部view
 */
- (void)addHeadView{
    UIView *Head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScroll.frame.size.width, 180)];
  
    [mainScroll addSubview:Head];
    Covline = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(Head.frame), Head.frame.size.width, 10)];
    [Covline setBackgroundColor:TOPLINE_COLOR];
    [mainScroll addSubview:Covline];
    JobName = [[UILabel alloc] init];
    JobName.numberOfLines = 0;
    [JobName setText:@"高薪急聘售网络"];
    [JobName setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [JobName setTextColor:JOBDETAIL_COLOR];
    [JobName setTextAlignment:NSTextAlignmentLeft];
    [Head addSubview:JobName];
    date = [[UILabel alloc] init];
    [date setText:@"2016-10-12"];
    [date setTextAlignment:NSTextAlignmentRight];
    [date setTextColor:[UIColor colorWithHexString:@"#A5A5A5"]];
    [date setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
    [Head addSubview:date];
    salary = [[UILabel alloc] init];
    [salary setTextAlignment:NSTextAlignmentLeft];
    [salary setText:@"¥3000-5000元/月"];
    [salary setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
    [salary setTextColor:SALAARYDETAIL_COLOR];
    [Head addSubview:salary];
    
    location = [[UIButton alloc] init];
    [location setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
    [location setTitleColor:[UIColor colorWithHexString:@"#898989"] forState:UIControlStateNormal];
    location.adjustsImageWhenHighlighted = NO;
    [location.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [location.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [location setTitle:@"西安" forState:UIControlStateNormal];
    [Head addSubview:location];
    
    Year = [[UIButton alloc] init];
    [Year setImage:[UIImage imageNamed:@"icon_time"] forState:UIControlStateNormal];
    [Year setTitleColor:[UIColor colorWithHexString:@"#898989"] forState:UIControlStateNormal];
    Year.adjustsImageWhenHighlighted = NO;
    [Year.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [Year.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [Year setTitle:@"1-3年" forState:UIControlStateNormal];
    [Head addSubview:Year];
    
    Degree = [[UIButton alloc] init];
    [Degree setImage:[UIImage imageNamed:@"icon_degree"] forState:UIControlStateNormal];
    [Degree setTitleColor:[UIColor colorWithHexString:@"#898989"] forState:UIControlStateNormal];
    Degree.adjustsImageWhenHighlighted = NO;
    [Degree.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [Degree.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [Degree setTitle:@"本科" forState:UIControlStateNormal];
    [Head addSubview:Degree];
    
    
    [JobName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Head.mas_left).offset(20);
        make.top.equalTo(Head.mas_top).offset(12);
        make.right.equalTo(date.mas_left).offset(-5);
    }];
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(Head.mas_right).offset(-20);
        make.centerY.equalTo(JobName.mas_centerY);
        make.left.equalTo(JobName.mas_right).offset(5);
        make.width.mas_greaterThanOrEqualTo(100);
    }];
    [salary mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(JobName.mas_bottom).offset(10);
        make.left.equalTo(JobName.mas_left);
        make.width.mas_greaterThanOrEqualTo(100);
    }];
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(salary.mas_bottom).offset(15);
        make.left.equalTo(salary.mas_left);
        
        make.height.mas_equalTo(15);
    }];
    [Year mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(location.mas_centerY);
        
        make.left.equalTo(location.mas_right).offset(10);
        
        make.height.mas_equalTo(15);
    }];
    [Degree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(Year.mas_centerY);
        
        make.left.equalTo(Year.mas_right).offset(10);
        
        make.height.mas_equalTo(15);
    }];
    
    
    //公司和发布会cell部分
    UIButton *company = [[UIButton alloc] init];
    [company addTarget:self action:@selector(companyClick) forControlEvents:UIControlEventTouchUpInside];
    [Head addSubview:company];
    UIButton *Recruitment = [[UIButton alloc] init];
    [Recruitment addTarget:self action:@selector(recruitClick) forControlEvents:UIControlEventTouchUpInside];
    [Head addSubview:Recruitment];
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:LINE_COLOR];
    [Head addSubview:line];
    [company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line.mas_top);
        make.top.equalTo(Degree.mas_bottom).offset(12);
        make.left.equalTo(Head.mas_left).offset(20);
        make.height.equalTo(Recruitment.mas_height);
        make.right.equalTo(Head.mas_right).offset(-20);
    }];
    [Recruitment mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(company.mas_left);
        make.bottom.equalTo(Head.mas_bottom);
        make.height.equalTo(company.mas_height);
        make.right.equalTo(company.mas_right);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(company.mas_bottom);
        make.left.equalTo(Head.mas_left);
        make.bottom.equalTo(Recruitment.mas_top);
        make.height.mas_equalTo(1);
        make.right.equalTo(Head.mas_right);
    }];
    
    companyName = [[UILabel alloc] init];
    [companyName setText:@""];
    [companyName setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [companyName setTextColor:JOBNAME_COLOR];
    [company addSubview:companyName];
    address = [[UILabel alloc] init];
    [address setText:@""];
    [address setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
    [address setTextColor:COMPANY_COLOR];
    [company addSubview:address];
    UIImageView *arrow = [[UIImageView alloc] init];
    [arrow setImage:[UIImage imageNamed:@"icon_arrowRight"]];
    [arrow setContentMode:UIViewContentModeScaleAspectFit];
    [company addSubview:arrow];
    
    
    [companyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(company.mas_top);
        make.left.equalTo(company.mas_left);
        make.right.equalTo(arrow.mas_left).offset(-5);
        make.bottom.equalTo(company.mas_centerY);
    }];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(companyName.mas_bottom).offset(5);
        make.left.equalTo(companyName.mas_left);
        make.right.equalTo(companyName.mas_right);
        make.bottom.equalTo(company.mas_bottom).offset(-5);
    }];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(company.mas_right);
        make.centerY.equalTo(company.mas_centerY);
        make.width.mas_equalTo(15);
        make.left.equalTo(companyName.mas_right).offset(5);
    }];
    //招聘会预告信息
    UIImageView *smail = [[UIImageView alloc] init];
    [smail setImage:[UIImage imageNamed:@"icon_smail"]];
    [smail setContentMode:UIViewContentModeScaleAspectFit];
    [Recruitment addSubview:smail];
    ps = [[UILabel alloc] init];
    [ps setText:@""];
    [ps setTextAlignment:NSTextAlignmentLeft];
    [ps setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [ps setTextColor:COMPANY_COLOR];
    [Recruitment addSubview:ps];
    UIImageView *arrow2 = [[UIImageView alloc] init];
    [arrow2 setImage:[UIImage imageNamed:@"icon_arrowRight"]];
    [arrow2 setContentMode:UIViewContentModeScaleAspectFit];
    [Recruitment addSubview:arrow2];
    [smail mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(ps.mas_left).offset(-5);
        make.centerY.equalTo(Recruitment.mas_centerY);
        make.width.mas_equalTo(15);
        make.left.equalTo(Recruitment.mas_left);
    }];
    [ps mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(arrow2.mas_left).offset(-5);
        make.centerY.equalTo(Recruitment.mas_centerY);
        
        make.left.equalTo(smail.mas_right).offset(5);
    }];
    [arrow2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(Recruitment.mas_right);
        make.centerY.equalTo(Recruitment.mas_centerY);
        make.width.mas_equalTo(15);
        make.left.equalTo(ps.mas_right).offset(5);
    }];
    [self addMidView];
}


//添加中间详情信息
- (void)addMidView{
    midView = [[UIView alloc] init];
 
    [mainScroll addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(mainScroll.frame.size.width);
        make.right.equalTo(mainScroll.mas_right);
        make.top.equalTo(Covline.mas_bottom);
        make.left.equalTo(mainScroll.mas_left);
    }];
    UIImageView *dataImage = [[UIImageView alloc] init];
    [dataImage setImage:[UIImage imageNamed:@"icon_detail"]];
    [dataImage setContentMode:UIViewContentModeScaleAspectFit];
    [midView addSubview:dataImage];
    UILabel *JobDescription = [[UILabel alloc] init];
    [JobDescription setText:@"职位描述"];
    [JobDescription setTextColor:[UIColor colorWithHexString:@"#02c084"]];
    [JobDescription setTextAlignment:NSTextAlignmentLeft];
    [JobDescription setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [midView addSubview:JobDescription];
    [dataImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(JobDescription.mas_left).offset(-5);
        make.top.equalTo(midView.mas_top).offset(10);
        make.width.mas_equalTo(15);
        make.left.equalTo(midView.mas_left).offset(20);
    }];
    [JobDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(dataImage.mas_centerY);
        make.right.equalTo(midView.mas_right).offset(-20);
        make.left.equalTo(dataImage.mas_right).offset(5);
    }];
    //岗位职责
    UILabel *positionLab = [[UILabel alloc] init];
    [positionLab setText:@"岗位职责:"];
    [positionLab setTextAlignment:NSTextAlignmentLeft];
    [positionLab setTextColor:JOBNAME_COLOR];
    [positionLab setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [midView addSubview:positionLab];
    positionDetail = [[UILabel alloc] init];
    [positionDetail setText:@""];
    positionDetail.numberOfLines = 0;
    [positionDetail setTextAlignment:NSTextAlignmentLeft];
    [positionDetail setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [positionDetail setTextColor:COMPANY_COLOR];
    [midView addSubview:positionDetail];
    //任职资格
    UILabel *OfficeLab = [[UILabel alloc] init];
    [OfficeLab setText:@"任职资格:"];
    [OfficeLab setTextColor:JOBNAME_COLOR];
    [OfficeLab setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [midView addSubview:OfficeLab];
    OfficeDetail = [[UILabel alloc] init];
    [OfficeDetail setText:@""];
    OfficeDetail.numberOfLines = 0;
    [OfficeDetail setTextAlignment:NSTextAlignmentLeft];
    [OfficeDetail setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [OfficeDetail setTextColor:COMPANY_COLOR];
    [midView addSubview:OfficeDetail];
    //上班时间
    //    UILabel *workTime = [[UILabel alloc] init];
    //    [workTime setText:@"上班时间:"];
    //    [workTime setTextColor:JOBNAME_COLOR];
    //    [workTime setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    //    [midView addSubview:workTime];
    //    workTimeDetail = [[UILabel alloc] init];
    //    [workTimeDetail setText:@"这是上班时间"];
    //    workTimeDetail.numberOfLines = 0;
    //    [workTimeDetail setTextAlignment:NSTextAlignmentLeft];
    //    [workTimeDetail setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    //    [workTimeDetail setTextColor:COMPANY_COLOR];
    //    [midView addSubview:workTimeDetail];
    [positionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(midView.mas_right).offset(-20);
        make.top.equalTo(dataImage.mas_bottom).offset(10);
        make.left.equalTo(dataImage.mas_left);
    }];
    [positionDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(positionLab.mas_right);
        make.top.equalTo(positionLab.mas_bottom).offset(10);
        make.left.equalTo(positionLab.mas_left);
    }];
    [OfficeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(positionDetail.mas_right);
        make.top.equalTo(positionDetail.mas_bottom).offset(10);
        make.left.equalTo(positionDetail.mas_left);
    }];
    [OfficeDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(OfficeLab.mas_right);
        make.top.equalTo(OfficeLab.mas_bottom).offset(10);
        make.left.equalTo(OfficeLab.mas_left);
        make.bottom.equalTo(midView.mas_bottom).offset(-15);
    }];
    //    [workTime mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.right.equalTo(OfficeDetail.mas_right);
    //        make.top.equalTo(OfficeDetail.mas_bottom).offset(10);
    //        make.left.equalTo(OfficeDetail.mas_left);
    //    }];
    //    [workTimeDetail mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.right.equalTo(workTime.mas_right);
    //        make.top.equalTo(workTime.mas_bottom).offset(10);
    //        make.left.equalTo(workTime.mas_left);
    //        make.bottom.equalTo(midView.mas_bottom).offset(-15);
    //    }];
    [self.view layoutIfNeeded];
    NSLog(@"%f",[mainScroll.subviews lastObject].frame.origin.y);
    mainScroll.contentSize = CGSizeMake(mainScroll.frame.size.width, CGRectGetMaxY(midView.frame));
}



/**
 添加底部按钮
 */
- (void)addBottomView{
    TopView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-55, mainScroll.frame.size.width, 55)];
    [self.view addSubview:TopView];
    UIButton *SendHR = [[UIButton alloc] init];
    SendHR.layer.borderWidth = 1;
    SendHR.layer.borderColor = [UIColor colorWithHexString:@"#02c084"].CGColor;
    SendHR.layer.cornerRadius = 5;
    [SendHR addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [SendHR setTitle:@"给HR发消息" forState:UIControlStateNormal];
    [SendHR.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:16.0]]];
    [SendHR setTitleColor:[UIColor colorWithHexString:@"#02c084"] forState:UIControlStateNormal];
    [TopView addSubview:SendHR];
    UIButton *resume = [[UIButton alloc] init];
    [resume setBackgroundColor:[UIColor colorWithHexString:@"#02c084"]];
    resume.layer.cornerRadius = 5;
    if ([_type isEqualToString:@"1"]) {
        [resume setTitle:@"预约视频面试" forState:UIControlStateNormal];
    }
    else{
        [resume setTitle:@"投递简历" forState:UIControlStateNormal];
    }
    
    [resume addTarget:self action:@selector(resumeClick) forControlEvents:UIControlEventTouchUpInside];
    [resume.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:16.0]]];
    [resume setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [TopView addSubview:resume];
    [SendHR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopView.mas_top).offset(5);
        make.right.equalTo(resume.mas_left).offset(-15);
        make.left.equalTo(TopView.mas_left).offset(20);
        make.bottom.equalTo(TopView.mas_bottom).offset(-10);
        make.width.mas_equalTo(100);
    }];
    [resume mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(SendHR.mas_top);
        make.right.equalTo(TopView.mas_right).offset(-20);
        make.left.equalTo(SendHR.mas_right).offset(15);
        make.bottom.equalTo(SendHR.mas_bottom);
    }];
}


/**
 投递简历
 */
- (void)resumeClick{
    if ([_type isEqualToString:@"1"]) {
        AlertView *View = [[AlertView alloc]initWithFrame:[UIScreen mainScreen].bounds withTopTitleStr:@"确认预约" withContentStr:@"预约不可撤回，确定预约？" withPromptStr:@"（保持在线状态，随时接受视频面试邀请）" WithLoginButtonStr:@"等会再约" WithAppointmentButtonStr:@"立即预约"];
        [View show];
        View.enterBlock = ^(){
            AlertViewY *View = [[AlertViewY alloc] initWithFrame:[UIScreen mainScreen].bounds withTopTitleStr:@"预约成功" withContentStr:companyName.text withPromptStr:[NSString stringWithFormat:@"电话:%@",[datasource objectForKey:@"contact_tel"]] WithAgreeButtonStr:@"我知道了"];
            [View show];
        };
    }
    else{
        [self sendResume];
        
    }
    
}




- (void)setJobId:(NSString *)jobId{
    _jobId = jobId;
}

/**
 进入聊天页面
 */
- (void)sendMessage{
    
    
    ChatViewController *chat = [[ChatViewController alloc] initWithConversationChatter:@"zhjh5338" conversationType:EMConversationTypeChat];
    chat.topTitle = @"long0523";
    chat.address = @"西安市高新区科技二路清华科技园";
    chat.phone = @"029-123456";
    [self.navigationController pushViewController:chat animated:YES];
}



/**
 企业详情页面进入
 */
- (void)companyClick{
    companyController *companyDetail = [[companyController alloc] init];
    companyDetail.companyId = [datasource objectForKey:@"company_id"];
    companyDetail.topTitle = @"企业详情";
    [self.navigationController pushViewController:companyDetail animated:YES];
}



/**
 相关企业页面进入
 */
- (void)recruitClick{
    JobRecenceController *jobrecence = [[JobRecenceController alloc] init];
    jobrecence.topTitle = @"相关招聘会";
    jobrecence.position = [datasource objectForKey:@"position"];
    [self.navigationController pushViewController:jobrecence animated:YES];
    
}

/**
 收藏职位
 */
- (void)AddJobRecu{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            self.rightBut2.selected = !self.rightBut2.selected;
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              
                              @"job_id":_jobId,
                              @"status":self.rightBut2.selected == YES?@"0":@"1"
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:RECRUITADD interfaceTag:4];
}

/**
 获取职位详情
 */
- (void)getJobDetail{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            datasource = [dicData objectForKey:@"data"];
            [self setAllValue:datasource];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              
                              @"job_id":_jobId
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:GETJOBDETAIL interfaceTag:1];
}


/**
 设置每个数据
 
 @param dicData 得到的数据
 */
- (void)setAllValue:(NSDictionary *)dicData{
    [JobName setText:[dicData objectForKey:@"job_name"]];
    [date setText:[dicData objectForKey:@"add_time"]];
    [ps setText:[NSString stringWithFormat:@"共有%@场招聘会发布了该类型职位",[dicData objectForKey:@"jobfair_number"]]];
    [salary setText:[NSString stringWithFormat:@"¥%@/月",[dicData objectForKey:@"money"]]];
    [location setTitle:[dicData objectForKey:@"areas"] forState:UIControlStateNormal];
    [positionDetail setText:[dicData objectForKey:@"requirement"] == nil ?@"暂无信息":[dicData objectForKey:@"requirement"]];
    [Year setTitle:[dicData objectForKey:@"work_date"] forState:UIControlStateNormal];
    [OfficeDetail setText:[dicData objectForKey:@"introduction"] == nil ?@"暂无信息":[dicData objectForKey:@"introduction"]];
    [Degree setTitle:[dicData objectForKey:@"education"] forState:UIControlStateNormal];
    [companyName setText:[dicData objectForKey:@"company_name"]];
    [address setText:[dicData objectForKey:@"company_addr"]];
    //    [workTimeDetail setText:[dicData objectForKey:@"work_time"]];
    if ([[dicData objectForKey:@"collect_recruit"] integerValue] == 1) {
        self.rightBut2.selected = YES;
    }
    else{
        self.rightBut2.selected = NO;
    }
    [self.view layoutIfNeeded];
    
    mainScroll.contentSize = CGSizeMake(mainScroll.frame.size.width, CGRectGetMaxY(midView.frame));
}

/**
 投递简历
 */
- (void)sendResume{
    
    
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              @"job_id":_jobId,
                              
                              };//json data
    
    
    [request postAsynRequestBody:dicBody interfaceName:SENDRESUME interfaceTag:5 parType:0];
    
    
}


@end
