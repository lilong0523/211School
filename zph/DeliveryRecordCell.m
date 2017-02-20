//
//  DeliveryRecordCell.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "DeliveryRecordCell.h"

@implementation DeliveryRecordCell
{
    UIImageView *logo;
    UILabel *JobName;//职位名称
    UILabel *salary;//薪水
    UILabel *companyName;//公司名
    UIButton *address;//地点
    UIButton *Degree;//学历
    UILabel *time;//日期
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
        JobName = [[UILabel alloc] init];
        [JobName setText:@""];
        [JobName setTextAlignment:NSTextAlignmentLeft];
        [JobName setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [JobName setTextColor:JOBNAME_COLOR];
        [self.contentView addSubview:JobName];
        salary = [[UILabel alloc] init];
        [salary setText:@""];
        [salary setTextAlignment:NSTextAlignmentRight];
        [salary setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [salary setTextColor:[UIColor colorWithHexString:@"#36D9A2"]];
        [self.contentView addSubview:salary];
        companyName = [[UILabel alloc] init];
        [companyName setText:@""];
        [companyName setTextAlignment:NSTextAlignmentLeft];
        [companyName setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [companyName setTextColor:COMPANY_COLOR];
        [self.contentView addSubview:companyName];
        
        address = [[UIButton alloc] init];
        [address setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
        [address setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
        address.adjustsImageWhenHighlighted = NO;
        [address.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [address.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [address setTitle:@"" forState:UIControlStateNormal];
        [self.contentView addSubview:address];
        
        Degree = [[UIButton alloc] init];
        [Degree setImage:[UIImage imageNamed:@"icon_degree"] forState:UIControlStateNormal];
        [Degree setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
        Degree.adjustsImageWhenHighlighted = NO;
        [Degree.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [Degree.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [Degree setTitle:@"" forState:UIControlStateNormal];
        [self.contentView addSubview:Degree];
        
        time = [[UILabel alloc] init];
        [time setText:@""];
        [time setTextAlignment:NSTextAlignmentRight];
        [time setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
        [time setTextColor:COMPANY_COLOR];
        [self.contentView addSubview:time];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:BACKGROUND_COLOR];
        [self.contentView addSubview:line];
        
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(20);
           
        }];
        [JobName mas_makeConstraints:^(MASConstraintMaker *make) {
            
           
            make.right.equalTo(salary.mas_left).offset(-5);
            make.left.equalTo(logo.mas_right).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(10);
        }];
        [salary mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.left.mas_greaterThanOrEqualTo(JobName.mas_right).offset(5);
            make.centerY.equalTo(JobName.mas_centerY);
        }];
        [companyName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.left.equalTo(JobName.mas_left);
            make.top.equalTo(JobName.mas_bottom).offset(10);
        }];
        [address mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(15);
            make.left.equalTo(companyName.mas_left);
            make.top.equalTo(companyName.mas_bottom).offset(10);
        }];
        [Degree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(address.mas_centerY);
            
            make.left.equalTo(address.mas_right).offset(10);
            
            make.height.mas_equalTo(15);
        }];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(salary.mas_right);
           
            make.centerY.equalTo(Degree.mas_centerY);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right);
            make.height.mas_equalTo(5);
        }];
    }
    
    return self;
}

- (void)setModel:(NSMutableDictionary *)model{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEUPLOAD,[model objectForKey:@"company_logo"]]];
    [logo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:[[model objectForKey:@"industry"] isEqualToString:@""]?@"big0":[model objectForKey:@"industry"]]];
    [JobName setText:[model objectForKey:@"job_name"]?[model objectForKey:@"job_name"]:@""];
    [salary setText:[model objectForKey:@"money"]?[model objectForKey:@"money"]:@""];
    [companyName setText:[model objectForKey:@"company_name"]?[model objectForKey:@"company_name"]:@""];
    [address setTitle:[model objectForKey:@"area_name"]?[model objectForKey:@"area_name"]:@"" forState:UIControlStateNormal];
    [Degree setTitle:[model objectForKey:@"education"]?[model objectForKey:@"education"]:@"" forState:UIControlStateNormal];
    [time setText:[model objectForKey:@"add_time"]?[model objectForKey:@"add_time"]:@""];
}

@end
