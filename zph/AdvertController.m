//
//  AdvertController.m
//  zph
//
//  Created by 李龙 on 2017/1/13.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "AdvertController.h"
#import <WebKit/WebKit.h>

@interface AdvertController ()<WKNavigationDelegate>

@end

@implementation AdvertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addMainView{
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.topView.frame))];
    webView.navigationDelegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self.view addSubview:webView];
}


@end
