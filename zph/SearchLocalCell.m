//
//  SearchLocalCell.m
//  zph
//
//  Created by 李龙 on 2017/1/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "SearchLocalCell.h"

@implementation SearchLocalCell
{
    UIImageView *logo;
    UILabel *detail;
    
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
        [logo setImage:[UIImage imageNamed:@"icon_time-2"]];
        [logo setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:logo];
        
        detail = [[UILabel alloc] init];
        
        [detail setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [detail setTextAlignment:NSTextAlignmentLeft];
        [detail setTextColor:JOBNAME_COLOR];
        [self.contentView addSubview:detail];

        
        UIImageView *arrow = [[UIImageView alloc] init];
        [arrow setImage:[UIImage imageNamed:@"icon_arrowRight"]];
        [arrow setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:arrow];
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(15);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left).offset(20);
        }];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(logo.mas_centerY);
            make.left.equalTo(logo.mas_right).offset(10);
        }];
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.width.mas_equalTo(7);
            make.right.equalTo(self.mas_right).offset(-20);
            make.bottom.equalTo(self.mas_bottom);
            
        }];
        
    }
    
    return self;
}

- (void)setSearchStr:(NSString *)searchStr{
    [detail setText:searchStr];
}


@end
