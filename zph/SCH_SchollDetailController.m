//
//  SCH_SchollDetailController.m
//  zph
//
//  Created by 李龙 on 2017/1/16.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "SCH_SchollDetailController.h"
#import "NET_recrutiDetailCell.h"
#import "SCH_schoolDetailCell.h"
#import "companyController.h"
#import <UShareUI/UShareUI.h>

@interface SCH_SchollDetailController ()<UITableViewDataSource,UITableViewDelegate,NET_recrutiDetaildelegate>

@end

@implementation SCH_SchollDetailController
{
    UITableView *mainTable;
    NSMutableDictionary *datasource;
    NSMutableArray *companyArry;//参会企业数组
    UIView *headView;//头部
    BOOL isOpen;//判断是否展开
    
    UILabel *timeStr;//时间
    UILabel *companyName;//公司名
    UILabel *EducationStr;//学历
    UILabel *TypeStr;//类型
    UILabel *hostStr;//主办方
    UILabel *Contractors;//承办方
    UILabel *guide;//指导单位
}
/**
 添加上下拉
 */
- (void)addMJRefresh{
    
    
    mainTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self getJobListInfo:[[companyArry lastObject] objectForKey:@"id"] pull:@"0"];
    }];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    datasource = [[NSMutableDictionary alloc] initWithCapacity:0];
    companyArry = [[NSMutableArray alloc] initWithCapacity:0];
    [self.rightBut1 setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    [self.rightBut1 addTarget:self action:@selector(shareBut) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setImage:[UIImage imageNamed:@"icon_star"] forState:UIControlStateNormal];
    [self.rightBut2 addTarget:self action:@selector(CollectionBut) forControlEvents:UIControlEventTouchUpInside];
    [self addHeadView];
    [self getJobDetail];
    [self addMJRefresh];
    [self getJobListInfo:@"" pull:@"0"];
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
 收藏招聘会
 */
- (void)CollectionBut{
    [self AddJobRecu];
}

/**
 收藏招聘会
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
                              
                              @"job_fair_id":_recrutId,
                              @"status":self.rightBut2.selected == YES?@"0":@"1"
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:JOBFAIRADD interfaceTag:4];
}

- (void)addHeadView{
    
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame)) ];
    [mainTable setBackgroundColor:[UIColor whiteColor]];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    mainTable.bounces = NO;
    
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:mainTable];
    headView = [[UIView alloc] init];
    [headView setBackgroundColor:[UIColor whiteColor]];
    mainTable.tableHeaderView = headView;
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(mainTable.frame.size.width);
        make.height.mas_equalTo(190);
    }];
    
    companyName = [[UILabel alloc] init];
    companyName.numberOfLines = 2;
    [companyName setTextAlignment:NSTextAlignmentCenter];
    [companyName setText:@""];
    [companyName setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [companyName setTextColor:JOBNAME_COLOR];
    [headView addSubview:companyName];
    
    //时间
    UIImageView *time = [[UIImageView alloc] init];
    [time setImage:[UIImage imageNamed:@"icon_time-1"]];
    [time setContentMode:UIViewContentModeScaleAspectFit];
    [headView addSubview:time];
    
    timeStr = [[UILabel alloc] init];
    [timeStr setTextColor:COMPANY_COLOR];
    [timeStr setText:@""];
    [timeStr setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [headView addSubview:timeStr];
    
    //学历
    UIImageView *Education = [[UIImageView alloc] init];
    [Education setImage:[UIImage imageNamed:@"icon_floor"]];
    [Education setContentMode:UIViewContentModeScaleAspectFit];
    [headView addSubview:Education];
    
    EducationStr = [[UILabel alloc] init];
    [EducationStr setTextColor:COMPANY_COLOR];
    [EducationStr setText:@""];
    [EducationStr setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [headView addSubview:EducationStr];
    //类型
    UIImageView *Type = [[UIImageView alloc] init];
    [Type setImage:[UIImage imageNamed:@"icon_Features"]];
    [Type setContentMode:UIViewContentModeScaleAspectFit];
    [headView addSubview:Type];
    
    TypeStr = [[UILabel alloc] init];
    [TypeStr setTextColor:COMPANY_COLOR];
    [TypeStr setText:@""];
    [TypeStr setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [headView addSubview:TypeStr];
    //主办
    UIImageView *host = [[UIImageView alloc] init];
    
    [host setImage:[UIImage imageNamed:@"icon_host"]];
    [host setContentMode:UIViewContentModeScaleAspectFit];
    [headView addSubview:host];
    
    hostStr = [[UILabel alloc] init];
    [hostStr setTextColor:COMPANY_COLOR];
    [hostStr setText:@"主办单位:"];
    [hostStr setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [headView addSubview:hostStr];
    //承办
    Contractors = [[UILabel alloc] init];
    [Contractors setTextColor:COMPANY_COLOR];
    [Contractors setText:@"承办单位:"];
    [Contractors setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [headView addSubview:Contractors];
    //指导
    //    guide = [[UILabel alloc] init];
    //    [guide setTextColor:COMPANY_COLOR];
    //    [guide setText:@"指导单位:陕西省高等职业技术学校"];
    //    [guide setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    //    [headView addSubview:guide];
    
    [companyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_top).offset(10);
        make.centerX.equalTo(headView.mas_centerX);
        make.right.equalTo(headView.mas_right).offset(-20);
        make.left.equalTo(headView.mas_left).offset(20);
    }];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(companyName.mas_bottom).offset(10);
        make.left.equalTo(companyName.mas_left);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [timeStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(time.mas_right).offset(10);
        make.centerY.equalTo(time.mas_centerY);
        
    }];
    [Education mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(time.mas_bottom).offset(10);
        make.left.equalTo(time.mas_left);
        make.right.equalTo(time.mas_right);
        make.width.mas_equalTo(time.mas_width);
        make.height.mas_equalTo(time.mas_height);
    }];
    [EducationStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Education.mas_right).offset(10);
        make.centerY.equalTo(Education.mas_centerY);
    }];
    [Type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Education.mas_bottom).offset(10);
        make.left.equalTo(Education.mas_left);
        make.right.equalTo(Education.mas_right);
        make.width.mas_equalTo(Education.mas_width);
        make.height.mas_equalTo(Education.mas_height);
    }];
    [TypeStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Type.mas_right).offset(10);
        make.centerY.equalTo(Type.mas_centerY);
    }];
    [host mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Type.mas_bottom).offset(10);
        make.left.equalTo(Type.mas_left);
        make.right.equalTo(Type.mas_right);
        make.width.mas_equalTo(Type.mas_width);
        make.height.mas_equalTo(Type.mas_height);
    }];
    [hostStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(host.mas_right).offset(10);
        make.right.equalTo(headView.mas_right).offset(-20);
        make.centerY.equalTo(host.mas_centerY);
    }];
    [Contractors mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hostStr.mas_left);
        make.right.equalTo(hostStr.mas_right);
        make.top.equalTo(hostStr.mas_bottom).offset(10);
        make.bottom.equalTo(headView.mas_bottom).offset(-10);
        make.height.mas_equalTo(15);
    }];
    //    [guide mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(Contractors.mas_left);
    //        make.top.equalTo(Contractors.mas_bottom).offset(10);
    //        make.bottom.equalTo(headView.mas_bottom).offset(-10);
    //    }];
    
    
    [mainTable layoutIfNeeded];
    mainTable.tableHeaderView = headView;
    
}

/**
 获取招聘会详情
 */
- (void)getJobDetail{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            datasource = [dicData objectForKey:@"data"];
            [self reloadInfo];
            [mainTable reloadData];
            
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              
                              @"job_fair_id":_recrutId
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:GETfairDETAIL interfaceTag:1];
}


/**
 加载数据
 */
- (void)reloadInfo{
    [companyName setText:[datasource objectForKey:@"job_fair_name"]];
    [timeStr setText:[NSString stringWithFormat:@"%@-%@",[datasource objectForKey:@"job_fair_time"],[datasource objectForKey:@"job_fair_overtime"]]];
    [EducationStr setText:[datasource objectForKey:@"job_fair_level"]];
    [TypeStr setText:[datasource objectForKey:@"job_fair_feature"]];
    [hostStr setText:[NSString stringWithFormat:@"主办单位：%@",[datasource objectForKey:@"school_name"]]];
    [Contractors setText:[NSString stringWithFormat:@"承办单位：%@",[datasource objectForKey:@"job_fair_sponsor"]]];
    if ([[datasource objectForKey:@"collect_jobfair"] integerValue] == 1) {
        self.rightBut2.selected = YES;
    }
    else{
        self.rightBut2.selected = NO;
    }
}


/**
 查看更多刷新页面
 
 @param ifOpen p
 */
- (void)updateDetail:(BOOL )ifOpen{
    isOpen = ifOpen;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [mainTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        static NSString *ID =@"cellID";
        NET_recrutiDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[NET_recrutiDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        
        cell.delegate = self;
        cell.isOpen = isOpen;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailText = [[datasource objectForKey:@"job_fair_invitation"] isEqualToString:@""]?@"暂无信息！":[datasource objectForKey:@"job_fair_invitation"];
        return cell;
    }
    else{
        static NSString *ID =@"cellID22";
        SCH_schoolDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[SCH_schoolDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = [companyArry objectAtIndex:indexPath.row];
        
        return cell;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else{
        return companyArry.count;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        companyController *companyDetail = [[companyController alloc] init];
        companyDetail.companyId = [[companyArry objectAtIndex:indexPath.row] objectForKey:@"company_id"];
        companyDetail.topTitle = @"企业详情";
        [self.navigationController pushViewController:companyDetail animated:YES];
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [self tableView:mainTable cellForRowAtIndexPath:indexPath];
        NET_recrutiDetailCell *tem = (NET_recrutiDetailCell *)cell;
        
        return tem.frame.size.height;
    }
    else{
        return 40;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 42)];
    [sectionView setBackgroundColor:BACKGROUND_COLOR];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, sectionView.frame.size.width-40, sectionView.frame.size.height)];
    [title setTextAlignment:NSTextAlignmentLeft];
    [title setTextColor:JOBNAME_COLOR];
    [title setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [sectionView addSubview:title];
    if (section == 0) {
        [title setText:@"邀请函"];
        return sectionView;
    }
    else{
        
        [title setText:@"参会企业"];
        return sectionView;
    }
    
}

- (void)endRefresh{
    [mainTable.mj_header endRefreshing];
    [mainTable.mj_footer endRefreshing];
}

/**
 获取企业招聘职位列表
 */
- (void)getJobListInfo:(NSString *)rowNum pull:(NSString *)IfPull{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [self endRefresh];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            if ([[dicData objectForKey:@"data"] count] == 0) {
                [mainTable.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                if ([rowNum isEqualToString:@""]) {
                    [companyArry removeAllObjects];
                }
                [companyArry addObjectsFromArray:[dicData objectForKey:@"data"]];;
                
                [mainTable reloadData];
            }
            
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              @"id":rowNum,
                              @"direction":IfPull,
                              @"job_fair_id":_recrutId
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:GETSCHOOLJOBCOMPANY interfaceTag:2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
