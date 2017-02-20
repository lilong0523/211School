//
//  MyCollectionController.m
//  zph
//
//  Created by 李龙 on 2017/1/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "MyCollectionController.h"
#import "myRecruitmentCell.h"
#import "myPositionCell.h"
#import "JobDetailController.h"
#import "NET_recrutiDetailController.h"
#import "SCH_SchollDetailController.h"

@interface MyCollectionController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation MyCollectionController
{
    UIButton *myInterview;//招聘会
    UIButton *myMessage;//职位
    UIView *bottomLine;//下划线
    
    UITableView *listView;
    NSMutableArray *datasource;//招聘会数组
    NSMutableArray *jobArry;//职位数组
    UIView *selectView;
    NSInteger _currentType;
}

/**
 添加上下拉
 */
- (void)addMJRefresh{
    
    
    listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (_currentType == 1) {
            if (datasource.count > 0) {
                [self getSend:[NSString stringWithFormat:@"%@",[[datasource lastObject] objectForKey:@"id"]] pull:@"0"];
            }
            
        }
        else{
            if (jobArry.count>0) {
                [self getJob:[NSString stringWithFormat:@"%@",[[jobArry lastObject] objectForKey:@"id"]] pull:@"0"];
            }
        }
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentType = 1;
    // Do any additional setup after loading the view.
    datasource = [[NSMutableArray alloc] initWithCapacity:0];
    jobArry = [[NSMutableArray alloc] initWithCapacity:0];
    [self addTopView];
    [self addListView];
    [self getSend:@"" pull:@"0"];
    [self getJob:@"" pull:@"0"];
    [self addMJRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 添加头部
 */
- (void)addTopView{
    
    selectView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, 44)];
    [selectView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:selectView];
    
    UIView *Topline = [[UIView alloc] initWithFrame:CGRectMake(0, selectView.frame.size.height-1, selectView.frame.size.width, 1)];
    [Topline setBackgroundColor:COMPANY_COLOR];
    [selectView addSubview:Topline];
    
    myInterview = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, selectView.frame.size.height-1)];
    [myInterview setTitle:@"招聘会" forState:UIControlStateNormal];
    myInterview.tag = 1;
    [myInterview setBackgroundColor:[UIColor whiteColor]];
    [myInterview addTarget:self action:@selector(SelectClick:) forControlEvents:UIControlEventTouchUpInside];
    [myInterview setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
    [myInterview setTitleColor:SALAARYDETAIL_COLOR forState:UIControlStateSelected];
    [myInterview.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:18.0]]];
    [selectView addSubview:myInterview];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(myInterview.frame), myInterview.frame.origin.y+13, 1, 18)];
    [line setBackgroundColor:COMPANY_COLOR];
    [selectView addSubview:line];
    myMessage= [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), myInterview.frame.origin.y, myInterview.frame.size.width, myInterview.frame.size.height)];
    myMessage.tag = 0;
    [myMessage setBackgroundColor:[UIColor whiteColor]];
    [myMessage setTitle:@"职位" forState:UIControlStateNormal];
    [myMessage addTarget:self action:@selector(SelectClick:) forControlEvents:UIControlEventTouchUpInside];
    [myMessage setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
    [myMessage setTitleColor:SALAARYDETAIL_COLOR forState:UIControlStateSelected];
    [myMessage.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:18.0]]];
    [selectView addSubview:myMessage];
    
    
    bottomLine = [[UIView alloc] initWithFrame:CGRectMake(myInterview.center.x-36, CGRectGetMaxY(myInterview.frame)-2, 72, 2)];
    [bottomLine setBackgroundColor:SALAARYDETAIL_COLOR];
    [selectView addSubview:bottomLine];
    
    if (_currentType == 0) {
        myInterview.selected = NO;
        myMessage.selected = YES;
        bottomLine.frame = CGRectMake(myMessage.center.x-36, CGRectGetMaxY(myMessage.frame)-2, 72, 2);
    }
    else{
        myInterview.selected = YES;
        myMessage.selected = NO;
        bottomLine.frame = CGRectMake(myInterview.center.x-36, CGRectGetMaxY(myInterview.frame)-2, 72, 2);
    }
}

- (void)SelectClick:(UIButton *)but{
    _currentType = but.tag;
    if (but.tag == 0) {
        myInterview.selected = NO;
        myMessage.selected = YES;
        bottomLine.frame = CGRectMake(myMessage.center.x-36, CGRectGetMaxY(myMessage.frame)-2, 72, 2);
        
    }
    else{
        myInterview.selected = YES;
        myMessage.selected = NO;
        bottomLine.frame = CGRectMake(myInterview.center.x-36, CGRectGetMaxY(myInterview.frame)-2, 72, 2);
    }
    [listView reloadData];
}

- (void)addListView{
    listView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(selectView.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(selectView.frame))];
    listView.delegate = self;
    listView.dataSource = self;
    listView.bounces = NO;
    listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    listView.showsHorizontalScrollIndicator = NO;
    listView.showsVerticalScrollIndicator = NO;
    listView.backgroundColor = [UIColor whiteColor];
    listView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:listView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_currentType == 1) {
        static NSString *ID =@"cellID1";
        
        myRecruitmentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[myRecruitmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        cell.model = [datasource objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else{
        static NSString *ID =@"cellID2";
        
        myPositionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[myPositionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        cell.model = [jobArry objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentType == 1) {
        return datasource.count;
    }
    else{
       return jobArry.count;
    }
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_currentType == 1) {
        if ([[[datasource objectAtIndex:indexPath.row] objectForKey:@"job_fair_type"] isEqualToString:@"netcongress"]) {
            NET_recrutiDetailController *detail = [[NET_recrutiDetailController alloc] init];
            detail.topTitle = @"网络招聘会";
            detail.recrutId = [NSString stringWithFormat:@"%@",[[datasource objectAtIndex:indexPath.row] objectForKey:@"job_fair_id"]];
            [self.navigationController pushViewController:detail animated:YES];
        }
        else{
            SCH_SchollDetailController *detail = [[SCH_SchollDetailController alloc] init];
            detail.topTitle = @"校园招聘会";
            detail.recrutId = [NSString stringWithFormat:@"%@",[[datasource objectAtIndex:indexPath.row] objectForKey:@"job_fair_id"]];
            [self.navigationController pushViewController:detail animated:YES];
        }
    }
    else{
        JobDetailController *job = [[JobDetailController alloc] init];
        job.topTitle = @"职位详情";
        job.jobId = [[jobArry objectAtIndex:indexPath.row] objectForKey:@"recruit_id"];
        [job setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:job animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentType == 1) {
        return 90;
    }
    else{
        return 93;
    }
    
}

/**
 获取收藏的招聘会列表
 */
- (void)getSend:(NSString *)rowNum pull:(NSString *)IfPull{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [self endRefresh];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            if ([rowNum isEqualToString:@""]) {
                [datasource removeAllObjects];
            }
            if ([[dicData objectForKey:@"data"] count] == 0) {
                [listView.mj_footer endRefreshingWithNoMoreData];
            }
            [datasource addObjectsFromArray:[dicData objectForKey:@"data"]];
            
            [listView reloadData];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        [self endRefresh];
    };
    NSDictionary *dicBody = @{
                              @"id":rowNum,
                              @"direction":IfPull,
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:JOBFAIRLIST interfaceTag:1];
}

/**
 获取收藏的职位列表
 */
- (void)getJob:(NSString *)rowNum pull:(NSString *)IfPull{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [self endRefresh];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            if ([rowNum isEqualToString:@""]) {
                [jobArry removeAllObjects];
            }
            if ([[dicData objectForKey:@"data"] count] == 0) {
                [listView.mj_footer endRefreshingWithNoMoreData];
            }
            [jobArry addObjectsFromArray:[dicData objectForKey:@"data"]];
            
            [listView reloadData];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        [self endRefresh];
    };
    NSDictionary *dicBody = @{
                              @"id":rowNum,
                              @"direction":IfPull,
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:RECRUITLIST interfaceTag:2];
}

- (void)endRefresh{
    [listView.mj_header endRefreshing];
    [listView.mj_footer endRefreshing];
}

@end
