//
//  JobExperienceCell.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "JobExperienceCell.h"
#import "baseInfoItem.h"

@implementation JobExperienceCell
{
    baseInfoItem *time;//时间
    baseInfoItem *companyName;//公司名称
    baseInfoItem *JobName;//职位名称
    baseInfoItem *JobContentLab;//工作内容
    UILabel *JobContent;//工作内容
    
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
        
        
        //时间
        time = [[baseInfoItem alloc] init];
        time.leftStr =   @"时    间:";
        time.textColor = SALAARYDETAIL_COLOR;
        [self.contentView addSubview:time];
        //公司名称
        companyName = [[baseInfoItem alloc] init];
        companyName.leftStr = @"公司名称:";
        [self.contentView addSubview:companyName];
        
        //职位名称
        JobName = [[baseInfoItem alloc] init];
        JobName.leftStr = @"职位名称:";
        [self.contentView addSubview:JobName];
        
        //工作内容
        JobContentLab = [[baseInfoItem alloc] init];
        JobContentLab.leftStr = @"工作内容:";
        [self.contentView addSubview:JobContentLab];
        
        //工作内容
        JobContent = [[UILabel alloc] init];
        [JobContent setTextColor:COMPANY_COLOR];
        JobContent.numberOfLines = 0;
        [JobContent setTextAlignment:NSTextAlignmentLeft];
        [JobContent setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [self.contentView addSubview:JobContent];
        
        
        
        
        
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.contentView.mas_top);
            make.height.mas_equalTo(30);
        }];
        
        [companyName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(time.mas_left);
            make.right.equalTo(time.mas_right);
            make.top.equalTo(time.mas_bottom);
            make.height.mas_equalTo(time.mas_height);
        }];
        [JobName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(companyName.mas_left);
            make.right.equalTo(companyName.mas_right);
            make.top.equalTo(companyName.mas_bottom);
            make.height.mas_equalTo(companyName.mas_height);
        }];
        [JobContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(JobName.mas_left);
            make.right.equalTo(JobName.mas_right);
            make.top.equalTo(JobName.mas_bottom);
            make.height.mas_equalTo(JobName.mas_height);
        }];
        [JobContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(JobContentLab.mas_left);
            make.right.equalTo(JobContentLab.mas_right);
            make.top.equalTo(JobContentLab.mas_bottom);
            
        }];
        
        
        
    }
    
    return self;
}



- (CGFloat)getHeightCell{
    [self layoutIfNeeded];
    return [self.contentView.subviews lastObject].frame.origin.y+[self.contentView.subviews lastObject].frame.size.height+10;
}


- (void)setModel:(NSMutableDictionary *)model{
    time.rightStr = [NSString stringWithFormat:@"%@-%@",[model objectForKey:@"begin_date"],[model objectForKey:@"end_date"]];
    companyName.rightStr = [model objectForKey:@"company_name"];
    JobName.rightStr = [model objectForKey:@"position"];
    JobContentLab.rightStr = [model objectForKey:@"introduce"];
    
}


@end
