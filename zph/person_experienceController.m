//
//  person_experienceController.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "person_experienceController.h"
#import "person_experienceCell.h"
#import "person_editExperController.h"
#import "person_addExperController.h"

@interface person_experienceController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation person_experienceController
{
    UITableView *listView;
    NSMutableArray *datasource;//
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    datasource = [[NSMutableArray alloc] initWithCapacity:0];
    [self addListView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    addMore.text = @"添加实习/工作经历";
    [footView addSubview:addMore];
    listView.tableFooterView = footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __block person_experienceController *block = self;
    static NSString *ID =@"cellID1";
    
    person_experienceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[person_experienceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
        
    }
    cell.model = [_experienceArry objectAtIndex:indexPath.row];
    cell.editBlock = ^(){
        person_editExperController *edit = [[person_editExperController alloc] init];
        edit.JobInfo = [block->_experienceArry objectAtIndex:indexPath.row];
        edit.topTitle = @"编辑实习/工作经历";
        edit.indexNum = indexPath.row;
        edit.changeBlock = ^(NSInteger index, NSMutableDictionary *dic){
            [block->_experienceArry replaceObjectAtIndex:index withObject:dic];
            [block->listView reloadData];
        };
        edit.deleteBlock = ^(NSInteger index){
            [block->_experienceArry removeObjectAtIndex:index];
            [block->listView reloadData];
        };
        [block.navigationController pushViewController:edit animated:YES];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _experienceArry.count;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}



/**
 添加工作经历
 */
- (void)addMoreClick{
    __block person_experienceController *blockSelf = self;
    person_addExperController *edit = [[person_addExperController alloc] init];
    edit.topTitle = @"添加实习/工作经历";
    edit.addBlock = ^(NSMutableDictionary *dic){
        [_experienceArry addObject:dic];
        [blockSelf->listView reloadData];
    };
    [self.navigationController pushViewController:edit animated:YES];
}

- (void)setExperienceArry:(NSMutableArray *)experienceArry{
    if (_experienceArry == nil) {
        _experienceArry = [[NSMutableArray alloc] initWithArray:experienceArry];
    }
}

@end
