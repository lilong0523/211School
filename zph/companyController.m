//
//  companyController.m
//  zph
//
//  Created by 李龙 on 2016/12/25.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "companyController.h"
#import "companyIntroductCell.h"
#import "positionCell.h"
#import "JobDetailController.h"
#import <UShareUI/UShareUI.h>

@interface companyController ()<UITableViewDelegate,UITableViewDataSource,companyIntroductdelegate>

@end

@implementation companyController
{
    UITableView *mainTable;
    UIView *headView;//头部
    BOOL isOpen;//判断是否展开
    
    NSMutableDictionary *datasource;//获取的数据
    UIImageView *logoImage;//企业logo
    UILabel *companyName;//企业名称
    UILabel *otherDetail;//企业详情
    UILabel *address;//企业地址
    
    NSMutableArray *jobListArry;//职位数组
    
}

/**
 添加上下拉
 */
- (void)addMJRefresh{
    
    
    mainTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        posionModel *model = [jobListArry lastObject];
        [self getJobListInfo:model.NET_ID pull:@"0"];
    }];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    jobListArry = [[NSMutableArray alloc] initWithCapacity:0];
    [self.rightBut2 setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    [self.rightBut2 addTarget:self action:@selector(shareBut) forControlEvents:UIControlEventTouchUpInside];
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

- (void)addHeadView{
    
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+10, self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame)-10) ];
    mainTable.delegate = self;
    mainTable.bounces = NO;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.dataSource = self;
    mainTable.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:mainTable];
    headView = [[UIView alloc] init];
    mainTable.tableHeaderView = headView;
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(mainTable.frame.size.width);
    }];
    
    logoImage = [[UIImageView alloc] init];
    [logoImage setContentMode:UIViewContentModeScaleAspectFit];
    [logoImage setImage:[UIImage imageNamed:@"icon_bottom_noselect4"]];
    [headView addSubview:logoImage];
    companyName = [[UILabel alloc] init];
    [companyName setText:@""];
    [companyName setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [companyName setTextColor:JOBNAME_COLOR];
    [headView addSubview:companyName];
    otherDetail = [[UILabel alloc] init];
    [otherDetail setText:@""];
    [otherDetail setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [otherDetail setTextColor:COMPANY_COLOR];
    [headView addSubview:otherDetail];
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:LINE_COLOR];
    [headView addSubview:line];
    
    //地址栏
    UIView *addressView = [[UIView alloc] init];
    [headView addSubview:addressView];
    
    
    
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_top).offset(15);
        make.centerX.equalTo(headView.mas_centerX);
        make.width.mas_equalTo(59);
        make.height.mas_equalTo(59);
    }];
    [companyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImage.mas_bottom).offset(10);
        make.centerX.equalTo(logoImage.mas_centerX);
        make.bottom.equalTo(otherDetail.mas_top).offset(-12);
    }];
    [otherDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(companyName.mas_bottom).offset(12);
        make.centerX.equalTo(logoImage.mas_centerX);
        make.bottom.equalTo(line.mas_top).offset(-10);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(otherDetail.mas_bottom).offset(10);
        make.left.equalTo(headView.mas_left);
        make.right.equalTo(headView.mas_right);
        make.bottom.equalTo(addressView.mas_top);
        make.height.mas_equalTo(1);
    }];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(line.mas_left);
        make.right.equalTo(line.mas_right);
        make.bottom.equalTo(headView.mas_bottom);
    }];
    
    //地址栏信息
    UIImageView *locationImage = [[UIImageView alloc] init];
    [locationImage setContentMode:UIViewContentModeScaleAspectFit];
    [locationImage setImage:[UIImage imageNamed:@"icon_location2"]];
    [addressView addSubview:locationImage];
    address = [[UILabel alloc] init];
    [address setText:@""];
    [address setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [address setTextColor:JOBNAME_COLOR];
    [addressView addSubview:address];
    [locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressView.mas_top).offset(15);
        make.left.equalTo(addressView.mas_left).offset(20);
        make.right.equalTo(address.mas_left).offset(-10);
        make.bottom.equalTo(addressView.mas_bottom).offset(-15);
        make.width.mas_equalTo(15);
    }];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(locationImage.mas_centerY);
        make.left.equalTo(locationImage.mas_right).offset(10);
        make.right.equalTo(addressView.mas_right).offset(-10);
        
    }];
    
    
    [mainTable layoutIfNeeded];
    mainTable.tableHeaderView = headView;
    
}



/**
 查看更多刷新页面
 
 @param ifOpen p
 */
- (void)updateDetail:(BOOL)ifOpen{
    isOpen = ifOpen;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [mainTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        static NSString *ID =@"cellID";
        companyIntroductCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[companyIntroductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        
        cell.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isOpen = isOpen;
        cell.detailText = [datasource objectForKey:@"company_info"];
        
        return cell;
    }
    else{
        static NSString *ID =@"cellID22";
        positionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[positionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        posionModel *model = [jobListArry objectAtIndex:indexPath.row];
        cell.model = model;
        
        return cell;
    }
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else{
        return jobListArry.count;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        JobDetailController *jobDetail = [[JobDetailController alloc] init];
        jobDetail.jobId = ((posionModel *)[jobListArry objectAtIndex:indexPath.row]).NET_ID;
        
        jobDetail.topTitle = @"职位详情";
        jobDetail.type = _type;
        [self.navigationController pushViewController:jobDetail animated:YES];
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [self tableView:mainTable cellForRowAtIndexPath:indexPath];
        companyIntroductCell *tem = (companyIntroductCell *)cell;
        
        return tem.frame.size.height;
    }
    else{
        return 60;
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
        [title setText:@"公司介绍"];
        return sectionView;
    }
    else{
        
        [title setText:@"招聘职位"];
        return sectionView;
    }
    
}


/**
 获取企业详情
 */
- (void)getJobDetail{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            datasource = [dicData objectForKey:@"data"];
            [self setAllValue:datasource];
            [mainTable reloadData];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              
                              @"company_id":_companyId
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:GETCOMPANYDETAIL interfaceTag:1];
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
            else
            {
                if ([rowNum isEqualToString:@""]) {
                    [jobListArry removeAllObjects];
                }
                for (NSDictionary *tem in [dicData objectForKey:@"data"]) {
                    
                    posionModel *model = [[posionModel alloc] initWithDic:tem];
                    [jobListArry addObject:model];
                    
                    
                }
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
                              @"company_id":_companyId
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:GETCOMPANYJOBLIST interfaceTag:2];
}


/**
 设置每个数据
 
 @param dicData 得到的数据
 */
- (void)setAllValue:(NSDictionary *)dicData{
    
    [address setText:[dicData objectForKey:@"company_addr"]];
    [otherDetail setText:[NSString stringWithFormat:@"%@|%@|%@",[dicData objectForKey:@"company_nature"],[dicData objectForKey:@"company_person_num"],[dicData objectForKey:@"industry_name"]]];
    
    [companyName setText:[dicData objectForKey:@"company_name"]];
    
    
    NSURL *url = [NSURL URLWithString:[dicData objectForKey:@"company_logo"]];
    [logoImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:[dicData objectForKey:@"industry"]]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
