//
//  person_experienceCell.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "person_experienceCell.h"

@implementation person_experienceCell
{
    UILabel *time;//时间
    UILabel *company;//公司
    UILabel *position;//职位
    UIButton *edit;//编辑按钮
    UILabel *detail;//工作职责
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
        [time setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [self.contentView addSubview:time];
        
        company =[[UILabel alloc] init];
        [company setTextColor:COMPANY_COLOR];
        [company setText:@""];
        [company setFont:[UIFont systemFontOfSize:[myFont textFont:15.0]]];
        [self.contentView addSubview:company];
        position =[[UILabel alloc] init];
        [position setText:@""];
        [position setTextColor:[UIColor blackColor]];
        [position setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [self.contentView addSubview:position];
        
        detail = [[UILabel alloc] init];
        [detail setText:@""];
        detail.numberOfLines = 0;
        [detail setTextColor:COMPANY_COLOR];
        [detail setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [self.contentView addSubview:detail];
        
        edit = [[UIButton alloc] init];
        
        [edit setImage:[UIImage imageNamed:@"icon_edit-1"] forState:UIControlStateNormal];
        [edit setTitle:@"编辑" forState:UIControlStateNormal];
        [edit addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
        [edit setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
        [edit.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [edit.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:edit];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:TOPLINE_COLOR];
        [self.contentView addSubview:line];
        
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.left.equalTo(self.contentView.mas_left).offset(20);
        }];
        [company mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(time.mas_bottom).offset(12);
            make.left.equalTo(time.mas_left);
        }];
        [position mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(company.mas_bottom).offset(12);
            make.left.equalTo(company.mas_left);
        }];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(position.mas_bottom).offset(12);
            make.left.equalTo(position.mas_left);
            make.right.equalTo(edit.mas_left);
            make.bottom.mas_lessThanOrEqualTo(line.mas_top).offset(-5);
        }];
        [edit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(time.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.width.mas_equalTo(50);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(5);
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
    [company setText:[model objectForKey:@"company_name"]];
    [position setText:[model objectForKey:@"position"]];
    [detail setText:[model objectForKey:@"introduce"]];
}

@end
