//
//  datePicker.m
//  zph
//
//  Created by 李龙 on 2017/1/14.
//  Copyright © 2017年 李龙. All rights reserved.
//

#define PickerViewHeight 240
#define STControlSystemHeight   44


#import "datePicker.h"

@interface datePicker()<UIPickerViewDataSource, UIPickerViewDelegate>


@property (nonatomic, strong, nullable)UIPickerView *sexPicker;
@property (nonatomic, strong, nullable)UIView *selectBar;
@property (nonatomic, strong, nullable)NSMutableArray *datasourceArry;

@end

@implementation datePicker
{
    NSString *selectText;
    NSInteger currentNum;
    UILabel *titlePick;//显示的title
    
    NSString *currentFullId;//选择城市最终传参id
}
- (instancetype)initWithNum:(NSInteger)compontNum
{
    self = [super init];
    if (self) {
        _compontNum = compontNum;
        currentNum= 0;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _datasourceArry = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"areaArry"]];
        self.bounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
        [self.layer setOpaque:0.0];
        [self selectSex];
    }
    return self;
}

- (void)show
{
    if (_compontNum == 1) {
        selectText = [[_datasourceArry objectAtIndex:0] objectForKey:@"name"];
    }
    else{
        selectText = [NSString stringWithFormat:@"%@ %@",[[_datasourceArry objectAtIndex:currentNum] objectForKey:@"name"],[[[[_datasourceArry objectAtIndex:currentNum] objectForKey:@"city"] objectAtIndex:0] objectForKey:@"name"]];
        currentFullId = [[[[_datasourceArry objectAtIndex:currentNum] objectForKey:@"city"] objectAtIndex:0] objectForKey:@"full_id"];
    }
    [titlePick setText:selectText];
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [self addGestureRecognizer:singleRecognizer];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    CGRect frameTool = _selectBar.frame;
    frameTool.origin.y -= PickerViewHeight;
    
    CGRect framePicker =  _sexPicker.frame;
    framePicker.origin.y -= PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:1];
        _selectBar.frame = frameTool;
        _sexPicker.frame = framePicker;
    } completion:^(BOOL finished) {
    }];
}



- (void)remove
{
    
    CGRect frameTool = _selectBar.frame;
    frameTool.origin.y += PickerViewHeight;
    CGRect framePicker =  _sexPicker.frame;
    framePicker.origin.y += PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:0];
        _selectBar.frame = frameTool;
        _sexPicker.frame = framePicker;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


/**
 创建选择器
 */
- (void)selectSex{
    
    _selectBar = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, STControlSystemHeight)];
    _selectBar.backgroundColor = [UIColor whiteColor];
    [self addSubview:_selectBar];
    
    UIButton *leftBut = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 24)];
    [leftBut setTitle:@"取消" forState:UIControlStateNormal];
    [leftBut setTitleColor:JOBNAME_COLOR forState:UIControlStateNormal];
    [leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBut.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [_selectBar addSubview:leftBut];
    UIButton *rightBut = [[UIButton alloc] initWithFrame:CGRectMake(_selectBar.frame.size.width-60, 10, 50, 24)];
    [rightBut setTitle:@"确定" forState:UIControlStateNormal];
    [rightBut setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(rightButClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBut.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [_selectBar addSubview:rightBut];
    
    titlePick = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftBut.frame)+5, 10, CGRectGetMinX(rightBut.frame)-CGRectGetMaxX(leftBut.frame)-10, 24)];
    [titlePick setTextColor:[UIColor blackColor]];
    [titlePick setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
    titlePick.textAlignment = NSTextAlignmentCenter;
    [_selectBar addSubview:titlePick];
    
    
    _sexPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height+STControlSystemHeight, [UIScreen mainScreen].bounds.size.width, PickerViewHeight-STControlSystemHeight)];
    _sexPicker.backgroundColor = [UIColor whiteColor];
    _sexPicker.dataSource = self;
    _sexPicker.delegate = self;
    _sexPicker.showsSelectionIndicator = YES;
    [self addSubview:_sexPicker];
    
    
    
}


/**
 确定
 */
- (void)rightButClick{
    if (self.selectBlock) {
        self.selectBlock(selectText);
    }
    if (self.FullIdBlock) {
        self.FullIdBlock(currentFullId);
    }
    
    [self remove];
}

/**
 取消
 */
- (void)leftButClick{
    [self remove];
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _compontNum;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _datasourceArry.count;
    }
    else{
        return [[[_datasourceArry objectAtIndex:currentNum] objectForKey:@"city"] count];
    }
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    
    if (component == 0) {
        UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 32)];
        
        [detail setTextColor:[UIColor blackColor]];
        [detail setText:[[_datasourceArry objectAtIndex:row] objectForKey:@"name"]];
        [detail setTextAlignment:NSTextAlignmentCenter];
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(detail.frame), self.frame.size.width, 0.5)];
        [downLine setBackgroundColor:LINE_COLOR];
        [detail addSubview:downLine];
        return detail;
    }
    else{
        UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 32)];
        
        [detail setTextColor:[UIColor blackColor]];
        [detail setText:[[[[_datasourceArry objectAtIndex:currentNum] objectForKey:@"city"] objectAtIndex:row] objectForKey:@"name"]];
        [detail setTextAlignment:NSTextAlignmentCenter];
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(detail.frame), self.frame.size.width, 0.5)];
        [downLine setBackgroundColor:LINE_COLOR];
        [detail addSubview:downLine];
        return detail;
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 32;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        currentNum = row;
        if (_compontNum == 1) {
            
        }
        else{
            [_sexPicker reloadComponent:1];
            [_sexPicker selectRow:0 inComponent:1 animated:YES];
        }
        
        
        [self reloadData];
        
    }
    else if (component == 1){
        currentFullId = [[[[_datasourceArry objectAtIndex:currentNum] objectForKey:@"city"] objectAtIndex:row] objectForKey:@"full_id"];
        [self reloadData];
    }
    
    
}

- (void)reloadData
{
    if (_compontNum == 1) {
        NSInteger index0 = [_sexPicker selectedRowInComponent:0];
        selectText = [NSString stringWithFormat:@"%@",[[_datasourceArry objectAtIndex:index0] objectForKey:@"name"]];
    }
    else if (_compontNum == 2){
        NSInteger index0 = [_sexPicker selectedRowInComponent:0];
        NSInteger index1 = [_sexPicker selectedRowInComponent:1];
        selectText = [NSString stringWithFormat:@"%@ %@",[[_datasourceArry objectAtIndex:index0] objectForKey:@"name"],[[[[_datasourceArry objectAtIndex:index0] objectForKey:@"city"] objectAtIndex:index1] objectForKey:@"name"]];
        currentFullId = [[[[_datasourceArry objectAtIndex:index0] objectForKey:@"city"] objectAtIndex:index1] objectForKey:@"full_id"];
    }
    
    [titlePick setText:selectText];
}



- (void)setDefaultNum:(NSInteger)defaultNum{
    _defaultNum = defaultNum;
    
}


@end
