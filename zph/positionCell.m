//
//  positionCell.m
//  zph
//
//  Created by 李龙 on 2016/12/25.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "positionCell.h"

@implementation positionCell
{
    UILabel *posionName;
    UILabel *salary;
    UILabel *date;
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
        posionName = [[UILabel alloc] init];
        [posionName setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [posionName setTextAlignment:NSTextAlignmentLeft];
        [posionName setTextColor:[UIColor colorWithHexString:@"#303030"]];
        [self.contentView addSubview:posionName];
        
        salary = [[UILabel alloc] init];
        [salary setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [salary setTextAlignment:NSTextAlignmentRight];
        [salary setTextColor:[UIColor colorWithHexString:@"#FA5666"]];
        [self.contentView addSubview:salary];
        
        date = [[UILabel alloc] init];
        [date setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [date setTextAlignment:NSTextAlignmentRight];
        [date setTextColor:[UIColor colorWithHexString:@"#848484"]];
        [self.contentView addSubview:date];
        
        UIImageView *arrow = [[UIImageView alloc] init];
        [arrow setImage:[UIImage imageNamed:@"icon_arrowRight"]];
        [arrow setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:arrow];
        
        [posionName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        [salary mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(posionName.mas_right).offset(10);
            make.centerY.equalTo(posionName.mas_centerY);
            make.right.equalTo(date.mas_left).offset(-5);
            make.width.mas_equalTo(90);
        }];
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.left.equalTo(salary.mas_right).offset(10);
            make.centerY.equalTo(posionName.mas_centerY);
            make.right.equalTo(arrow.mas_left).offset(-10);
            make.width.mas_equalTo(90);
        }];
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(date.mas_right).offset(10);
            make.centerY.equalTo(posionName.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.width.mas_equalTo(15);
            
        }];
        
    }
    
    return self;
}


- (void)setModel:(posionModel *)model{
    [posionName setText:model.P_posionName];
    [salary setText:model.P_salary];
    [date setText:model.P_date];
}


@end
