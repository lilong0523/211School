//
//  educationCell.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "educationCell.h"
#import "baseInfoItem.h"

@implementation educationCell
{
    baseInfoItem *Time;//时间
    baseInfoItem *school;//毕业学校
    baseInfoItem *level;//学历
    baseInfoItem *major;//专业
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
        Time = [[baseInfoItem alloc] init];
        Time.leftStr =   @"时        间:";
        
        [self.contentView addSubview:Time];
        //毕业学校
        school = [[baseInfoItem alloc] init];
        school.leftStr = @"毕业学校:";
        [self.contentView addSubview:school];
        
        //学历
        level = [[baseInfoItem alloc] init];
        level.leftStr = @"学        历:";
        [self.contentView addSubview:level];
        
        //专业
        major = [[baseInfoItem alloc] init];
        major.leftStr = @"专        业:";
        [self.contentView addSubview:major];
        
        
        
        
        
        [Time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.contentView.mas_top);
            make.height.mas_equalTo(30);
        }];
        
        [school mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(Time.mas_left);
            make.right.equalTo(Time.mas_right);
            make.top.equalTo(Time.mas_bottom);
            make.height.mas_equalTo(Time.mas_height);
        }];
        [level mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(school.mas_left);
            make.right.equalTo(school.mas_right);
            make.top.equalTo(school.mas_bottom);
            make.height.mas_equalTo(school.mas_height);
        }];
        [major mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(level.mas_left);
            make.right.equalTo(level.mas_right);
            make.top.equalTo(level.mas_bottom);
            make.height.mas_equalTo(level.mas_height);
        }];
        
        
        
    }
    
    return self;
}



- (CGFloat)getHeightCell{
    [self layoutIfNeeded];
    return [self.contentView.subviews lastObject].frame.origin.y+[self.contentView.subviews lastObject].frame.size.height+10;
}

- (void)setModel:(NSMutableDictionary *)model{
    _model = model;
    [Time setRightStr:[NSString stringWithFormat:@"%@-%@",[model objectForKey:@"begin_date"],[model objectForKey:@"end_date"]]];
    [school setRightStr:[model objectForKey:@"school_name"]];
    [level setRightStr:[model objectForKey:@"educations"]];
    [major setRightStr:[model objectForKey:@"profession"]];
    
}

@end
