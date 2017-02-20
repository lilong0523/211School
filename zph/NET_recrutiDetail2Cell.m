//
//  NET_recrutiDetail2Cell.m
//  zph
//
//  Created by 李龙 on 2016/12/27.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "NET_recrutiDetail2Cell.h"

@implementation NET_recrutiDetail2Cell
{
    UILabel *firstNum;
    UILabel *secondNum;
    UILabel *thirdNum;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *first = [[UIView alloc] init];
        [first setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:first];
        UIView *second = [[UIView alloc] init];
        [second setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:second];
        UIView *third = [[UIView alloc] init];
        [third setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:third];
        
        UILabel *ps = [[UILabel alloc] init];
        [ps setTextAlignment:NSTextAlignmentCenter];
        [ps setText:@"(点击进入会场按钮，查看完整企业信息、职位详情)"];
        [ps setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [ps setTextColor:[UIColor colorWithHexString:@"#FA5666"]];
        [self.contentView addSubview:ps];
        
        [first mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.bottom.equalTo(ps.mas_top).offset(-10);
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
            make.right.equalTo(self.contentView.mas_right).offset(-5);
        }];
        [ps mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(first.mas_bottom).offset(10);
            make.left.equalTo(first.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(third.mas_right);
        }];
        
        firstNum = [[UILabel alloc] init];
        [firstNum setTextAlignment:NSTextAlignmentCenter];
        [firstNum setText:@"1000"];
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
        [secondNum setText:@"1000"];
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
        [thirdNum setText:@"1000"];
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
    
    return self;
}

- (void)setDetailText:(NSMutableDictionary *)detailText{
    [firstNum setText:[[detailText objectForKey:@"company_num"] isEqual:[NSNull null]]?@"0":[NSString stringWithFormat:@"%@",[detailText objectForKey:@"company_num"]]];
    [secondNum setText:[[detailText objectForKey:@"job_person_num"] isEqual:[NSNull null]]?@"0":[NSString stringWithFormat:@"%@",[detailText objectForKey:@"job_person_num"]]];
    [thirdNum setText:[[detailText objectForKey:@"resume_size"] isEqual:[NSNull null]]?@"0":[NSString stringWithFormat:@"%@",[detailText objectForKey:@"resume_size"]]];
}


@end
