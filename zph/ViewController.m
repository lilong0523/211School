//
//  ViewController.m
//  zph
//
//  Created by 李龙 on 2016/12/21.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "ViewController.h"
#import "HM_HomePageController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *bbq = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
    [bbq setBackgroundColor:[UIColor redColor]];
    [bbq addTarget:self action:@selector(bbqclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bbq];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bbqclick{
    HM_HomePageController *bbq = [[HM_HomePageController alloc] init];
    
    [self.navigationController pushViewController:bbq animated:YES];
}

@end
