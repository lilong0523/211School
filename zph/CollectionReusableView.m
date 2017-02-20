//
//  CollectionReusableView.m
//  zph
//
//  Created by 李龙 on 2017/1/8.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "CollectionReusableView.h"
#import "BulletView.h"
#import "BulletManager.h"


@interface CollectionReusableView ()
@property (nonatomic, strong) BulletManager *bulletManager;


@end

@implementation CollectionReusableView
{
    UIView *topView;
    UILabel *Recruitment;//招聘会名称
    UILabel *time;//招聘会时间
    
    UILabel *firstNum;//参会企业数
    UILabel *secondNum;//职位数
    UILabel *thirdNum;//求职者数
    
    UIView *modeCell;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        self.backgroundColor = BACKGROUND_COLOR;
        
        [self addDanmu];
        [self addTitle];
        [self addSearchView];
    }
    return self;
}


/**
 添加弹幕
 */
- (void)addDanmu{
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
    UIImageView *topBack = [[UIImageView alloc] initWithFrame:topView.frame];
    [topBack setImage:[UIImage imageNamed:@"icon_backNet"]];
    [topView addSubview:topBack];
    [self addSubview:topView];
    self.bulletManager = [[BulletManager alloc] init];
    __weak CollectionReusableView *myself = self;
    self.bulletManager.generateBulletBlock = ^(BulletView *bulletView) {
        [myself addBulletView:bulletView];
    };
    
}

- (void)addBulletView:(BulletView *)bulletView {
    bulletView.frame = CGRectMake(CGRectGetWidth(self.frame)+50, 32 + 40 * bulletView.trajectory, CGRectGetWidth(bulletView.bounds), CGRectGetHeight(bulletView.bounds));
    [topView addSubview:bulletView];
    [bulletView startAnimation];
}


/**
 添加标题
 */
- (void)addTitle{
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame)+5, self.frame.size.width, 60)];
    [_titleView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_titleView];
    
    Recruitment = [[UILabel alloc] init];
    [Recruitment setText:@""];
    [Recruitment setTextColor:[UIColor blackColor]];
    [Recruitment setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [_titleView addSubview:Recruitment];
    time = [[UILabel alloc] init];
    [time setText:@""];
    [time setTextColor:COMPANY_COLOR];
    [time setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [_titleView addSubview:time];
    
    UIImageView *share = [[UIImageView alloc] init];
    [share setImage:[UIImage imageNamed:@"icon_share"]];
    share.contentMode = UIViewContentModeScaleAspectFit;
    [_titleView addSubview:share];
    [Recruitment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_top).offset(10);
        make.left.equalTo(_titleView.mas_left).offset(20);
        
        make.right.equalTo(share.mas_left).offset(-20);
    }];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Recruitment.mas_bottom).offset(10);
        make.left.equalTo(Recruitment.mas_left);
        make.bottom.equalTo(_titleView.mas_bottom).offset(-5);
        make.right.equalTo(Recruitment.mas_right);
    }];
    [share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleView.mas_centerY);
        make.right.equalTo(_titleView.mas_right).offset(-10);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    
    modeCell = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), _titleView.frame.size.width, 80)];
    [self addSubview:modeCell];
    
    
    UIView *first = [[UIView alloc] init];
    [first setBackgroundColor:[UIColor whiteColor]];
    [modeCell addSubview:first];
    UIView *second = [[UIView alloc] init];
    [second setBackgroundColor:[UIColor whiteColor]];
    [modeCell addSubview:second];
    UIView *third = [[UIView alloc] init];
    [third setBackgroundColor:[UIColor whiteColor]];
    [modeCell addSubview:third];
    
    
    [first mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(modeCell.mas_top).offset(5);
        make.left.equalTo(modeCell.mas_left).offset(5);
        make.bottom.equalTo(modeCell.mas_bottom).offset(-10);
        make.width.mas_equalTo(second.mas_width);
        make.right.equalTo(second.mas_left).offset(-10);
    }];
    [second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(first.mas_top);
        make.left.equalTo(first.mas_right).offset(5);
        make.bottom.equalTo(first.mas_bottom);
        make.width.mas_equalTo(third.mas_width);
        make.right.equalTo(third.mas_left).offset(-10);
    }];
    [third mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(second.mas_top);
        make.left.equalTo(second.mas_right).offset(5);
        make.bottom.equalTo(second.mas_bottom);
        make.width.mas_equalTo(first.mas_width);
        make.right.equalTo(modeCell.mas_right).offset(-5);
    }];
    
    
    firstNum = [[UILabel alloc] init];
    [firstNum setTextAlignment:NSTextAlignmentCenter];
    [firstNum setText:@"0"];
    [firstNum setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [firstNum setTextColor:[UIColor colorWithHexString:@"#49AFFF"]];
    [first addSubview:firstNum];
    
    UILabel *firstStr = [[UILabel alloc] init];
    [firstStr setTextAlignment:NSTextAlignmentCenter];
    [firstStr setText:@"家参会企业"];
    [firstStr setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [firstStr setTextColor:COMPANY_COLOR];
    [first addSubview:firstStr];
    [firstNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(first.mas_top).offset(10);
        make.left.equalTo(first.mas_left);
        make.bottom.equalTo(firstStr.mas_top).offset(-10);
        make.right.equalTo(first.mas_right);
    }];
    [firstStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstNum.mas_bottom).offset(10);
        make.left.equalTo(first.mas_left);
        make.bottom.equalTo(first.mas_bottom).offset(-10);
        make.right.equalTo(first.mas_right);
    }];
    
    
    secondNum = [[UILabel alloc] init];
    [secondNum setTextAlignment:NSTextAlignmentCenter];
    [secondNum setText:@"0"];
    [secondNum setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [secondNum setTextColor:[UIColor colorWithHexString:@"#F4A547"]];
    [second addSubview:secondNum];
    
    UILabel *secondStr = [[UILabel alloc] init];
    [secondStr setTextAlignment:NSTextAlignmentCenter];
    [secondStr setText:@"个在招职位"];
    [secondStr setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [secondStr setTextColor:COMPANY_COLOR];
    [second addSubview:secondStr];
    [secondNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(second.mas_top).offset(10);
        make.left.equalTo(second.mas_left);
        make.bottom.equalTo(secondStr.mas_top).offset(-10);
        make.right.equalTo(second.mas_right);
    }];
    [secondStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondNum.mas_bottom).offset(10);
        make.left.equalTo(second.mas_left);
        make.bottom.equalTo(second.mas_bottom).offset(-10);
        make.right.equalTo(second.mas_right);
    }];
    
    thirdNum = [[UILabel alloc] init];
    [thirdNum setTextAlignment:NSTextAlignmentCenter];
    [thirdNum setText:@"0"];
    [thirdNum setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [thirdNum setTextColor:BUTTON_COLOR];
    [third addSubview:thirdNum];
    
    UILabel *thirdStr = [[UILabel alloc] init];
    [thirdStr setTextAlignment:NSTextAlignmentCenter];
    [thirdStr setText:@"位求职者"];
    [thirdStr setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
    [thirdStr setTextColor:COMPANY_COLOR];
    [third addSubview:thirdStr];
    [thirdNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(third.mas_top).offset(10);
        make.left.equalTo(third.mas_left);
        make.bottom.equalTo(thirdStr.mas_top).offset(-10);
        make.right.equalTo(third.mas_right);
    }];
    [thirdStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdNum.mas_bottom).offset(10);
        make.left.equalTo(third.mas_left);
        make.bottom.equalTo(third.mas_bottom).offset(-10);
        make.right.equalTo(third.mas_right);
    }];
    
    
}

/**
 添加搜索头
 */
- (void)addSearchView{
    __block CollectionReusableView *blockSelf = self;
    UIView *searctView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(modeCell.frame), modeCell.frame.size.width, 52)];
    [searctView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:searctView];
    
    _searchText = [[BaseTextfield2 alloc] init];
    _searchText.placeHold = @"搜索职位";
    [searctView addSubview:_searchText];
    _searchText.SearchBlock = ^(NSString *text){
        if (blockSelf.SearchBlock) {
            blockSelf.SearchBlock(text);
        }
    };
    [_searchText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searctView.mas_left).offset(10);
        make.top.equalTo(searctView.mas_top).offset(10);
        make.right.equalTo(searctView.mas_right).offset(-10);
        make.height.mas_equalTo(32);
    }];
}


- (void)setDanMuArry:(NSMutableArray *)danMuArry{
    _danMuArry = danMuArry;
    self.bulletManager.allComments = _danMuArry;
    
    [self.bulletManager start];
}

- (void)setModel:(NSMutableDictionary *)model{
    [Recruitment setText:[model objectForKey:@"job_fair_name"]];
    [time setText:[NSString stringWithFormat:@"%@至%@",[model objectForKey:@"job_fair_time"],[model objectForKey:@"job_fair_overtime"]]];
    [firstNum setText:![[model objectForKey:@"company_num"] isEqual:[NSNull null]]?@"0":[NSString stringWithFormat:@"%@",[model objectForKey:@"company_num"]]];
    [secondNum setText:![[model objectForKey:@"job_person_num"] isEqual:[NSNull null]]?@"0":[NSString stringWithFormat:@"%@",[model objectForKey:@"job_person_num"]]];
    [thirdNum setText:![[model objectForKey:@"resume_size"] isEqual:[NSNull null]]?@"0":[NSString stringWithFormat:@"%@",[model objectForKey:@"resume_size"]]];
}

@end
