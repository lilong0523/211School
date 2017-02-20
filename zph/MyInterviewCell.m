//
//  MyInterviewCell.m
//  zph
//
//  Created by 李龙 on 2017/1/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "MyInterviewCell.h"

@implementation MyInterviewCell
{
    UILabel *jobName;//职位名称
    UILabel *company;//公司名称
    UILabel *phone;//联系电话
    UIButton *statu;//状态
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
        
        jobName = [[UILabel alloc] init];
        [jobName setText:@"销售主管"];
        [jobName setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [jobName setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:jobName];
        company = [[UILabel alloc] init];
        [company setText:@"太平洋超级公司"];
        [company setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [company setTextColor:COMPANY_COLOR];
        [self.contentView addSubview:company];
        phone = [[UILabel alloc] init];
        [phone setText:@"联系电话:029-1234567"];
        [phone setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [phone setTextColor:COMPANY_COLOR];
        [self.contentView addSubview:phone];
        
        statu = [[UIButton alloc] init];
        [statu setImage:[UIImage imageNamed:@"icon_wait"] forState:UIControlStateNormal];
        [statu setTitleColor:WAITEINTER_COLOR forState:UIControlStateNormal];
        statu.adjustsImageWhenHighlighted = NO;
        [statu.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [statu.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [statu setTitle:@"等待面试" forState:UIControlStateNormal];
        [self.contentView addSubview:statu];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:COMPANY_COLOR];
        [self.contentView addSubview:line];
        
        UIButton *sendBut = [[UIButton alloc] init];
        [sendBut setTitle:@"发送消息" forState:UIControlStateNormal];
        [sendBut.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [sendBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:sendBut];
        
        UIView *line2 = [[UIView alloc] init];
        [line2 setBackgroundColor:BACKGROUND_COLOR];
        [self.contentView addSubview:line2];
        
        [jobName mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(15);
        }];
        [company mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(jobName.mas_left);
            make.top.equalTo(jobName.mas_bottom).offset(15);
        }];
        [statu mas_makeConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(15);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.centerY.equalTo(company.mas_centerY);
        }];
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(company.mas_left);
            make.top.equalTo(company.mas_bottom).offset(15);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(phone.mas_bottom).offset(15);
            make.right.equalTo(statu.mas_right);
            make.left.equalTo(jobName.mas_left);
            make.bottom.equalTo(sendBut.mas_top);
            make.height.mas_equalTo(1);
        }];
        [sendBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.left.equalTo(company.mas_left);
            make.right.equalTo(statu.mas_right);
            make.top.equalTo(line.mas_bottom);
            make.bottom.equalTo(line2.mas_top);
        }];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right);
            make.left.equalTo(self.contentView.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(5);
        }];
        
    }
    
    return self;
}


@end
