//
//  provinceSelectCell.m
//  zph
//
//  Created by 李龙 on 2017/1/15.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "provinceSelectCell.h"

@implementation provinceSelectCell
{
    UILabel *name;
    
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
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 180, 40)];
        [name setTextAlignment:NSTextAlignmentLeft];
        [name setFont:[UIFont systemFontOfSize:15.0]];
        [name setTextColor:COMPANY_COLOR];
        [self.contentView addSubview:name];
        
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-30, 0, 8, 40)];
        [arrow setImage:[UIImage imageNamed:@"icon_arrowRight"]];
        [arrow setContentMode:UIViewContentModeScaleAspectFit];
        
        [self.contentView addSubview:arrow];
    }
    
    return self;
}

- (void)setText:(NSString *)text{
    [name setText:text];
}


@end
