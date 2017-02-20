//
//  WorkAreaSelectController.m
//  zph
//
//  Created by 李龙 on 2017/1/15.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "WorkAreaSelectController.h"
#import "provinceSelectCell.h"
#import "citySelectCell.h"

@interface WorkAreaSelectController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation WorkAreaSelectController
{
    UIScrollView *mainScrollview;
    
    UILabel *numberSelect;//已选数量
    NSInteger currentNum;
    
    UIView *AreaButView;
    
    UITableView *provinceList;//省选择列表
    UITableView *cityList;//省选择列表
    NSMutableArray *AreaArry;//省市数组
    
    NSInteger currentProvinceNum;//当前选择的省位置

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rightBut2 setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.rightBut2 addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setTitleColor:COMPANYINT_COLOR forState:UIControlStateNormal];
    [self.rightBut2 setTitleColor:BUTTON_COLOR forState:UIControlStateSelected];
    self.rightBut2.selected = NO;
    // Do any additional setup after loading the view.
    
    currentNum= _numberArry.count;
    currentProvinceNum = 0;
    AreaArry = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"areaArry"]];
    [self addMainView];
    [self addListView];
    [self reloadAreaView];
}

/**
 确定
 */
- (void)rightClick{
    if (_numberArry.count>0) {
        if (self.selectCityBlock) {
            self.selectCityBlock(_numberArry);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [HUDProgress showHUD:@"还未选择城市"];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addMainView{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, 80)];
    [self.view addSubview:topView];
    UILabel *selectedArea = [[UILabel alloc] init];
    [selectedArea setText:@"已选地点"];
    [selectedArea setFont:[UIFont systemFontOfSize:14.0]];
    [selectedArea setTextColor:COMPANYINT_COLOR];
    [topView addSubview:selectedArea];
    
    numberSelect = [[UILabel alloc] init];
    [numberSelect setText:[NSString stringWithFormat:@"%ld",(long)currentNum]];
    [numberSelect setTextColor:BUTTON_COLOR];
    [numberSelect setTextAlignment:NSTextAlignmentRight];
    [numberSelect setFont:[UIFont systemFontOfSize:13.0]];
    [topView addSubview:numberSelect];
    UILabel *numberAll = [[UILabel alloc] init];
    [numberAll setText:@"/3"];
    [numberAll setTextColor:COMPANYINT_COLOR];
    [numberAll setTextAlignment:NSTextAlignmentLeft];
    [numberAll setFont:[UIFont systemFontOfSize:13.0]];
    [topView addSubview:numberAll];
    
    [selectedArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).offset(10);
        make.left.equalTo(topView.mas_left).offset(20);
    }];
    [numberSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).offset(10);
        make.right.equalTo(numberAll.mas_left);
    }];
    [numberAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).offset(10);
        make.right.equalTo(topView.mas_right).offset(-20);
        make.left.equalTo(numberSelect.mas_right);
    }];
    
    AreaButView = [[UIView alloc] initWithFrame:CGRectMake(20,topView.frame.size.height-40, topView.frame.size.width-40, 40)];
    [topView addSubview:AreaButView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(AreaButView.frame)-1, self.view.frame.size.width, 1)];
    [line setBackgroundColor:LINE_COLOR];
    [topView addSubview:line];
    
    mainScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(topView.frame))];
    mainScrollview.scrollEnabled = NO;
    mainScrollview.delegate = self;
    [self.view addSubview:mainScrollview];
    
}


/**
 添加列表
 */
- (void)addListView{
    provinceList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainScrollview.frame.size.width, mainScrollview.frame.size.height)];
    provinceList.delegate = self;
    provinceList.bounces = NO;
    provinceList.dataSource = self;
    provinceList.tableFooterView = [[UIView alloc] init];
    [mainScrollview addSubview:provinceList];
    
    cityList = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(provinceList.frame), 0, mainScrollview.frame.size.width, mainScrollview.frame.size.height)];
    cityList.delegate = self;
    cityList.bounces = NO;
    cityList.dataSource = self;
    cityList.tableFooterView = [[UIView alloc] init];
    [mainScrollview addSubview:cityList];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == provinceList) {
        static NSString *ID =@"cellID";
        provinceSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[provinceSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.text = [[AreaArry objectAtIndex:indexPath.row] objectForKey:@"name"];
        
        return cell;
    }
    else{
        static NSString *ID =@"cellID2";
        citySelectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[citySelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        
        if ([_numberArry containsObject:[[[AreaArry objectAtIndex:currentProvinceNum] objectForKey:@"city"] objectAtIndex:indexPath.row]]) {
            cell.ifSelect = YES;
        }
        else{
            cell.ifSelect = NO;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.text = [[[[AreaArry objectAtIndex:currentProvinceNum] objectForKey:@"city"] objectAtIndex:indexPath.row] objectForKey:@"name"];
        
        return cell;
    }
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == provinceList) {
        return AreaArry.count;
    }
    else{
        return [[[AreaArry objectAtIndex:currentProvinceNum] objectForKey:@"city"] count];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == provinceList) {
        currentProvinceNum = indexPath.row;
        [cityList reloadData];
        [mainScrollview setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
        [self.leftBut removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [self.leftBut addTarget:self action:@selector(backToProvince) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        if ([_numberArry containsObject:[[[AreaArry objectAtIndex:currentProvinceNum] objectForKey:@"city"] objectAtIndex:indexPath.row]]) {
            [self reduceAreaCell:[[[AreaArry objectAtIndex:currentProvinceNum] objectForKey:@"city"] objectAtIndex:indexPath.row]];
        }
        else{
            if (currentNum==3) {
                [HUDProgress showHUD:@"最多选择三个城市"];
            }
            else{
                [self addAreaSelect:[[[AreaArry objectAtIndex:currentProvinceNum] objectForKey:@"city"] objectAtIndex:indexPath.row]];
            }
            
        }
        [cityList reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section], nil] withRowAnimation:UITableViewRowAnimationNone];

    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == provinceList) {
        return 20;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    [sectionView setBackgroundColor:BACKGROUND_COLOR];
    UILabel *ps = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 20)];
    [ps setText:@"省份 （按首字母顺序排列）"];
    [ps setFont:[UIFont systemFontOfSize:14.0]];
    [ps setTextColor:COMPANY_COLOR];
    [sectionView addSubview:ps];
    
    return sectionView;
}

/**
 返回省选择
 */
- (void)backToProvince{
    [mainScrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.leftBut removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.leftBut addTarget:self action:@selector(backToView) forControlEvents:UIControlEventTouchUpInside];
}


/**
 返回上级页面
 */
- (void)backToView{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 添加地区
 */
- (void)addAreaSelect:(NSMutableDictionary *)city{
    currentNum++;
    [_numberArry addObject:city];
    [self reloadAreaView];
    if (currentNum>0) {
        self.rightBut2.selected = YES;
    }
    else{
        self.rightBut2.selected = NO;
    }
}

- (void)reduceAreaCell:(NSMutableDictionary *)city{
    currentNum--;
    [_numberArry removeObject:city];
    if (currentNum>0) {
        self.rightBut2.selected = YES;
    }
    else{
        self.rightBut2.selected = NO;
    }
    [self reloadAreaView];
}

/**
 删除已选择城市

 @param but 城市
 */
- (void)reduceAreaSelect:(UIButton *)but{
    currentNum--;
    [_numberArry removeObjectAtIndex:but.tag];
    
    [self reloadAreaView];
    [cityList reloadData];
    if (currentNum>0) {
        self.rightBut2.selected = YES;
    }
    else{
        self.rightBut2.selected = NO;
    }
}



/**
 重排地区
 */
- (void)reloadAreaView{
    for (UIView *bbq in AreaButView.subviews) {
        [bbq removeFromSuperview];
    }
    for (int i = 0;i < _numberArry.count; i++) {
        UIButton *area = [[UIButton alloc] initWithFrame:CGRectMake(i*80, 0, 70, 30)];
        
        [area.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        area.tag = i;
        area.backgroundColor = [UIColor whiteColor];
        area.layer.borderWidth = 0.5;
        area.layer.borderColor = COMPANYINT_COLOR.CGColor;
        area.layer.cornerRadius = 5;
        area.layer.masksToBounds = YES;
        [area setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
        [area addTarget:self action:@selector(reduceAreaSelect:) forControlEvents:UIControlEventTouchUpInside];
        [area.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [area setImage:[UIImage imageNamed:@"icon_delete-1"] forState:UIControlStateNormal];
        [area setTitle:[[_numberArry objectAtIndex:i] objectForKey:@"name"] forState:UIControlStateNormal];
        [area.titleLabel setLineBreakMode:NSLineBreakByCharWrapping];
        area.titleLabel.numberOfLines = 1;
        [area setImageEdgeInsets:UIEdgeInsetsMake(5, 50, 5, 5)];
        [area setTitleEdgeInsets:UIEdgeInsetsMake(0, -60, 0, 27)];
        [AreaButView addSubview:area];
        
    }
    [numberSelect setText:[NSString stringWithFormat:@"%ld",(long)currentNum]];
    
}

- (void)setNumberArry:(NSMutableArray *)numberArry{
    _numberArry = [[NSMutableArray alloc] initWithArray:numberArry];
}

@end
