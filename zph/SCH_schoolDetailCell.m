//
//  SCH_schoolDetailCell.m
//  zph
//
//  Created by 李龙 on 2017/1/16.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "SCH_schoolDetailCell.h"

@implementation SCH_schoolDetailCell
{
    UILabel *posionName;
    
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
        
        UIImageView *arrow = [[UIImageView alloc] init];
        [arrow setImage:[UIImage imageNamed:@"icon_arrowRight"]];
        [arrow setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:arrow];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:LINE_COLOR];
        [self.contentView addSubview:line];
        
        [posionName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(posionName.mas_right).offset(10);
            make.centerY.equalTo(posionName.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.width.mas_equalTo(15);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
    }
    
    return self;
}


- (void)setModel:(NSMutableDictionary *)model{
    [posionName setText:[NSString stringWithFormat:@"%@、%@",[model objectForKey:@"rn"],[model objectForKey:@"company_name"]]];
    
    
}

@end
