//
//  JobRecenceController.m
//  zph
//
//  Created by 李龙 on 2017/1/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "JobRecenceController.h"
#import "SearchMainCell.h"
#import "HM_HomeModel.h"
#import "SCH_SchollDetailController.h"
#import "NET_recrutiDetailController.h"

@interface JobRecenceController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JobRecenceController
{
    UITableView *listView;
    NSMutableArray *datasource;
}

/**
 添加上下拉
 */
- (void)addMJRefresh{
    
    
    listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (datasource.count>0) {
            [self searchRecrutiInf:[[datasource lastObject] objectForKey:@"id"] pull:@"0"];
        }
        else{
             [listView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    datasource = [[NSMutableArray alloc] initWithCapacity:0];
    // Do any additional setup after loading the view.
    [self addListView];
    [self addMJRefresh];
    [self searchRecrutiInf:@"" pull:@"0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addListView{

    //数据列表
    listView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame))];
    listView.dataSource = self;
    listView.delegate = self;
    
    listView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    listView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:listView];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID =@"cellID";
    SearchMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SearchMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dic = [datasource objectAtIndex:indexPath.row];
    
    return cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return datasource.count;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[[datasource objectAtIndex:indexPath.row] objectForKey:@"job_fair_type"] isEqualToString:@"netcongress"]) {
        NET_recrutiDetailController *detail = [[NET_recrutiDetailController alloc] init];
        detail.topTitle = @"网络招聘会";
        detail.recrutId = [[datasource objectAtIndex:indexPath.row] objectForKey:@"id"];
        [self.navigationController pushViewController:detail animated:YES];

    }
    else{
        SCH_SchollDetailController *detail = [[SCH_SchollDetailController alloc] init];
        detail.topTitle = @"校园招聘会";
        detail.recrutId = [[datasource objectAtIndex:indexPath.row] objectForKey:@"id"];
        [self.navigationController pushViewController:detail animated:YES];

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}




/**
 搜索招聘会
 */
- (void)searchRecrutiInf:(NSString *)rowNum pull:(NSString *)IfPull{
    
   
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
                    for (NSDictionary *tem in [dicData objectForKey:@"data"]) {
                        
                        [datasource addObject:tem];
                        
                    }
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
                                      @"id":rowNum?rowNum:@"",
                                      @"direction":@"0",
                                      @"position":_position,
                                     
                                      };//json data
            
            
            [request getHttpRequest:dicBody interfaceName:POSITIONJOBFAIR interfaceTag:1];
    
}
- (void)endRefresh{
    [listView.mj_header endRefreshing];
    [listView.mj_footer endRefreshing];
}


@end
