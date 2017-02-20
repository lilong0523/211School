//
//  baseDatePicker.m
//  zph
//
//  Created by 李龙 on 2016/12/31.
//  Copyright © 2016年 李龙. All rights reserved.
//


#define PickerViewHeight 240
#define STControlSystemHeight   44


#import "baseDatePicker.h"

@interface baseDatePicker()

@property (nonatomic, strong, nullable)UIView *selectBar;
@property (nonatomic, strong, nullable)UIDatePicker *pickerView;


@end
@implementation baseDatePicker
{
    NSString *selectText;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.bounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
        [self.layer setOpaque:0.0];
        [self selectPick];
    }
    return self;
}

/**
 创建选择器
 */
- (void)selectPick{
    
    _selectBar = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, STControlSystemHeight)];
    _selectBar.backgroundColor = [UIColor whiteColor];
    [self addSubview:_selectBar];
    
    UIButton *leftBut = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 24)];
    [leftBut setTitle:@"取消" forState:UIControlStateNormal];
    [leftBut setTitleColor:JOBNAME_COLOR forState:UIControlStateNormal];
    [leftBut addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [leftBut.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [_selectBar addSubview:leftBut];
    UIButton *rightBut = [[UIButton alloc] initWithFrame:CGRectMake(_selectBar.frame.size.width-60, 10, 50, 24)];
    [rightBut setTitle:@"确定" forState:UIControlStateNormal];
    [rightBut setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(rightButClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBut.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [_selectBar addSubview:rightBut];
    
    
    _pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height+STControlSystemHeight, [UIScreen mainScreen].bounds.size.width, PickerViewHeight-STControlSystemHeight)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.datePickerMode = UIDatePickerModeDate;
    [self addSubview:_pickerView];
    
    
    
}


/**
 确定按钮
 */
- (void)rightButClick{
    NSLog(@"%@",_pickerView.date);
    if (self.selectBlock) {
        self.selectBlock(_pickerView.date);
    }
    [self remove];
}

- (void)show
{
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [self addGestureRecognizer:singleRecognizer];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    CGRect frameTool = _selectBar.frame;
    frameTool.origin.y -= PickerViewHeight;
    
    CGRect framePicker =  _pickerView.frame;
    framePicker.origin.y -= PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:1];
        _selectBar.frame = frameTool;
        _pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
    }];
}



- (void)remove
{
    
    CGRect frameTool = _selectBar.frame;
    frameTool.origin.y += PickerViewHeight;
    CGRect framePicker =  _pickerView.frame;
    framePicker.origin.y += PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:0];
        _selectBar.frame = frameTool;
        _pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
