//
//  HM_HomePageController.m
//  zph
//
//  Created by 李龙 on 2016/12/21.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "HM_HomePageController.h"
#import "BaseTextfield.h"
#import "HM_HomePageCell.h"
#import "HM_HomeModel.h"
#import "JobDetailController.h"
#import "SearchPageController.h"
#import "SDCycleScrollView.h"
#import <WebKit/WebKit.h>
#import "AdvertController.h"


@interface HM_HomePageController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SDCycleScrollViewDelegate>

@end

@implementation HM_HomePageController
{
    UIView *topView;//nav
    
    UITableView *listView;//列表
    
    SDCycleScrollView *cycleScrollView;//广告轮播
    NSMutableArray *advertArry;//广告数组
    NSMutableArray *datasource;//数据
    
    UIView *navView;//nav
    UIView *selectDir;//区域选择view
    UIButton *address;//区域选择按钮
    NSMutableArray *AreaArry;//区域数组
    NSMutableArray *butArry;
    
    UIImageView *imagebbq;
    AppDelegate *app;
}


/**
 添加上下拉
 */
- (void)addMJRefresh{
    
    listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        [self getIndexInfo:@"" pull:@"0"];
        
    }];
    listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        HM_HomeModel *model = [datasource lastObject];
        [self getIndexInfo:model.M_ID pull:@"0"];
    }];
    
    
    [listView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    // Do any additional setup after loading the view.
    advertArry = [[NSMutableArray alloc] initWithCapacity:0];
    datasource = [[NSMutableArray alloc] initWithCapacity:0];
    butArry = [[NSMutableArray alloc] initWithCapacity:0];
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self addTopView];
    [self addSelectListView];
    [self getAdvertisement];
    
    [self addMJRefresh];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 区域选择view
 */
- (void)addSelectListView{
    selectDir = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(navView.frame), self.view.frame.size.width, 120)];
    [selectDir setBackgroundColor:BACKGROUND_COLOR];
    selectDir.hidden = YES;
    [self.view addSubview:selectDir];
    UILabel *ps = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 15)];
    [ps setTextColor:JOBNAME_COLOR];
    [ps setFont:[UIFont systemFontOfSize:12.0]];
    [ps setTextAlignment:NSTextAlignmentLeft];
    [ps setText:@"请选择分站"];
    [selectDir addSubview:ps];
    
    UIView *butView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(ps.frame)+10, selectDir.frame.size.width-40, 90)];
    [selectDir addSubview:butView];
    
    AreaArry = [[NSMutableArray alloc] initWithObjects:@{@"name":@"陕西",@"siteid":@"28"},@{@"name":@"河南",@"siteid":@"17"},@{@"name":@"湖南",@"siteid":@"19"},@{@"name":@"四川",@"siteid":@"24"},@{@"name":@"重庆",@"siteid":@"23"},@{@"name":@"甘肃",@"siteid":@"29"}, nil];
    
    int W = 0;
    int H = 0;
    for (int i = 0; i< AreaArry.count; i++) {
        
        UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(W*((butView.frame.size.width-20)/3+10), H*45, (butView.frame.size.width-20)/3, 35)];
        but.layer.cornerRadius = 7;
        but.layer.borderColor =COMPANYINT_COLOR.CGColor;
        but.layer.masksToBounds = YES;
        but.layer.borderWidth = 1;
        but.tag = i;
        [but setTitle:[[AreaArry objectAtIndex:i] objectForKey:@"name"] forState:UIControlStateNormal];
        [but setTitleColor:COMPANYINT_COLOR forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [but setBackgroundImage:[UIImage imageNamed:@"icon_buttonBack"] forState:UIControlStateSelected];
        [but setBackgroundColor:[UIColor whiteColor]];
        [but.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [butView addSubview:but];
        [butArry addObject:but];
        [but addTarget:self action:@selector(SelectDirClick:) forControlEvents:UIControlEventTouchUpInside];
        W++;
        if (W%3 == 0) {
            W = 0;
            H++;
        }
        butView.frame = CGRectMake(butView.frame.origin.x, butView.frame.origin.y, butView.frame.size.width, CGRectGetMaxY(but.frame));
        
    }
    
    UILabel *ps2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(butView.frame)+10, selectDir.frame.size.width, 15)];
    [ps2 setTextAlignment:NSTextAlignmentCenter];
    [ps2 setText:@"更多分站即将开启，敬请期待..."];
    [ps2 setTextColor:JOBNAME_COLOR];
    [ps2 setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
    [selectDir addSubview:ps2];
    
    selectDir.frame = CGRectMake(0, CGRectGetMaxY(navView.frame), self.view.frame.size.width, CGRectGetMaxY(ps2.frame)+10);
}


/**
 选择区域
 
 @param but 选择的区域
 */
- (void)SelectDirClick:(UIButton *)but{
    for (UIButton *bt in butArry) {
        if (but == bt) {
            bt.selected = YES;
        }
        else{
            bt.selected = NO;
        }
    }
    selectDir.hidden = YES;
    [address setTitle:but.titleLabel.text forState:UIControlStateNormal];
    app.siteid = [NSString stringWithFormat:@"%ld",[[[AreaArry objectAtIndex:but.tag] objectForKey:@"siteid"] integerValue]];
    [self getIndexInfo:@"" pull:@"0"];
}


/**
 区域选择
 */
- (void)addressSelect{
    selectDir.hidden = !selectDir.hidden;
    
}


/**
 添加头部
 */
- (void)addTopView{
    
    __block HM_HomePageController *selfBlock = self;
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-48)];
    [self.view addSubview:back];
    //创建列表
    listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-48) style:UITableViewStylePlain];
    
    listView.delegate = self;
    listView.dataSource = self;
    listView.showsVerticalScrollIndicator = NO;
    listView.showsHorizontalScrollIndicator = NO;
    listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    listView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:listView];
    //广告位轮播
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, listView.frame.size.width, 164) delegate:self placeholderImage:[UIImage imageNamed:@"app-banner"] ];
    //    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    
    
    
    listView.tableHeaderView = cycleScrollView;
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [topView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:topView];
    
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    [topView addSubview:navView];
    
    
    address = [UIButton buttonWithType:UIButtonTypeCustom];
    [address setTitle:@"陕西" forState:UIControlStateNormal];
    [address setImage:[UIImage imageNamed:@"icon_arrowDown"] forState:UIControlStateNormal];
    
    [address addTarget:self action:@selector(addressSelect) forControlEvents:UIControlEventTouchUpInside];
    
    [address.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [address.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [address setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [navView addSubview:address];
    
    BaseTextfield *searchText = [[BaseTextfield alloc] init];
    searchText.placeHold = @"搜索职位、招聘会";
    searchText.touchBlock = ^(){
        SearchPageController *searchPage = [[SearchPageController alloc] init];
        [selfBlock.navigationController pushViewController:searchPage animated:NO];
    };
    [navView addSubview:searchText];
    
    UIImageView *searchImage = [[UIImageView alloc] init];
    [searchImage setImage:[UIImage imageNamed:@"icon-search"]];
    [searchImage setContentMode:UIViewContentModeScaleAspectFit];
    [navView addSubview:searchImage];
    
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navView.mas_left).offset(10);
        
        make.right.equalTo(searchText.mas_left).offset(-10);
        
        make.centerY.equalTo(searchText.mas_centerY);
        
    }];
    [searchText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(address.mas_right).offset(10);
        make.top.equalTo(navView.mas_top).offset(10);
        make.right.equalTo(searchImage.mas_left).offset(-12);
        make.height.mas_equalTo(32);
        make.bottom.equalTo(navView.mas_bottom).offset(-5);
    }];
    [searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchText.mas_right).offset(12);
        
        make.right.equalTo(navView.mas_right).offset(-20);
        
        make.centerY.equalTo(searchText.mas_centerY);
    }];
    [self.view layoutIfNeeded];
    [address setImageEdgeInsets:UIEdgeInsetsMake(0, address.frame.size.width - address.imageView.frame.origin.x - address.imageView.frame.size.width, 0, 0)];
    
    [address setTitleEdgeInsets:UIEdgeInsetsMake(0, -(address.frame.size.width - address.imageView.frame.size.width ), 0, 0)];
    
}


//广告点击回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    AdvertController *advert = [[AdvertController alloc] init];
    advert.url = [[advertArry objectAtIndex:index] objectForKey:@"ad_url"];
    advert.topTitle = @"广告详情";
    [self.navigationController pushViewController:advert animated:YES];
}


//颜色渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UIColor *color=BUTTON_COLOR;
    CGFloat offset=scrollView.contentOffset.y;
    if (offset<0) {
        topView.backgroundColor = [color colorWithAlphaComponent:0];
    }else {
        CGFloat alpha=1-((70-offset)/70);
        topView.backgroundColor=[color colorWithAlphaComponent:alpha];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID =@"cellID";
    
    HM_HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HM_HomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
        
    }
    HM_HomeModel *model = [datasource objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    
    JobDetailController *job = [[JobDetailController alloc] init];
    job.topTitle = @"职位详情";
    job.jobId = ((HM_HomeModel *)[datasource objectAtIndex:indexPath.row]).M_jobId;
    [job setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:job animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


/**
 获取首页数据
 */
- (void)getIndexInfo:(NSString *)rowno pull:(NSString *)IfPull{
    
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        [self endRefresh];
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            if ([[dicData objectForKey:@"data"] count] == 0) {
                [listView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                if ([rowno isEqualToString:@""]) {
                    [datasource removeAllObjects];
                }
                for (NSDictionary *temDic in [dicData objectForKey:@"data"]) {
                    
                    HM_HomeModel *tem = [[HM_HomeModel alloc] initWithDic:temDic];
                    [datasource addObject:tem];
                    
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
                              @"id":rowno?rowno:@"",
                              @"direction":IfPull,
                              @"siteid":app.siteid
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:GETjobsList interfaceTag:1];
}

- (void)endRefresh{
    [listView.mj_header endRefreshing];
    [listView.mj_footer endRefreshing];
}

/**
 获取广告
 */
- (void)getAdvertisement{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            [advertArry addObjectsFromArray:[dicData objectForKey:@"data"]];
            
            
            cycleScrollView.imageURLStringsGroup = [self advertPass:advertArry];
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    
    
    
    [request getHttpRequest:nil interfaceName:GETadvert interfaceTag:2];
}



- (NSMutableArray *)advertPass:(NSMutableArray *)arry{
    NSMutableArray *advert = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i<arry.count; i++) {
        [advert addObject:[NSString stringWithFormat:@"%@%@",IMAGEUPLOAD,[[arry objectAtIndex:i] objectForKey:@"ad_pic_path"]]];
    }
    return advert;
}

@end
