//
//  myRecruitmentCell.m
//  zph
//
//  Created by 李龙 on 2017/1/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "myRecruitmentCell.h"

@implementation myRecruitmentCell
{
    UIImageView *logo;//图片
    UILabel *Name;//招聘会名称
    UILabel *time;//招聘会时间
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
        
        logo = [[UIImageView alloc] init];
        [logo setImage:[UIImage imageNamed:@"icon_Agriculture"]];
        logo.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:logo];
        Name = [[UILabel alloc] init];
        [Name setText:@""];
        [Name setTextAlignment:NSTextAlignmentLeft];
        Name.numberOfLines = 0;
        [Name setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [Name setTextColor:JOBNAME_COLOR];
        [self.contentView addSubview:Name];
        time = [[UILabel alloc] init];
        [time setText:@""];
        [time setTextAlignment:NSTextAlignmentLeft];
        [time setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [time setTextColor:COMPANY_COLOR];
        [self.contentView addSubview:time];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:BACKGROUND_COLOR];
        [self.contentView addSubview:line];
        
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(39);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        [Name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.left.equalTo(logo.mas_right).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(15);
        }];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_greaterThanOrEqualTo(Name.mas_bottom).offset(10);
            make.left.equalTo(Name.mas_left);
            make.bottom.equalTo(line.mas_top).offset(-5);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(5);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    
    return self;
}

- (void)setModel:(NSMutableDictionary *)model{
    if ([[model objectForKey:@"job_fair_type"] isEqualToString:@"netcongress"]) {
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEUPLOAD,[model objectForKey:@"poster_path"]]];
        [logo setImage:[UIImage imageNamed:@"icon_defaultNet"]];
//        [logo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon_defaultNet"]];
    }
    else{
        [logo setImage:[UIImage imageNamed:@"icon_defultSchool"]];
        
    }
    
    [Name setText:[model objectForKey:@"job_fair_name"]?[model objectForKey:@"job_fair_name"]:@""];
    [time setText:[NSString stringWithFormat:@"%@-%@",[model objectForKey:@"job_fair_time"],[model objectForKey:@"job_fair_endtime"]]];
    
}

@end
