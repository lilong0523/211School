//
//  SCH_SchoolCell.m
//  zph
//
//  Created by 李龙 on 2016/12/27.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "SCH_SchoolCell.h"

@implementation SCH_SchoolCell
{
    UIImageView *logo;//招聘会logo
    UILabel *name;//招聘会名称
    
    UILabel *companyNum;//公司数量
    UILabel *date;//时间
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
        [name setTextColor:JOBNAME_COLOR];
        name.numberOfLines = 0;
        [name setTextAlignment:NSTextAlignmentLeft];
        [name setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [self.contentView addSubview:name];
        
        companyNum = [[UILabel alloc] init];
        [companyNum setTextColor:COMPANY_COLOR];
        [companyNum setTextAlignment:NSTextAlignmentLeft];
        [companyNum setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [self.contentView addSubview:companyNum];
  
        date = [[UILabel alloc] init];
        [date setTextColor:COMPANY_COLOR];
        [date setTextAlignment:NSTextAlignmentLeft];
        [date setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
        [self.contentView addSubview:date];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:BACKGROUND_COLOR];
        [self.contentView addSubview:line];
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.width.mas_equalTo(70);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(logo.mas_right).offset(10);
            make.top.equalTo(logo.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            
        }];
        
       
        [companyNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name.mas_left);
            make.top.equalTo(name.mas_bottom).offset(10);
            make.right.equalTo(name.mas_right);
            make.bottom.equalTo(date.mas_top).offset(-10);
            
        }];
        
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(companyNum.mas_left);
            make.top.equalTo(companyNum.mas_bottom).offset(10);
            make.right.equalTo(companyNum.mas_right);
             make.bottom.equalTo(logo.mas_bottom);
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

- (void)setModel:(SCH_SchoolModel *)model{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEUPLOAD,model.NET_logo]];
    [logo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon_school"]];

    [name setText:model.NET_Name];
    [companyNum setText:[NSString stringWithFormat:@"%@家企业已参展",model.NET_companyNum]];
    [date setText:model.NET_Dete];

    
}

@end
