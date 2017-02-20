//
//  YearMonthPick.m
//  zph
//
//  Created by 李龙 on 2017/1/13.
//  Copyright © 2017年 李龙. All rights reserved.
//

#define MAXYEAR 2050
#define MINYEAR 1970

#define PickerViewHeight 240
#define STControlSystemHeight   44

#import "YearMonthPick.h"
#import "NSDate+Extension.h"

@interface YearMonthPick ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    //日期存储数组
    NSMutableArray *_yearArray;
    NSMutableArray *_monthArray;

    
    //记录位置
    NSInteger yearIndex;
    NSInteger monthIndex;

    
    NSString *endResultDate;//选择的日期区间结果
}
@property (nonatomic, strong) UIPickerView *mainPick;

@property (nonatomic, strong, nullable)UIView *selectBar;
@property (nonatomic, retain) NSDate *scrollToDate;//滚到指定日期


@end
@implementation YearMonthPick


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        yearIndex = 0;
        monthIndex = 0;
        [self addPickView];
        [self defaultConfig];
        self.maxLimitDate = [NSDate date];
    }
    return self;
}

- (void)addPickView{
    
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
    
    _mainPick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height+STControlSystemHeight, [UIScreen mainScreen].bounds.size.width, PickerViewHeight-STControlSystemHeight)];
    _mainPick.showsSelectionIndicator = YES;
    _mainPick.delegate = self;
    _mainPick.backgroundColor = [UIColor whiteColor];
    _mainPick.dataSource = self;
    [self addSubview:_mainPick];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(_mainPick.frame.size.width/2-10, _mainPick.frame.size.height/2, 20, 1)];
    [line setBackgroundColor:[UIColor blackColor]];
    [_mainPick addSubview:line];
    
}
- (void)show
{
    endResultDate = [NSString stringWithFormat:@"%@-%@",_yearArray[self.maxLimitDate.year-MINYEAR],_monthArray[monthIndex]];
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [self addGestureRecognizer:singleRecognizer];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    CGRect frameTool = _selectBar.frame;
    frameTool.origin.y -= PickerViewHeight;
    
    CGRect framePicker =  _mainPick.frame;
    framePicker.origin.y -= PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
        _selectBar.frame = frameTool;
        _mainPick.frame = framePicker;
    } completion:^(BOOL finished) {
    }];
}



- (void)remove
{
    
    CGRect frameTool = _selectBar.frame;
    frameTool.origin.y += PickerViewHeight;
    CGRect framePicker =  _mainPick.frame;
    framePicker.origin.y += PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        _selectBar.frame = frameTool;
        _mainPick.frame = framePicker;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


/**
 确定
 */
- (void)rightButClick{
    if (self.selectBlock) {
        self.selectBlock(endResultDate);
    }
    [self remove];
}


/**
 取消
 */
- (void)leftButClick{
    [self remove];
}


-(void)defaultConfig {
    if (!_scrollToDate) {
        _scrollToDate = [NSDate date];
    }
 
    //设置年月日时分数据
    
    _yearArray = [self setArray:_yearArray];
    _monthArray = [self setArray:_monthArray];
    
    
    for (int i=0; i<60; i++) {
        NSString *num = [NSString stringWithFormat:@"%02d",i];
        if (0<i && i<=12)
            [_monthArray addObject:num];
        
    }
    for (NSInteger i=MINYEAR; i<MAXYEAR; i++) {
        NSString *num = [NSString stringWithFormat:@"%ld",(long)i];
        [_yearArray addObject:num];
    }
    
    //最大最小限制
    if (!self.maxLimitDate) {
        self.maxLimitDate = [NSDate date:@"2049-12" WithFormat:@"yyyy-MM"];
    }
    //最小限制
    if (!self.minLimitDate) {
        self.minLimitDate = [NSDate dateWithTimeIntervalSince1970:0];
    }
}

- (NSMutableArray *)setArray:(id)mutableArray
{
    if (mutableArray)
        [mutableArray removeAllObjects];
    else
        mutableArray = [NSMutableArray array];
    return mutableArray;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *numberArr = [self getNumberOfRowsInComponent];
    return [numberArr[component] integerValue];
}

-(NSArray *)getNumberOfRowsInComponent {
    
    NSInteger yearNum = _yearArray.count;
    NSInteger monthNum = _monthArray.count;
    
    
    return @[@(yearNum),@(monthNum)];
    
    
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:[UIFont systemFontOfSize:18]];
    }
    NSString *title;
    
    if (component==0) {
        title = _yearArray[row];
    }
    if (component==1) {
        title = _monthArray[row];
    }
    
    
    customLabel.text = title;
    customLabel.textColor = [UIColor blackColor];
    return customLabel;
    
}
-(void)setMinLimitDate:(NSDate *)minLimitDate {
    _minLimitDate = minLimitDate;
    if ([_scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        _scrollToDate = self.minLimitDate;
    }
    [self getNowDate:self.scrollToDate animated:NO];
    yearIndex = self.minLimitDate.year-MINYEAR ;
    [_mainPick selectRow:self.minLimitDate.year-MINYEAR inComponent:0 animated:YES];
}

- (void)setMaxLimitDate:(NSDate *)maxLimitDate{
    _maxLimitDate = maxLimitDate;
    
    [_mainPick selectRow:self.maxLimitDate.year-MINYEAR inComponent:0 animated:YES];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        yearIndex = row;
    }
    if (component == 1) {
        monthIndex = row;
    }
   
    [pickerView reloadAllComponents];
    
    NSString *dateStr1 = [NSString stringWithFormat:@"%@-%@",_yearArray[yearIndex],_monthArray[monthIndex]];
    
    
    self.scrollToDate = [NSDate date:dateStr1 WithFormat:@"yyyy-MM"];
    
    if ([self.scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        self.scrollToDate = self.minLimitDate;
        [pickerView selectRow:self.scrollToDate.year-MINYEAR inComponent:0 animated:YES];
    }else if ([self.scrollToDate compare:self.maxLimitDate] == NSOrderedDescending){
        self.scrollToDate = self.maxLimitDate;
        
    }
    
    if (component == 0) {
        [pickerView selectRow:self.scrollToDate.year-MINYEAR inComponent:0 animated:YES];
    }

    endResultDate = [NSString stringWithFormat:@"%@",dateStr1];
}

//滚动到指定的时间位置
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated
{
    if (!date) {
        date = [NSDate date];
    }
    
    yearIndex = date.year-MINYEAR;
  
    NSArray *indexArray;
    
    for (int i=0; i<indexArray.count; i++) {
        if ((self.datePickerStyle == DateStyleShowMonthDayHourMinute || self.datePickerStyle == DateStyleShowMonthDay)&& i==0) {
            NSInteger mIndex = [indexArray[i] integerValue]+(12*(self.scrollToDate.year - MINYEAR));
            [_mainPick selectRow:mIndex inComponent:i animated:animated];
        } else {
            [_mainPick selectRow:[indexArray[i] integerValue] inComponent:i animated:animated];
        }
        
    }
}







@end
