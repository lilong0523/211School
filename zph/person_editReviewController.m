//
//  person_editReviewController.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "person_editReviewController.h"

@interface person_editReviewController ()<UITextViewDelegate>

@end

@implementation person_editReviewController
{
    UILabel *detailText;//提示字数
    UITextView *textInput;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.rightBut2 setTitle:@"保存" forState:UIControlStateNormal];
    [self.rightBut2 addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBut2 setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    [self addMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 添加主体
 */
- (void)addMainView{
    
    
    textInput = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.topView.frame)+10, self.view.frame.size.width-20, 160)];
    [textInput setBackgroundColor:LINE_COLOR];
    textInput.delegate = self;
    textInput.text = _detail;
    [textInput setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
    [textInput setTextColor:[UIColor blackColor]];
    [self.view addSubview:textInput];
    
    //提示字数
    detailText = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-100, CGRectGetMaxY(textInput.frame)+10, 90, 20)];
    [detailText setText:[NSString stringWithFormat:@"(%lu/500字)",(unsigned long)textInput.text.length]];
    [detailText setTextAlignment:NSTextAlignmentRight];
    [detailText setTextColor:[UIColor colorWithHexString:@"#36D9A2"]];
    [detailText setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
    [self.view addSubview:detailText];
    
    
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 500) {
        textView.text = [textView.text substringToIndex:500];
    }
    [detailText setText:[NSString stringWithFormat:@"(%lu/500字)",(unsigned long)textView.text.length]];
}

/**
 保存按钮
 */
- (void)rightClick{
    if (self.editBlock) {
        self.editBlock(textInput.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setDetail:(NSString *)detail{
    _detail = detail;
}



@end
