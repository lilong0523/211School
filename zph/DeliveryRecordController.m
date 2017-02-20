//
//  DeliveryRecordController.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "DeliveryRecordController.h"
#import "DeliveryRecordCell.h"
#import "JobDetailController.h"

@interface DeliveryRecordController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DeliveryRecordController
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
        if (datasource.count > 0) {
            [self getSend:[NSString stringWithFormat:@"%@",[[datasource lastObject] objectForKey:@"id"]] pull:@"0"];
        }
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    datasource = [[NSMutableArray alloc] initWithCapacity:0];
    [self addListView];
    [self getSend:@"" pull:@"0"];
    [self addMJRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addListView{
    listView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+10, self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame)-10)];
    listView.delegate = self;
    listView.dataSource = self;
    listView.bounces = NO;
    listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    listView.layer.cornerRadius = 3;
    listView.layer.masksToBounds = YES;
    listView.showsHorizontalScrollIndicator = NO;
    listView.showsVerticalScrollIndicator = NO;
    listView.backgroundColor = [UIColor clearColor];
    listView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:listView];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *ID =@"cellID1";
    
    DeliveryRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DeliveryRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
        
    }
    cell.model = [datasource objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datasource.count;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JobDetailController *job = [[JobDetailController alloc] init];
    job.topTitle = @"职位详情";
    job.jobId = [[datasource objectAtIndex:indexPath.row] objectForKey:@"job_id"];
    
    [self.navigationController pushViewController:job animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93;
}


/**
 获取我的投递列表
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
    
    
    [request getHttpRequest:dicBody interfaceName:STUSEND interfaceTag:1];
}
- (void)endRefresh{
    [listView.mj_header endRefreshing];
    [listView.mj_footer endRefreshing];
}

@end
