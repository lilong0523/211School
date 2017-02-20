//
//  ConferenceController.m
//  zph
//
//  Created by 李龙 on 2017/1/8.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "ConferenceController.h"
#import "BulletView.h"
#import "BulletManager.h"
#import "CollectionReusableView.h"
#import "NSData+NSData_ST.h"
#import "ConferenceCell.h"
#import "ConferenceModel.h"
#import "companyController.h"

@interface ConferenceController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) BulletManager *bulletManager;


@end

@implementation ConferenceController
{
    CollectionReusableView *topView;
    NSMutableArray *danMuArry;//弹幕数组
    NSMutableDictionary *fairDeail;//招聘会信息
    NSMutableArray *jobArry;//职位数组
    NSMutableArray *searchArry;//搜索职位数组
    UIScrollView *mainScroll;
    UICollectionView *collectView;
    UILabel *Recruitment;//招聘会名称
    UILabel *time;//招聘会时间
    
    UIView *HidentitleView;
    NSMutableArray *backImageArry;//背景色
    NSInteger currentImage;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    searchArry= [[NSMutableArray alloc] initWithCapacity:0];
    danMuArry= [[NSMutableArray alloc] initWithCapacity:0];
    fairDeail= [[NSMutableDictionary alloc] initWithCapacity:0];
    jobArry = [[NSMutableArray alloc] initWithCapacity:0];
    currentImage = 0;
    backImageArry = [[NSMutableArray alloc] initWithObjects:@"backColor1",@"backColor2",@"backColor3",@"backColor4",@"backColor5",@"backColor6", nil];
    self.topView.hidden = YES;
    [self addTopView];
    [self getSearchInfo];
    [self addHidenView];
    [self getFAIRDetail];
    [self getDanMuDetail];
    [self addFuncBut];
}

/**
 添加功能按钮
 */
- (void)addFuncBut{
    //返回按钮
    UIButton *backBut = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height-80, 40, 40)];
    backBut.layer.cornerRadius = backBut.frame.size.width/2;
    backBut.layer.masksToBounds = YES;
    [backBut setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [backBut setImage:[UIImage imageNamed:@"icon_whiteBack"] forState:UIControlStateNormal];
    [backBut.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [backBut addTarget:self action:@selector(backBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBut];
    
    //录像按钮
    UIButton *carama = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, backBut.frame.origin.y, backBut.frame.size.width, backBut.frame.size.height)];
    carama.layer.cornerRadius = carama.frame.size.width/2;
    carama.layer.masksToBounds = YES;
    [carama setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [carama setImage:[UIImage imageNamed:@"视频1"] forState:UIControlStateNormal];
    [carama.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [carama addTarget:self action:@selector(caramaClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:carama];
    
    //向上按钮
    UIButton *TopBut = [[UIButton alloc] initWithFrame:CGRectMake(carama.frame.origin.x, carama.frame.origin.y-10-backBut.frame.size.height, backBut.frame.size.width, backBut.frame.size.height)];
    TopBut.layer.cornerRadius = TopBut.frame.size.width/2;
    TopBut.layer.masksToBounds = YES;
    [TopBut setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [TopBut setImage:[UIImage imageNamed:@"back_top"] forState:UIControlStateNormal];
    [TopBut.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [TopBut addTarget:self action:@selector(TopButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TopBut];
}


/**
 返回
 */
- (void)backBut{
    [self.navigationController popViewControllerAnimated:YES];
}



/**
 视频按钮点击
 */
- (void)caramaClick{
    
}


/**
 页面最头按钮
 */
- (void)TopButClick{
    [collectView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addTopView{
    
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [layout setHeaderReferenceSize:CGSizeMake(self.view.frame.size.width, 397)];
    
    
    //创建collectionView 通过一个布局策略layout来创建
    collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20) collectionViewLayout:layout];
    [collectView setBackgroundColor:[UIColor whiteColor]];
    //代理设置
    collectView.delegate=self;
    collectView.dataSource=self;
    //注册item类型 这里使用系统的类型
    [collectView registerClass:[ConferenceCell class] forCellWithReuseIdentifier:@"cellid"];
    [collectView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.view addSubview:collectView];
    
    
}



//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return searchArry.count;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ConferenceCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.model = [searchArry objectAtIndex:indexPath.row];
    cell.backImage = [backImageArry objectAtIndex:currentImage];
    currentImage++;
    if (currentImage>5) {
        currentImage = 0;
    }
    return cell;
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((collectView.frame.size.width-30)/2, (collectView.frame.size.width-30)/2);
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    __block ConferenceController *blockSelf = self;
    topView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    topView.SearchBlock = ^(NSString *text){
        [blockSelf->searchArry removeAllObjects];
        if ([text isEqualToString:@""]) {
            [blockSelf->searchArry addObjectsFromArray:blockSelf->jobArry];
        }
        else{
            for (ConferenceModel *model in blockSelf->jobArry) {
                for (NSDictionary *dic in model.jobArry) {
                    //字条串是否包含有某字符串
                    if ([[dic objectForKey:@"job_name"] rangeOfString:text].location == NSNotFound) {
                        NSLog(@"string 不存在 martin");
                    } else {
                        NSLog(@"string 包含 martin");
                        [blockSelf->searchArry addObject:model];
                    }
                }
            }
        }
        [blockSelf->collectView reloadData];
        
    };
    
    return topView;
    
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
    
    companyController *companyDetail = [[companyController alloc] init];
    companyDetail.topTitle = @"企业详情";
    companyDetail.type = @"1";
    companyDetail.companyId = ((ConferenceModel *)[searchArry objectAtIndex:indexPath.row]).JobId;
    [self.navigationController pushViewController:companyDetail animated:YES];
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (topView.titleView.frame.origin.y <= collectView.contentOffset.y) {
        HidentitleView.hidden = NO;
    }
    else{
        HidentitleView.hidden = YES;
    }
}



/**
 添加招聘会view
 */
- (void)addHidenView{
    HidentitleView = [[UIView alloc] initWithFrame:CGRectMake(0,20, self.view.frame.size.width, 60)];
    [HidentitleView setBackgroundColor:[UIColor whiteColor]];
    HidentitleView.hidden = YES;
    [self.view addSubview:HidentitleView];
    
    Recruitment = [[UILabel alloc] init];
    [Recruitment setText:@""];
    [Recruitment setTextColor:[UIColor blackColor]];
    [Recruitment setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [HidentitleView addSubview:Recruitment];
    time = [[UILabel alloc] init];
    [time setText:@""];
    [time setTextColor:COMPANY_COLOR];
    [time setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [HidentitleView addSubview:time];
    
    UIImageView *share = [[UIImageView alloc] init];
    [share setImage:[UIImage imageNamed:@"icon_share"]];
    share.contentMode = UIViewContentModeScaleAspectFit;
    [HidentitleView addSubview:share];
    [Recruitment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(HidentitleView.mas_top).offset(10);
        make.left.equalTo(HidentitleView.mas_left).offset(20);
        
        make.right.equalTo(share.mas_left).offset(-20);
    }];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Recruitment.mas_bottom).offset(10);
        make.left.equalTo(Recruitment.mas_left);
        make.bottom.equalTo(HidentitleView.mas_bottom).offset(-5);
        make.right.equalTo(Recruitment.mas_right);
    }];
    [share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(HidentitleView.mas_centerY);
        make.right.equalTo(HidentitleView.mas_right).offset(-10);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
}


/**
 解压数据
 */
- (void)unZip:(NSString *)str{
    
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:str options:0];
    NSData * uncompress = [NSData uncompressZippedData:nsdataFromBase64String];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    NSString *rawString=[[NSString alloc]initWithData:uncompress encoding:enc];
    NSData *jsonData = [rawString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *arry = [NSJSONSerialization JSONObjectWithData:jsonData
                            
                                                           options:NSJSONReadingMutableContainers
                            
                                                             error:nil];
    for (int i = 0; i<arry.count; i++) {
        ConferenceModel *model = [[ConferenceModel alloc] initWithDic:[arry objectAtIndex:i]];
        [jobArry addObject:model];
    }
    [searchArry addObjectsFromArray:jobArry];
    [collectView reloadData];
}



/**
 载入招聘会信息
 */
- (void)refreshFairDetail{
    [Recruitment setText:[fairDeail objectForKey:@"job_fair_name"]];
    [time setText:[NSString stringWithFormat:@"%@至%@",[fairDeail objectForKey:@"job_fair_time"],[fairDeail objectForKey:@"job_fair_overtime"]]];
    topView.model = fairDeail;
}

/**
 获取弹幕信息
 */
- (void)getDanMuDetail{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            danMuArry = [dicData objectForKey:@"data"];
            topView.danMuArry = danMuArry;
            
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              
                              
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:GETDANMU interfaceTag:2];
}

/**
 获取招聘会信息
 */
- (void)getFAIRDetail{
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            fairDeail = [dicData objectForKey:@"data"];
            [self refreshFairDetail];
            
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
        
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              @"job_fair_id":_recrutId,
                              
                              };//json data
    
    
    [request getHttpRequest:dicBody interfaceName:GETFAIRDETAIL interfaceTag:1];
}

/**
 获取搜索职位结果
 */
- (void)getSearchInfo{
    
    
    HttpRequestModel *request = [[HttpRequestModel alloc] init];
    request.httpSuccessBlock = ^(NSDictionary * dicData,NSInteger tag){
        
        if ([[dicData objectForKey:@"code"] integerValue] == 0) {
            
            
            [self unZip:[dicData objectForKey:@"data"]];
            
        }
        else{
            [HUDProgress showHUD:[NSString stringWithFormat:@"%@",[dicData objectForKey:@"message"]]];
        }
    };
    request.httpFieldBlock = ^(NSError *error){
        
    };
    NSDictionary *dicBody = @{
                              
                              @"id":@"",
                              @"direction":@"",
                              @"job_fair_id":@"201612140011062",
                              };//json data
    
    
    [request postAsynRequestBody:dicBody interfaceName:GETJOBLIST_DATING interfaceTag:1 parType:0];
    
}

- (void)setRecrutId:(NSString *)recrutId{
    _recrutId = recrutId;
}

@end
