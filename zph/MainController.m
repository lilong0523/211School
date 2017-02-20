//
//  MainController.m
//  zph
//
//  Created by 李龙 on 2016/12/21.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "MainController.h"
#import "HM_HomePageController.h"
#import "NET_recruitController.h"
#import "SCH_SchoolController.h"
#import "PersonalCenterController.h"


@interface MainController ()
@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation MainController
{
    UIButton *btn1;//首页
    UIButton *btn2;//网络招聘会
    UIButton *btn3;//校园招聘会
    UIButton *btn4;//个人中心
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
    CGRect rect = self.tabBar.frame;
    [self.tabBar removeFromSuperview];
    UIView *myView = [[UIView alloc] init];
    myView.frame = rect;
    myView.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
    [self.view addSubview:myView];
    //tabbar顶部线条
    UILabel *bord = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, myView.frame.size.width, 1)];
    [bord setBackgroundColor:[UIColor colorWithRed:222/255.0f green:222/255.0f blue:222/255.0f alpha:1]];
    [myView addSubview:bord];
    
    //首页
    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, myView.frame.size.width/4, myView.frame.size.height)];
    btn1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn1.selected = YES;
    btn1.tag = 0;
    btn1.adjustsImageWhenHighlighted = NO;
    [btn1 setImage:[UIImage imageNamed:@"icon_bottom_noselect"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_bottom_select"] forState:UIControlStateSelected];
    self.selectedBtn = btn1;
    [btn1.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:10.0]]];
    [btn1 setTitle:@"首页" forState:UIControlStateNormal];
    [self initButton:btn1];
    [btn1 setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(ButClick:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:btn1];
    //网络招聘会
    btn2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame), btn1.frame.origin.y, btn1.frame.size.width, btn1.frame.size.height)];
    btn2.selected = NO;
    btn2.adjustsImageWhenHighlighted = NO;
    [btn2 setImage:[UIImage imageNamed:@"icon_bottom_noselect4"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"icon_bottom_select4"] forState:UIControlStateSelected];
    btn2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn2 addTarget:self action:@selector(ButClick:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 1;
    [btn2 setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
    [btn2.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:10.0]]];
    [btn2 setTitle:@"网络招聘会" forState:UIControlStateNormal];
    [self initButton:btn2];
    [myView addSubview:btn2];
    //校园招聘会
    btn3 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn2.frame), btn2.frame.origin.y, btn2.frame.size.width, btn2.frame.size.height)];
    btn3.selected = NO;
    btn3.adjustsImageWhenHighlighted = NO;
    [btn3 setImage:[UIImage imageNamed:@"icon_bottom_noselect2"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"icon_bottom_select2"] forState:UIControlStateSelected];
    btn3.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn3.tag = 2;
    [btn3 setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
    [btn3.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:10.0]]];
    [btn3 setTitle:@"校园招聘会" forState:UIControlStateNormal];
    [self initButton:btn3];
    [btn3 addTarget:self action:@selector(ButClick:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:btn3];
    //个人中心
    btn4 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn3.frame), btn3.frame.origin.y, btn3.frame.size.width, btn3.frame.size.height)];
    btn4.adjustsImageWhenHighlighted = NO;
    btn4.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn4.selected = NO;
    [btn4 addTarget:self action:@selector(ButClick:) forControlEvents:UIControlEventTouchUpInside];
    btn4.tag = 3;
    [btn4 setImage:[UIImage imageNamed:@"icon_bottom_noselect3"] forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"icon_bottom_select3"] forState:UIControlStateSelected];
    [btn4 setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
    [btn4.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:10.0]]];
    [btn4 setTitle:@"个人中心" forState:UIControlStateNormal];
    [self initButton:btn4];
    [myView addSubview:btn4];
    
    
    
    
    HM_HomePageController *home = [[HM_HomePageController alloc] init];

    [self addChildViewController:home];
    
    NET_recruitController *netRecruit = [[NET_recruitController alloc] init];
    [self addChildViewController:netRecruit];
    
    SCH_SchoolController *school = [[SCH_SchoolController alloc] init];
    [self addChildViewController:school];
    
    PersonalCenterController *person = [[PersonalCenterController alloc] init];
    [self addChildViewController:person];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ButClick:(UIButton *)bt
{
    self.selectedBtn.selected = NO;
    if (bt.tag == 0) {
        btn1.selected = YES;
        self.selectedIndex = bt.tag;
    }
    else if (bt.tag == 1)
    {
        btn2.selected = YES;
        self.selectedIndex = bt.tag;
    }
    else if (bt.tag == 2)
    {
        btn3.selected = YES;
        self.selectedIndex = bt.tag;
    }
    else if (bt.tag == 3)
    {
        btn4.selected = YES;
        self.selectedIndex = bt.tag;
    }
    
    self.selectedBtn = bt;
    
}

-(void)initButton:(UIButton*)btn{
    
    // 按钮图片和标题总高度
    
    CGFloat totalHeight = (btn.imageView.frame.size.height + btn.titleLabel.frame.size.height);
    
    // 设置按钮图片偏移
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - btn.imageView.frame.size.height), 0.0, 0.0, -btn.titleLabel.frame.size.width)];
    
    // 设置按钮标题偏移
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btn.imageView.frame.size.width, -(totalHeight - btn.titleLabel.frame.size.height+5),0.0)];
    
    
    //    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    //    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
}


@end
