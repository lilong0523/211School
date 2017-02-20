//
//  baseInfoCell.m
//  zph
//
//  Created by 李龙 on 2017/1/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "baseInfoCell.h"
#import "baseInfoItem.h"

@implementation baseInfoCell
{
    UIImageView *userLogo;//头像
    baseInfoItem *NameText;//姓名
    baseInfoItem *sex;//性别
    baseInfoItem *birthday;//生日
    baseInfoItem *Household;//户籍
    baseInfoItem *address;//现居
    baseInfoItem *education;//毕业时间
    baseInfoItem *level;//学历
    baseInfoItem *phone;//手机
    baseInfoItem *email;//邮箱
    baseInfoItem *QQ;//qq
    
    
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
        
        UILabel *logoLab = [[UILabel alloc] init];
        [logoLab setText:@"头像"];
        [logoLab setTextColor:COMPANY_COLOR];
        [logoLab setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [self.contentView addSubview:logoLab];
        userLogo = [[UIImageView alloc] init];
        
        [userLogo sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"icon_userImage"]];
        [userLogo setContentMode:UIViewContentModeScaleAspectFit];
        userLogo.layer.masksToBounds = YES;
        [self.contentView addSubview:userLogo];
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:LINE_COLOR];
        
        [self.contentView addSubview:line];
        
        
        //姓名
        NameText = [[baseInfoItem alloc] init];
        NameText.leftStr = @"姓       名:";
      
        [self.contentView addSubview:NameText];
        //性别
        sex = [[baseInfoItem alloc] init];
        sex.leftStr = @"性       别:";
        [self.contentView addSubview:sex];
        
        //生日
        birthday = [[baseInfoItem alloc] init];
        birthday.leftStr = @"生       日:";
        [self.contentView addSubview:birthday];
        
        //户籍
        Household = [[baseInfoItem alloc] init];
        Household.leftStr = @"户       籍:";
        [self.contentView addSubview:Household];
        
        //现居
        address = [[baseInfoItem alloc] init];
        address.leftStr = @"现       居:";
        [self.contentView addSubview:address];
        
        //毕业时间
        education = [[baseInfoItem alloc] init];
        education.leftStr = @"毕业时间:";
        [self.contentView addSubview:education];
        
        //学历
        level = [[baseInfoItem alloc] init];
        level.leftStr = @"学       历:";
        [self.contentView addSubview:level];
        
        //手机
        phone = [[baseInfoItem alloc] init];
        phone.leftStr = @"手       机:";
        [self.contentView addSubview:phone];
        
        //邮箱
        email = [[baseInfoItem alloc] init];
        email.leftStr = @"邮       箱:";
        [self.contentView addSubview:email];
    
        //QQ
        QQ = [[baseInfoItem alloc] init];
        QQ.leftStr = @"Q        Q:";
        [self.contentView addSubview:QQ];
        
        
        [logoLab mas_makeConstraints:^(MASConstraintMaker *make) {
  
            make.left.equalTo(self.contentView.mas_left).offset(40);
            make.top.equalTo(self.contentView.mas_top).offset(15);
        }];
        [userLogo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.centerY.equalTo(logoLab.mas_centerY);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(logoLab.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(logoLab.mas_bottom).offset(10);
            make.height.mas_equalTo(0.5);
        }];
        
        [NameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(line.mas_bottom);
            make.height.mas_equalTo(30);
        }];

        [sex mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(NameText.mas_left);
            make.right.equalTo(NameText.mas_right);
            make.top.equalTo(NameText.mas_bottom);
            make.height.mas_equalTo(NameText.mas_height);
        }];
        
        [birthday mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sex.mas_left);
            make.right.equalTo(sex.mas_right);
            make.top.equalTo(sex.mas_bottom);
            make.height.mas_equalTo(sex.mas_height);
        }];
        [Household mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(birthday.mas_left);
            make.right.equalTo(birthday.mas_right);
            make.top.equalTo(birthday.mas_bottom);
            make.height.mas_equalTo(birthday.mas_height);
        }];
        [address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(Household.mas_left);
            make.right.equalTo(Household.mas_right);
            make.top.equalTo(Household.mas_bottom);
            make.height.mas_equalTo(Household.mas_height);
        }];
        [education mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(address.mas_left);
            make.right.equalTo(address.mas_right);
            make.top.equalTo(address.mas_bottom);
            make.height.mas_equalTo(address.mas_height);
        }];
        [level mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(education.mas_left);
            make.right.equalTo(education.mas_right);
            make.top.equalTo(education.mas_bottom);
            make.height.mas_equalTo(education.mas_height);
        }];
        
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(level.mas_left);
            make.right.equalTo(level.mas_right);
            make.top.equalTo(level.mas_bottom);
            make.height.mas_equalTo(level.mas_height);
        }];
        [email mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phone.mas_left);
            make.right.equalTo(phone.mas_right);
            make.top.equalTo(phone.mas_bottom);
            make.height.mas_equalTo(phone.mas_height);
        }];
        [QQ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(email.mas_left);
            make.right.equalTo(email.mas_right);
            make.top.equalTo(email.mas_bottom);
            make.height.mas_equalTo(email.mas_height);
           
        }];
        
    }
    
    return self;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    userLogo.layer.cornerRadius = userLogo.frame.size.width/2;
    
}

- (CGFloat)getHeightCell{
    [self layoutIfNeeded];
    return [self.contentView.subviews lastObject].frame.origin.y+[self.contentView.subviews lastObject].frame.size.height+10;
}

- (void)setModel:(NSMutableDictionary *)model{
    _model = model;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HEADDOWNLOAD,[model objectForKey:@"head_pic"]]];
    [userLogo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon_userImage"]];
    [NameText setRightStr:[model objectForKey:@"name"]?[model objectForKey:@"name"]:@""];
    [sex setRightStr:[model objectForKey:@"sex"]?[model objectForKey:@"sex"]:@""];
    [birthday setRightStr:[model objectForKey:@"birth"]?[model objectForKey:@"birth"]:@""];
    [Household setRightStr:[NSString stringWithFormat:@"%@ %@",[model objectForKey:@"home_province"],[model objectForKey:@"home_city"]]];
    [address setRightStr:[NSString stringWithFormat:@"%@ %@",[model objectForKey:@"area_province"],[model objectForKey:@"area_city"]]];
    [education setRightStr:[model objectForKey:@"grad_year"]?[model objectForKey:@"grad_year"]:@""];
    [level setRightStr:[model objectForKey:@"educations"]?[model objectForKey:@"educations"]:@""];
    [phone setRightStr:[model objectForKey:@"contact_tel"]?[model objectForKey:@"contact_tel"]:@""];
    [email setRightStr:[model objectForKey:@"contact_email"]?[model objectForKey:@"contact_email"]:@""];
    [QQ setRightStr:[model objectForKey:@"bind_qq"]?[model objectForKey:@"bind_qq"]:@""];
}

@end
