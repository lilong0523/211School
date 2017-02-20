//
//  citySelectCell.m
//  zph
//
//  Created by 李龙 on 2017/1/15.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "citySelectCell.h"

@implementation citySelectCell
{
    UIImageView *selectImage;
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
        
        selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 13, 40)];
        [selectImage setImage:[UIImage imageNamed:@"icon_circle"]];
        selectImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:selectImage];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(selectImage.frame)+5, 0, 180, 40)];
        [name setTextAlignment:NSTextAlignmentLeft];
        [name setFont:[UIFont systemFontOfSize:15.0]];
        [name setTextColor:COMPANY_COLOR];
        [self.contentView addSubview:name];
        
    }
    
    return self;
}

- (void)setText:(NSString *)text{
    [name setText:text];
}

- (void)setIfSelect:(BOOL)ifSelect{
    if (ifSelect) {
        [selectImage setImage:[UIImage imageNamed:@"icon_confirmed"]];
    }
    else{
        [selectImage setImage:[UIImage imageNamed:@"icon_circle"]];
    }
}

@end
