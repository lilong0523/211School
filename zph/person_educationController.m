//
//  person_educationController.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "person_educationController.h"
#import "person_educateCell.h"
#import "BaseButton.h"
#import "person_addeducateController.h"
#import "person_editEducateController.h"

@interface person_educationController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation person_educationController
{
    UITableView *listView;
    NSMutableArray *datasource;//
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addListView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"这里了");
}

- (void)addListView{
    
    listView = [[UITableView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.topView.frame)+20, self.view.frame.size.width-20, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame)-30)];
    listView.delegate = self;
    listView.dataSource = self;
    listView.layer.cornerRadius = 3;
    listView.layer.masksToBounds = YES;
    listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    listView.showsHorizontalScrollIndicator = NO;
    listView.showsVerticalScrollIndicator = NO;
    listView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:listView];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, listView.frame.size.width, 70)];
    BaseButton *addMore = [[BaseButton alloc] initWithFrame:CGRectMake(0, 20, footView.frame.size.width, 45)];
    [addMore setImage:[UIImage imageNamed:@"icon_addMore"] forState:UIControlStateNormal];
    [addMore addTarget:self action:@selector(addMoreClick) forControlEvents:UIControlEventTouchUpInside];
    addMore.text = @"添加教育背景";
    [footView addSubview:addMore];
    listView.tableFooterView = footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __block person_educationController *block = self;
    static NSString *ID =@"cellID1";
    
     person_educateCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[person_educateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
        
    }
    cell.model = [_educationArry objectAtIndex:indexPath.row];
    __block person_educateCell *selfCell = cell;
    cell.editBlock = ^(){
        person_editEducateController *editEducate = [[person_editEducateController alloc] init];
        editEducate.topTitle = @"编辑教育背景";
        editEducate.educationInfo = selfCell.model;
        editEducate.indexNum = indexPath.row;
        editEducate.changeBlock = ^(NSInteger index,NSMutableDictionary *dic){
            [block->_educationArry replaceObjectAtIndex:index withObject:dic];
            [block->listView reloadData];
        };
        editEducate.deleteBlock = ^(NSInteger index){
            [block->_educationArry removeObjectAtIndex:index];
            [block->listView reloadData];
        };
        [block.navigationController pushViewController:editEducate animated:YES];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _educationArry.count;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



/**
 添加教育背景
 */
- (void)addMoreClick{
    __block person_educationController *blockSelf = self;
    person_addeducateController *addMore = [[person_addeducateController alloc] init];
    addMore.topTitle = @"添加教育背景";
    addMore.addBlock = ^(NSMutableDictionary *dic){
        [_educationArry addObject:dic];
        [blockSelf->listView reloadData];
    };
    
    [self.navigationController pushViewController:addMore animated:YES];
}

- (void)setEducationArry:(NSMutableArray *)educationArry{
    if (_educationArry == nil) {
        _educationArry = [[NSMutableArray alloc] initWithArray:educationArry];
    }
}

@end
