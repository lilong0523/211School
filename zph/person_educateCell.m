//
//  person_educateCell.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "person_educateCell.h"

@implementation person_educateCell
{
    UILabel *time;//时间
    UILabel *school;//学校
    UILabel *major;//专业
    UIButton *edit;//编辑按钮
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
        time = [[UILabel alloc] init];
        [time setTextColor:[UIColor blackColor]];
        [time setText:@""];
        [time setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [self.contentView addSubview:time];
        
        school =[[UILabel alloc] init];
        [school setTextColor:COMPANY_COLOR];
        [school setText:@""];
        [school setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [self.contentView addSubview:school];
        major =[[UILabel alloc] init];
        [major setText:@""];
        [major setTextColor:COMPANY_COLOR];
        [major setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [self.contentView addSubview:major];
        
        edit = [[UIButton alloc] init];
        
        [edit setImage:[UIImage imageNamed:@"icon_edit-1"] forState:UIControlStateNormal];
        [edit setTitle:@"编辑" forState:UIControlStateNormal];
        [edit addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
        [edit setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
        [edit.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [edit.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:edit];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:LINE_COLOR];
        [self.contentView addSubview:line];
        
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.left.equalTo(self.contentView.mas_left).offset(20);
        }];
        [school mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(time.mas_bottom).offset(12);
            make.left.equalTo(time.mas_left);
        }];
        [major mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(school.mas_bottom).offset(12);
            make.left.equalTo(school.mas_left);
        }];
        [edit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(time.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.width.mas_equalTo(50);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right);
            make.left.equalTo(self.contentView.mas_left);
            make.height.mas_equalTo(1);
        }];
        
        
    }
    
    return self;
}


/**
 编辑按钮
 */
- (void)editClick{
    if (self.editBlock) {
        self.editBlock();
    }
}

- (void)setModel:(NSMutableDictionary *)model{
    _model = model;
    [time setText:[NSString stringWithFormat:@"%@-%@",[model objectForKey:@"begin_date"],[model objectForKey:@"end_date"]]];
    [school setText:[model objectForKey:@"school_name"]];
    [major setText:[NSString stringWithFormat:@"%@ | %@",[model objectForKey:@"educations"],[model objectForKey:@"profession"]]];
}


@end
