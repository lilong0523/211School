//
//  messageController.m
//  zph
//
//  Created by 李龙 on 2017/1/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "messageController.h"
#import "messageCell.h"
#import "MyInterviewCell.h"


@interface messageController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation messageController
{
    UIButton *myInterview;//我的面试
    UIButton *myMessage;//我的消息
    UIView *bottomLine;//下划线
    
    UITableView *listView;
    NSMutableArray *datasource;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    datasource = [[NSMutableArray alloc] initWithCapacity:0];
    [self addTopView];
    [self addListView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCurrentType:(NSInteger)currentType{
    _currentType = currentType;
}


/**
 添加头部
 */
- (void)addTopView{
    
    myInterview = [[UIButton alloc] initWithFrame:CGRectMake(60, 20, (self.view.frame.size.width-80)/2, 44)];
    [myInterview setTitle:@"我的面试" forState:UIControlStateNormal];
    myInterview.tag = 0;
    [myInterview addTarget:self action:@selector(SelectClick:) forControlEvents:UIControlEventTouchUpInside];
    [myInterview setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
    [myInterview setTitleColor:SALAARYDETAIL_COLOR forState:UIControlStateSelected];
    [myInterview.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:18.0]]];
    [self.view addSubview:myInterview];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(myInterview.frame), myInterview.frame.origin.y+13, 1, 18)];
    [line setBackgroundColor:COMPANY_COLOR];
    [self.view addSubview:line];
    myMessage= [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), myInterview.frame.origin.y, myInterview.frame.size.width, myInterview.frame.size.height)];
    myMessage.tag = 1;
    [myMessage setTitle:@"我的消息" forState:UIControlStateNormal];
    [myMessage addTarget:self action:@selector(SelectClick:) forControlEvents:UIControlEventTouchUpInside];
    [myMessage setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
    [myMessage setTitleColor:SALAARYDETAIL_COLOR forState:UIControlStateSelected];
    [myMessage.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:18.0]]];
    [self.view addSubview:myMessage];
    
    
    bottomLine = [[UIView alloc] initWithFrame:CGRectMake(myInterview.center.x-36, CGRectGetMaxY(myInterview.frame)-2, 72, 2)];
    [bottomLine setBackgroundColor:SALAARYDETAIL_COLOR];
    [self.view addSubview:bottomLine];
    
    if (_currentType == 1) {
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
    if (but.tag == 1) {
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
    listView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame))];
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
        
        messageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[messageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else{
        static NSString *ID =@"cellID2";
        
        MyInterviewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[MyInterviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentType == 1) {
        return 74;
    }
    else{
        return 160;
    }
    
}


@end
