//
//  JobIntentionCell.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "JobIntentionCell.h"
#import "baseInfoItem.h"

@implementation JobIntentionCell
{
    baseInfoItem *JobName;//职位名称
    baseInfoItem *JobNature;//工作性质
    
    baseInfoItem *Address;//工作地点
    baseInfoItem *salary;//期望薪资
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
        
        
        //职位名称
        JobName = [[baseInfoItem alloc] init];
        JobName.leftStr =   @"职位名称:";
        
        [self.contentView addSubview:JobName];
        //工作性质
        JobNature = [[baseInfoItem alloc] init];
        JobNature.leftStr = @"工作性质:";
        [self.contentView addSubview:JobNature];
        
              //工作地点
        Address = [[baseInfoItem alloc] init];
        Address.leftStr = @"工作地点:";
        [self.contentView addSubview:Address];
        
        //期望薪资
        salary = [[baseInfoItem alloc] init];
        salary.leftStr = @"期望薪资:";
        [self.contentView addSubview:salary];
        
        
        
        
        
        [JobName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.contentView.mas_top);
            make.height.mas_equalTo(30);
        }];
        
        [JobNature mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(JobName.mas_left);
            make.right.equalTo(JobName.mas_right);
            make.top.equalTo(JobName.mas_bottom);
            make.height.mas_equalTo(JobName.mas_height);
        }];
       
        [Address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(JobNature.mas_left);
            make.right.equalTo(JobNature.mas_right);
            make.top.equalTo(JobNature.mas_bottom);
            make.height.mas_equalTo(JobNature.mas_height);
        }];
        [salary mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(Address.mas_left);
            make.right.equalTo(Address.mas_right);
            make.top.equalTo(Address.mas_bottom);
            make.height.mas_equalTo(Address.mas_height);
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
    [JobName setRightStr:[model objectForKey:@"hope_positions"]?[model objectForKey:@"hope_positions"]:@""];
    [JobNature setRightStr:[model objectForKey:@"hope_type"]?[model objectForKey:@"hope_type"]:@""];
   
    [Address setRightStr:[model objectForKey:@"hope_areas"]?[model objectForKey:@"hope_areas"]:@""];
    [salary setRightStr:[model objectForKey:@"hope_salary"]?[model objectForKey:@"hope_salary"]:@""];
}

@end
