//
//  SearchPageController.m
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "SearchPageController.h"
#import "SearchLocalCell.h"
#import "HM_HomePageCell.h"
#import "JobDetailController.h"
#import "SearchMainCell.h"
#import "NET_recrutiDetailController.h"
#import "SCH_SchollDetailController.h"

@interface SearchPageController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation SearchPageController
{
    UIView *cover;
    NSMutableArray *hotSearchArry;//热门搜索数组
    UIView *conterView;//热门搜索view
    UITextField *searchText;//搜索栏
    UIButton *selectType;//类别选项按钮
    UIView *buttonView;//选项view
    
    UIView *selectDir;
    
    UITableView *localSearch;
    UITableView *listView;
    NSMutableArray *localSearchArry;//搜索记录
    NSMutableArray *datasource;//搜索数据
    
    NSInteger currentSearchType;//当期搜索类型 招聘会还是职位  0招聘会  1职位
    
    AppDelegate *app;
    
    NSInteger total;//总共记录数
}

/**
 添加上下拉
 */
- (void)addMJRefresh{
    
    
    listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (currentSearchType == 0) {
            [self searchRecrutiInfo:searchText.text rowNum:[NSString stringWithFormat:@"%@",[[datasource lastObject] objectForKey:@"id"]] pull:@"0"];
        }
        else{
            HM_HomeModel *model = [datasource lastObject];
            [self getSearchInfo:searchText.text rowNum:model.M_ID pull:@"0"];
        }
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    localSearchArry = [[NSMutableArray alloc] initWithCapacity:0];
    datasource = [[NSMutableArray alloc] initWithCapacity:0];
    hotSearchArry = [[NSMutableArray alloc] initWithCapacity:0];
    currentSearchType = 0;
    total = 0;
    // Do any additional setup after loading the view.
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.leftBut.hidden = YES;
    
    [self.rightBut2 setTitle:@"取消" forState:UIControlStateNormal];
    [self.rightBut2 addTarget:self action:@selector(cancelBut) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setTitleColor:JOBNAME_COLOR forState:UIControlStateNormal];
    
    [self addSearchView];
    [self selectTypeSelect];
    [self addListView];
    [self AddHotView];
    [self getLocationSearch];
    [self addMJRefresh];
    [self getHotSearch];
    [self searchRecrutiInfo:searchText.text rowNum:@"" pull:@"0"];
    
}


/**
 获取本地搜索历史
 */
- (void)getLocationSearch{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:@"hotSearch"]) {
        [localSearchArry removeAllObjects];
        [localSearchArry addObjectsFromArray:[defaults valueForKey:@"hotSearch"]];
//        [[defaults valueForKey:@"hotSearch"] addObject:searchText.text];
    }
    else{
        NSMutableArray *arry = [[NSMutableArray alloc] initWithCapacity:0];
        [defaults setValue:arry forKey:@"hotSearch"];
    }
    [localSearch reloadData];
}

/**
 热门搜索view
 */
- (void)AddHotView{
    selectDir = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame))];
    [selectDir setBackgroundColor:BACKGROUND_COLOR];
    selectDir.hidden = YES;
    [self.view addSubview:selectDir];
    UILabel *ps = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 15)];
    [ps setTextColor:JOBNAME_COLOR];
    [ps setFont:[UIFont systemFontOfSize:13.0]];
    [ps setTextAlignment:NSTextAlignmentLeft];
    [ps setText:@"热门搜索"];
    [selectDir addSubview:ps];
    
    conterView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(ps.frame)+10, selectDir.frame.size.width-20, 100)];
    [selectDir addSubview:conterView];
    
    //本地搜索记录列表
    localSearch = [[UITableView alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY(conterView.frame)+10, self.view.frame.size.width, selectDir.frame.size.height-CGRectGetMaxY(conterView.frame)-10)];
    localSearch.dataSource = self;
    localSearch.delegate = self;
    localSearch.backgroundColor = [UIColor whiteColor];
    localSearch.bounces = NO;
    [selectDir addSubview:localSearch];
    
    UIButton *clearBut = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBut.frame = CGRectMake(0, 0, 40, searchText.frame.size.height);
    [clearBut setTitle:@"清除历史搜索记录" forState:UIControlStateNormal];
    [clearBut setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    
    [clearBut addTarget:self action:@selector(clearButClick) forControlEvents:UIControlEventTouchUpInside];
    
    [clearBut.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [clearBut.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [clearBut setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
    localSearch.tableFooterView = clearBut;
    
}


/**
 清空历史搜索记录
 */
- (void)clearButClick{
    if (currentSearchType != 0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults valueForKey:@"hotSearch"]) {
            NSMutableArray *arry = [[NSMutableArray alloc] initWithArray:[defaults valueForKey:@"hotSearch"]];
            [arry removeAllObjects];
            [defaults setValue:arry forKey:@"hotSearch"];
        }
        [localSearchArry removeAllObjects];
    }
    [localSearch reloadData];
}

/**
 热门搜索点击
 
 @param but 点击的热门
 */
- (void)labelButClick:(UIButton *)but{
    searchText.text = but.titleLabel.text;
    selectDir.hidden = YES;
    [self.view endEditing:YES];
}

/**
 取消
 */
- (void)cancelBut{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addSearchView{
    [self.view layoutIfNeeded];
    searchText = [[UITextField alloc] initWithFrame:CGRectMake(10, 25, CGRectGetMaxX(self.rightBut1.frame)-10, 30)];
    searchText.delegate = self;
    searchText.layer.cornerRadius = 16;
    searchText.layer.borderColor = BUTTON_COLOR.CGColor;
    searchText.layer.borderWidth = 1;
    [searchText setTextColor:JOBNAME_COLOR];
    [searchText setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    searchText.placeholder = @"搜索职位、招聘会";
    searchText.layer.masksToBounds = YES;
    [self.view addSubview:searchText];
    [searchText becomeFirstResponder];
    UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, searchText.frame.size.height)];
    
    selectType = [UIButton buttonWithType:UIButtonTypeCustom];
    selectType.frame = CGRectMake(20, 0, 65, searchText.frame.size.height);
    [selectType setTitle:@"招聘会" forState:UIControlStateNormal];
    [selectType setImage:[UIImage imageNamed:@"icon_greenArrow"] forState:UIControlStateNormal];
    
    [selectType addTarget:self action:@selector(handleSingleTapFrom) forControlEvents:UIControlEventTouchUpInside];
    [selectType setImageEdgeInsets:UIEdgeInsetsMake(0, selectType.frame.size.width - selectType.imageView.frame.origin.x - selectType.imageView.frame.size.width, 0, 0)];
    
    [selectType setTitleEdgeInsets:UIEdgeInsetsMake(0, -(selectType.frame.size.width - selectType.imageView.frame.size.width ), 0, 0)];
    [selectType.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [selectType.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [selectType setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    [left addSubview:selectType];
    
    searchText.leftView = left;
    searchText.leftViewMode = UITextFieldViewModeAlways;
    
    
    
}


#pragma textfield代理回调

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (currentSearchType == 0) {
        selectDir.hidden = YES;
    }
    else{
        [self getLocationSearch];
       selectDir.hidden = NO;
    }
   
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (searchText.text.length != 0) {
        selectDir.hidden = YES;
    }
    [self.view endEditing:YES];
    if (currentSearchType == 0) {
        [self searchRecrutiInfo:searchText.text rowNum:@"" pull:@"0"];
    }
    else{
        [self getSearchInfo:searchText.text rowNum:@"" pull:@"0"];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (searchText.text.length != 0) {
        selectDir.hidden = YES;
    }
    [self.view endEditing:YES];
    return  YES;
}

/**
 添加主搜索列表
 */
- (void)addListView{
    
    
    //数据列表
    listView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame))];
    listView.dataSource = self;
    listView.delegate = self;
    
    listView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    listView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:listView];
}


/**
 选择搜索类型view
 */
- (void)selectTypeSelect{
    
    cover = [[UIView alloc] initWithFrame:self.view.frame];
    cover.hidden = YES;
    [self.view addSubview:cover];
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [cover addGestureRecognizer:singleRecognizer];
    
    
    UIView *selectView = [[UIView alloc] init];
    [cover addSubview:selectView];
    
    UIImageView *arrow = [[UIImageView alloc] init];
    [arrow setImage:[UIImage imageNamed:@"icon_listArrow"]];
    arrow.contentMode = UIViewContentModeScaleToFill;
    [selectView addSubview:arrow];
    
    buttonView = [[UIView alloc] init];
    buttonView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [selectView addSubview:buttonView];
    
    UIButton *Recruitment = [[UIButton alloc] init];
    Recruitment.tag = 0;
    [Recruitment addTarget:self action:@selector(recruitClick:) forControlEvents:UIControlEventTouchUpInside];
    [Recruitment setTitle:@"招聘会" forState:UIControlStateNormal];
    [Recruitment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Recruitment.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [buttonView addSubview:Recruitment];
    UIButton *Job = [[UIButton alloc] init];
    Job.tag = 1;
    [Job setTitle:@"职位" forState:UIControlStateNormal];
    [Job addTarget:self action:@selector(recruitClick:) forControlEvents:UIControlEventTouchUpInside];
    [Job setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Job.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [buttonView addSubview:Job];
    
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cover.mas_left).offset(20);
        make.width.mas_equalTo(80);
        make.top.equalTo(self.topView.mas_bottom);
    }];
    
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectView.mas_top);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.centerX.equalTo(selectView.mas_centerX);
    }];
    
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectView.mas_left);
        make.width.mas_equalTo(selectView.mas_width);
        make.height.mas_equalTo(60);
        make.top.equalTo(arrow.mas_bottom);
        make.bottom.equalTo(selectView.mas_bottom);
    }];
    [Recruitment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView.mas_top);
        make.width.mas_equalTo(buttonView.mas_width);
        make.height.mas_equalTo(30);
        make.left.equalTo(buttonView.mas_left);
    }];
    [Job mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Recruitment.mas_bottom);
        make.width.equalTo(Recruitment.mas_width);
        make.height.equalTo(Recruitment.mas_height);
        make.left.equalTo(Recruitment.mas_left);
    }];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    buttonView.layer.cornerRadius = 7;
    buttonView.layer.masksToBounds = YES;
}


/**
 点击
 */
- (void)recruitClick:(UIButton *)but{
    cover.hidden = !cover.hidden;
    searchText.text = @"";
    if (but.tag == 0) {
        currentSearchType = 0;
        [selectType setTitle:@"招聘会" forState:UIControlStateNormal];
        selectDir.hidden = YES;
    }
    else{
        currentSearchType = 1;
        [selectType setTitle:@"职位" forState:UIControlStateNormal];
        selectDir.hidden = NO;
    }
    [searchText becomeFirstResponder];
}


/**
 点击收起选项列表
 */
- (void)handleSingleTapFrom{
    [self.view bringSubviewToFront:cover];
    if (cover.hidden == YES) {
        cover.hidden = NO;
    }
    else{
        cover.hidden = YES;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == localSearch) {
        static NSString *ID =@"cellID";
        
        SearchLocalCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[SearchLocalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        cell.searchStr = [localSearchArry objectAtIndex:indexPath.row];
        
        return cell;
    }
    else{
        
        if (currentSearchType == 0) {
            static NSString *ID =@"cellID2";
            
            SearchMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[SearchMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
                
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dic = [datasource objectAtIndex:indexPath.row];
            
            return cell;
        }
        else{
            static NSString *ID =@"cellID3";
            
            HM_HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[HM_HomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
                
            }
            HM_HomeModel *model = [datasource objectAtIndex:indexPath.row];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.model = model;
            
            return cell;
        }
        
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == localSearch) {
        return localSearchArry.count;
    }
    else{
        return datasource.count;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == localSearch) {
        selectDir.hidden = YES;
        [searchText setText:[localSearchArry objectAtIndex:indexPath.row]];
        
    }
    else{
        if (currentSearchType == 0) {
            if ([[[datasource objectAtIndex:indexPath.row] objectForKey:@"job_fair_type"] isEqualToString:@"netcongress"]) {
                NET_recrutiDetailController *detail = [[NET_recrutiDetailController alloc] init];
                detail.topTitle = @"网络招聘会";
                detail.recrutId = [NSString stringWithFormat:@"%@",[[datasource objectAtIndex:indexPath.row] objectForKey:@"id"]];
                [self.navigationController pushViewController:detail animated:YES];
            }
            else{
                SCH_SchollDetailController *detail = [[SCH_SchollDetailController alloc] init];
                detail.topTitle = @"校园招聘会";
                detail.recrutId = [NSString stringWithFormat:@"%@",[[datasource objectAtIndex:indexPath.row] objectForKey:@"id"]];
                [self.navigationController pushViewController:detail animated:YES];
            }
        }
        else{
            JobDetailController *job = [[JobDetailController alloc] init];
            job.topTitle = @"职位详情";
            job.jobId = ((HM_HomeModel *)[datasource objectAtIndex:indexPath.row]).M_jobId;
            [job setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:job animated:YES];
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == localSearch) {
        return 40;
    }else{
        return 90;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    [sectionView setBackgroundColor:BACKGROUND_COLOR];
    UILabel *ps = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sectionView.frame.size.width, 30)];
    [ps setText:[NSString stringWithFormat:@"共计%ld条记录",(long)total]];
    [ps setFont:[UIFont systemFontOfSize:14.0]];
    [ps setTextAlignment:NSTextAlignmentCenter];
    [ps setTextColor:COMPANY_COLOR];
    [sectionView addSubview:ps];
    
    return sectionView;
}


/**
 获取搜索职位结果
 */
- (void)getSearchInfo:(NSString *)searchStr rowNum:(NSString *)rowNum pull:(NSString *)IfPull{
    [self.view endEditing:YES];
    if ([searchStr isEqualToString:@""]) {
        [listView.mj_footer endRefreshingWithNoMoreData];
    }
    else{
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
                for (NSDictionary *temDic in [dicData objectForKey:@"data"]) {
                    HM_HomeModel *tem = [[HM_HomeModel alloc] initWithDic:temDic];
                    [datasource addObject:tem];
                }
                
                [listView reloadData];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSMutableArray *temArry = [[NSMutableArray alloc] initWithArray:[defaults valueForKey:@"hotSearch"]];
                
                if (![temArry containsObject:searchText.text]) {
                    if (temArry.count>5) {
                        [temArry insertObject:searchText.text atIndex:0];
                        [temArry removeLastObject];
                    }
                    else{
                        [temArry insertObject:searchText.text atIndex:0];
                    }
                    
                }
                
                [defaults setValue:temArry forKey:@"hotSearch"];
                
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
                                  @"id":rowNum?rowNum:@"",
                                  @"direction":IfPull,
                                  @"jobname":searchText.text,
                                  };//json data
        
        
        [request postAsynRequestBody:dicBody interfaceName:JOBSEARCH interfaceTag:1 parType:0];
    }
    
    
}

/**
 搜索招聘会
 */
- (void)searchRecrutiInfo:(NSString *)searchStr rowNum:(NSString *)rowNum pull:(NSString *)IfPull{
    [self.view endEditing:YES];
    if (searchStr != nil) {
        if ([searchStr isEqualToString:@""]) {
            [listView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
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
                                      @"siteid":app.siteid,
                                      @"id":rowNum,
                                      @"direction":IfPull,
                                      @"job_fair_name":searchStr,
                                      };//json data
            
            
            [request getHttpRequest:dicBody interfaceName:SEARCHJOBFAIR interfaceTag:2];
        }
        
    }
    
}

/**
 获取热门职位搜索项
 */
- (void)getHotSearch{
    
            HttpRequestModel *request = [[HttpRequestModel alloc] init];
            request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
                [self endRefresh];
                if ([[dicData objectForKey:@"code"] integerValue] == 0) {
                    
                    [hotSearchArry addObjectsFromArray:[dicData objectForKey:@"data"]];
                    [self reloadHotSearchView];
                }
                else{
                    [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
                }
            };
            request.httpFieldBlock = ^(NSError *error){
               
            };
            NSDictionary *dicBody = @{
                                     
                                      };//json data
            
            
            [request getHttpRequest:dicBody interfaceName:HOTJOBSEARCH interfaceTag:3];
   
}

- (void)reloadHotSearchView{
   
    NSInteger x = 10;
    NSInteger y = 10;
    for (NSInteger i=0; i<hotSearchArry.count; i++) {
        NSString *str = [[hotSearchArry objectAtIndex:i] objectForKey:@"position_name"];
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[myFont textFont:15.0]]}];
        
        if (x + size.width+10 > conterView.frame.size.width) {
            
            x = 10;
            y = y + size.height+30; //5为两行之间的高度间隔
            
        }
        UIButton *labelBut = [[UIButton alloc] initWithFrame:CGRectMake(x, y, size.width+10, size.height+20)];
        [labelBut setTitle:str forState:UIControlStateNormal];
        [labelBut.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        
        [labelBut setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
        [labelBut addTarget:self action:@selector(labelButClick:) forControlEvents:UIControlEventTouchUpInside];
        labelBut.tag = i;
        labelBut.layer.borderWidth = 1;
        labelBut.layer.borderColor = COMPANY_COLOR.CGColor;
        labelBut.layer.cornerRadius = 6;
        labelBut.layer.masksToBounds = YES;
        [conterView addSubview:labelBut];
        conterView.frame = CGRectMake(conterView.frame.origin.x, conterView.frame.origin.y, conterView.frame.size.width,CGRectGetMaxY(labelBut.frame)+10);
        x = x + size.width +20; //10为两个标签之间的宽度间隔
    }
    localSearch.frame = CGRectMake(0,  CGRectGetMaxY(conterView.frame)+10, self.view.frame.size.width, selectDir.frame.size.height-CGRectGetMaxY(conterView.frame)-10);
}

- (void)endRefresh{
    [listView.mj_header endRefreshing];
    [listView.mj_footer endRefreshing];
}

@end
