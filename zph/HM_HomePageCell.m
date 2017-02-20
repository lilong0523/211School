//
//  HM_HomePageCell.m
//  zph
//
//  Created by 李龙 on 2016/12/22.
//  Copyright © 2016年 李龙. All rights reserved.
//

#define SPACE 10
#define SPACE_ROW 15

#import "HM_HomePageCell.h"

@implementation HM_HomePageCell
{
    UIImageView *logo;//公司logo
    UILabel *jobName;//职位名
    UILabel *salary;//薪资
    UILabel *company;//公司名
    UILabel *careerFair;//招聘展会
    UILabel *address;//地点
    
    UIImageView *arrow;//右箭头
    
    
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
        [logo setImage:[UIImage imageNamed:@"icon_bottom_noselect"]];
        [logo setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:logo];
        jobName = [[UILabel alloc] init];
        [jobName setFont:[UIFont boldSystemFontOfSize:[myFont textFont:15.0]]];
        [jobName setTextAlignment:NSTextAlignmentLeft];
        [jobName setTextColor:JOBNAME_COLOR];
        [self.contentView addSubview:jobName];
        salary = [[UILabel alloc] init];
        [salary setFont:[UIFont boldSystemFontOfSize:[myFont textFont:14.0]]];
        [salary setTextAlignment:NSTextAlignmentRight];
        [salary setTextColor:SALARY_COLOR];
        [self.contentView addSubview:salary];
        company = [[UILabel alloc] init];
        [company setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [company setTextAlignment:NSTextAlignmentLeft];
        [company setTextColor:COMPANY_COLOR];
        [self.contentView addSubview:company];
        careerFair = [[UILabel alloc] init];
        [careerFair setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [careerFair setTextAlignment:NSTextAlignmentLeft];
        [careerFair setTextColor:COMPANY_COLOR];
        [self.contentView addSubview:careerFair];
        address = [[UILabel alloc] init];
        [address setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [address setTextColor:COMPANY_COLOR];
        [address setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:address];
        
        arrow = [[UIImageView alloc] init];
        [arrow setContentMode:UIViewContentModeScaleAspectFit];
        [arrow setImage:[UIImage imageNamed:@"icon_triangle"]];
        [self.contentView addSubview:arrow];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:LINE_COLOR];
        [self.contentView addSubview:line];
        
        
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(SPACE);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
        [jobName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(logo.mas_right).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(SPACE);
            make.right.equalTo(salary.mas_left).offset(-SPACE);
            make.bottom.equalTo(company.mas_top).offset(-SPACE);
            
        }];
        [salary mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(jobName.mas_right).offset(SPACE);
            make.centerY.equalTo(jobName.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-SPACE);
            make.bottom.equalTo(jobName.mas_bottom);
            make.width.mas_equalTo(100);
        }];
        [company mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(jobName.mas_left);
            make.top.equalTo(jobName.mas_bottom).offset(SPACE);
            make.right.equalTo(address.mas_left).offset(-SPACE);
            make.bottom.equalTo(careerFair.mas_top).offset(-SPACE);
            
        }];
        [careerFair mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(company.mas_left);
            make.top.equalTo(company.mas_bottom).offset(SPACE);
            make.right.equalTo(arrow.mas_left).offset(-5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-SPACE);
            
        }];
        [address mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(company.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-SPACE);
            
        }];
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(careerFair.mas_right).offset(5);
            make.centerY.equalTo(careerFair.mas_centerY);
            make.width.mas_equalTo(7);
            make.height.mas_equalTo(14);
            
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).offset(SPACE);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-0.5);
            make.right.equalTo(self.contentView.mas_right).offset(-SPACE);
            make.height.mas_equalTo(0.5);
            
        }];
        
    }
    
    return self;
}

- (void)setModel:(HM_HomeModel *)model{
    NSURL *url = [NSURL URLWithString:model.M_logo];
    [logo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:model.M_Nologo]];
    [jobName setText:model.M_jobName];
    [salary setText:model.M_salary];
    [company setText:model.M_company];
    [careerFair setText:[NSString stringWithFormat:@"%@场招聘会有类似职位",model.M_careerFair]];
    [address setText:model.M_address];
}

@end
