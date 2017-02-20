//
//  SelectSchoolController.m
//  zph
//
//  Created by 李龙 on 2017/1/6.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "SelectSchoolController.h"
#import "BaseTextfield3.h"
@interface SelectSchoolController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SelectSchoolController
{
    BaseTextfield3 *textInput;//搜索框
    UITableView *listView;
    NSMutableArray *datasource;
    NSMutableArray *alldatasource;
    NSString *currentStr;//当前搜索的关键字
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rightBut2 setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.rightBut2 addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setTitleColor:COMPANYINT_COLOR forState:UIControlStateNormal];
    [self.rightBut2 setTitleColor:BUTTON_COLOR forState:UIControlStateSelected];
    self.rightBut2.selected = NO;
    // Do any additional setup after loading the view.
    currentStr = @"";
    datasource = [[NSMutableArray alloc] initWithCapacity:0];
    [self addSearchView];
    [self addListView];
    [self getSchoolInfo];
}

/**
 确定
 */
- (void)rightClick{
    if (self.rightBut2.selected == YES) {
        if (self.searchBlock) {
            self.searchBlock([[NSMutableDictionary alloc] initWithObjectsAndKeys:currentStr,@"name",@"",@"id", nil]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}



/**
 获取所有学校数据
 */
- (void)getSchoolInfo{
    //获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"school"ofType:@"json"];
    //根据文件路径读取数据
    NSData *jdata = [[NSData alloc] initWithContentsOfFile:filePath];
    alldatasource = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingMutableContainers error:nil];
    [listView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSearchView{
    __block SelectSchoolController *selfBlock = self;
    textInput = [[BaseTextfield3 alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, 50)];
    textInput.placeHold = @"请输入搜索学校名称";
    textInput.searchBlock = ^(NSString *text){
        
        currentStr = text;
        [selfBlock->datasource removeAllObjects];
        for (NSMutableDictionary *bbq in selfBlock->alldatasource) {
            //字条串是否包含有某字符串
            if (!([[bbq objectForKey:@"name"] rangeOfString:text].location == NSNotFound)) {
                [selfBlock->datasource addObject:bbq];
            }
        }
        if (datasource.count == 0) {
            selfBlock.rightBut2.selected = YES;
        }
        else{
            selfBlock.rightBut2.selected = NO;
        }
        if (text.length == 0) {
            selfBlock.rightBut2.selected = NO;
        }
        [selfBlock->listView reloadData];
    };
    
    [self.view addSubview:textInput];
}

- (void)addListView{
    //创建列表
    listView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textInput.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(textInput.frame)) style:UITableViewStylePlain];
    
    listView.delegate = self;
    listView.dataSource = self;
    listView.showsVerticalScrollIndicator = NO;
    listView.showsHorizontalScrollIndicator = NO;
    
    listView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:listView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID =@"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSRange range = [[[datasource objectAtIndex:indexPath.row] objectForKey:@"name"] rangeOfString:currentStr];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[[datasource objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:BUTTON_COLOR range:range];
    
    [cell.textLabel setAttributedText:str];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return datasource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.searchBlock) {
        self.searchBlock([datasource objectAtIndex:indexPath.row] );
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

@end
