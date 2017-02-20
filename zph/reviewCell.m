//
//  reviewCell.m
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "reviewCell.h"

@implementation reviewCell
{
    UILabel *detail;//详情
    UIView *imageCotenter;
    
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
        
        detail = [[UILabel alloc] init];
        [detail setTextColor:COMPANY_COLOR];
        detail.numberOfLines = 0;
        [detail setText:@"职责职责职责职责职责职责职责职责职责职责职责职责职责职责职责职责职责职责职责职责职责职责职责职责"];
        [detail setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [self.contentView addSubview:detail];
        
        imageCotenter = [[UIView alloc] init];
        [self.contentView addSubview:imageCotenter];
        
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(40);
            make.right.equalTo(self.contentView.mas_right).offset(-60);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            
        }];
        [imageCotenter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.top.equalTo(detail.mas_bottom).offset(10);
        
        }];
    }
    
    return self;
}

- (void)setImageArry:(NSMutableArray *)imageArry{
    _imageArry = imageArry;
    UIImageView *lastImage;
    for (NSString *str in _imageArry) {
        UIImageView *image = [[UIImageView alloc] init];
        [image setImage:[UIImage imageNamed:str]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [imageCotenter addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastImage==nil) {
                make.left.equalTo(imageCotenter.mas_left);
            }
            else{
                
                make.left.equalTo(lastImage.mas_right).offset(5);
                
            }
            
            make.top.equalTo(imageCotenter.mas_top);
            make.width.mas_equalTo(imageCotenter.mas_width).multipliedBy(0.32);
            make.height.mas_equalTo(imageCotenter.mas_width).multipliedBy(0.32);
            make.bottom.equalTo(imageCotenter.mas_bottom);
        }];
        
        lastImage = image;
        
    }
}

- (CGFloat)getHeightCell{
    [self layoutIfNeeded];
    return [self.contentView.subviews lastObject].frame.origin.y+[self.contentView.subviews lastObject].frame.size.height+10;
}

@end
