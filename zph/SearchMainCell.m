//
//  SearchMainCell.m
//  zph
//
//  Created by 李龙 on 2017/1/10.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "SearchMainCell.h"

@implementation SearchMainCell
{
    UIImageView *logo;
    UILabel *name;
    UILabel *time;
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
        [logo setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:logo];
        
        name = [[UILabel alloc] init];
        [name setTextColor:JOBDETAIL_COLOR];
        [name setTextAlignment:NSTextAlignmentLeft];
        name.numberOfLines = 2;
        [name setFont:[UIFont systemFontOfSize:15.0]];
        [self.contentView addSubview:name];
        
        time = [[UILabel alloc] init];
        [time setTextColor:COMPANY_COLOR];
        [time setTextAlignment:NSTextAlignmentLeft];
        [time setFont:[UIFont systemFontOfSize:13.0]];
        [self.contentView addSubview:time];
        
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(logo.mas_right).offset(10);
           make.right.equalTo(self.contentView.mas_right).offset(-20);
        }];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.left.equalTo(name.mas_left);
        }];
        
    }
    
    return self;
}

- (void)setDic:(NSDictionary *)dic{
    
    if ([[dic objectForKey:@"job_fair_type"] isEqualToString:@"netcongress"]) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEUPLOAD,[dic objectForKey:@"poster_path"]]];
        [logo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon_defaultNet"]];
    }
    else{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEUPLOAD,[dic objectForKey:@"logo_path"]]];
        [logo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon_defultSchool"]];
    }
    
    [name setText:[dic objectForKey:@"job_fair_name"]];
    [time setText:[NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"job_fair_time"],[dic objectForKey:@"job_fair_overtime"]]];
}

@end
