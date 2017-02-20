//
//  SCH_SchoolController.m
//  zph
//
//  Created by 李龙 on 2016/12/27.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "SCH_SchoolController.h"
#import "BaseTextfield2.h"
#import "SCH_SchoolCell.h"
#import "SCH_SchollDetailController.h"


@interface SCH_SchoolController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SCH_SchoolController
{
    NSMutableArray *datasource;//数据
    UITableView *listView;//列表
    BaseTextfield2 *searchText;//搜索框
    
    AppDelegate *app;
}

/**
 添加上下拉
 */
- (void)addMJRefresh{
    
    listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        [self searchRecrutiInfo:searchText.text rowNum:@"" pull:@"0"];
        
    }];
    listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (datasource.count>0) {
            SCH_SchoolModel *model = [datasource lastObject];
            [self searchRecrutiInfo:searchText.text rowNum:model.NET_ID pull:@"0"];
        }
        
    }];
    
    
    [listView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.leftBut.hidden = YES;
    datasource = [[NSMutableArray alloc] initWithCapacity:0];
    app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view.
    
    [self addSearchView];
    [self addListView];
    [self addMJRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 添加搜索头
 */
- (void)addSearchView{
    __block SCH_SchoolController *selfBlock = self;
    searchText = [[BaseTextfield2 alloc] init];
    searchText.placeHold = @"搜索校园招聘会";
    searchText.SearchBlock = ^(NSString *text){
        [selfBlock->datasource removeAllObjects];
        [selfBlock searchRecrutiInfo:text rowNum:@"" pull:@"0"];
    };
    [self.topView addSubview:searchText];
    [searchText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(10);
        make.bottom.equalTo(self.topView.mas_bottom).offset(-5);
        make.right.equalTo(self.topView.mas_right).offset(-12);
        make.height.mas_equalTo(32);
    }];
}

/**
 添加列表
 */
- (void)addListView{
    listView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame)-48)];
    listView.dataSource = self;
    listView.delegate = self;
    
    listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    listView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:listView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID =@"cellID";
    
    SCH_SchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SCH_SchoolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SCH_SchoolModel *model = [datasource objectAtIndex:indexPath.row];

    cell.model = model;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return datasource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SCH_SchollDetailController *detail = [[SCH_SchollDetailController alloc] init];
    detail.topTitle = @"校园招聘会";
    detail.recrutId = ((SCH_SchoolModel *)[datasource objectAtIndex:indexPath.row]).NET_jobId;
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


/**
 获取网络招聘会列表
 */
- (void)getRecruitInfo:(NSString *)rowNum pull:(NSString *)IfPull{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [self endRefresh];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            if ([[dicData objectForKey:@"data"] count] == 0) {
                [listView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                if ([rowNum isEqualToString:@""]) {
                    [datasource removeAllObjects];
                    
                }
                for (NSDictionary *tem in [dicData objectForKey:@"data"]) {
                    
                    SCH_SchoolModel *model = [[SCH_SchoolModel alloc] initWithDic:tem];
                    [datasource addObject:model];
                    
                }
                [listView reloadData];
            }
            
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
                              @"siteid":app.siteid
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:GETNETJOB interfaceTag:1];
}

/**
 搜索校园招聘会
 */
- (void)searchRecrutiInfo:(NSString *)searchStr rowNum:(NSString *)rowNum pull:(NSString *)IfPull{
    
    if (searchStr != nil) {
        if ([searchStr isEqualToString:@""]) {
            [self getRecruitInfo:rowNum pull:IfPull];
        }
        else{
            HttpRequestModel *request = [[HttpRequestModel alloc] init];
            request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
                [self endRefresh];
                if ([[dicData objectForKey:@"code"] integerValue] == 0) {
                    
                    if ([[dicData objectForKey:@"data"] count] == 0) {
                        [listView.mj_footer endRefreshingWithNoMoreData];
                    }
                    else{
                        if ([rowNum isEqualToString:@""]) {
                            [datasource removeAllObjects];
                        }
                        for (NSDictionary *tem in [dicData objectForKey:@"data"]) {
                            
                            SCH_SchoolModel *model = [[SCH_SchoolModel alloc] initWithDic:tem];
                            [datasource addObject:model];
                            
                            
                        }
                        
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
                                      @"siteid":app.siteid,
                                      @"id":rowNum,
                                      @"direction":IfPull,
                                      @"job_fair_name":searchStr,
                                      @"job_fair_type":@"multiple",
                                      };//json data
            
            
            [request getHttpRequest:dicBody interfaceName:SEARCHJOBFAIR interfaceTag:2];
        }
        
    }
    
    
}


- (void)endRefresh{
    [listView.mj_header endRefreshing];
    [listView.mj_footer endRefreshing];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
