//
//  messageCell.m
//  zph
//
//  Created by 李龙 on 2017/1/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "messageCell.h"

@implementation messageCell
{
    UIImageView *logo;
    UILabel *company;//公司名
    UILabel *Time;//时间
    UILabel *detail;//详细
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
        
        company = [[UILabel alloc] init];
        [company setText:@"美国耐克电钻公司"];
        [company setTextAlignment:NSTextAlignmentLeft];
        [company setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [company setTextColor:JOBNAME_COLOR];
        [self.contentView addSubview:company];

        Time = [[UILabel alloc] init];
        [Time setText:@"昨天14:20"];
        [Time setTextAlignment:NSTextAlignmentRight];
        [Time setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
        [Time setTextColor:[UIColor colorWithHexString:@"#36D9A2"]];
        [self.contentView addSubview:Time];
        
        detail = [[UILabel alloc] init];
        [detail setText:@"你对我们公司感兴趣吗？"];
        [detail setTextAlignment:NSTextAlignmentLeft];
        [detail setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [detail setTextColor:COMPANY_COLOR];
        [self.contentView addSubview:detail];
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:BACKGROUND_COLOR];
        [self.contentView addSubview:line];
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(39);
            
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(15);
        }];
        [company mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.right.equalTo(Time.mas_left).offset(-5);
            make.left.equalTo(logo.mas_right).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(15);
        }];
        [Time mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.left.mas_greaterThanOrEqualTo(company.mas_right).offset(5);
            make.centerY.equalTo(company.mas_centerY);
        }];
        
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(company.mas_right);
            make.left.equalTo(company.mas_left);
            make.bottom.mas_lessThanOrEqualTo(line.mas_top).offset(-5);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView.mas_right);
            make.left.equalTo(self.contentView.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(2);
        }];
        
    }
    
    return self;
}

@end
