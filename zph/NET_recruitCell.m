//
//  NET_recruitCell.m
//  zph
//
//  Created by 李龙 on 2016/12/26.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "NET_recruitCell.h"

@implementation NET_recruitCell
{
    UIImageView *logo;//招聘会logo
    UILabel *name;//招聘会名称
    UIView *labelView;//标签view
    UILabel *companyNum;//公司数量
    UILabel *date;//时间
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
        [logo setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:logo];
        name = [[UILabel alloc] init];
        [name setTextColor:JOBNAME_COLOR];
        name.numberOfLines = 2;
        name.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [name setTextAlignment:NSTextAlignmentLeft];
        [name setFont:[UIFont systemFontOfSize:[myFont textFont:14.0]]];
        [self.contentView addSubview:name];
        labelView = [[UIView alloc] init];
        [self.contentView addSubview:labelView];
        companyNum = [[UILabel alloc] init];
        [companyNum setTextColor:SALARY_COLOR];
        [companyNum setTextAlignment:NSTextAlignmentLeft];
        [companyNum setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [self.contentView addSubview:companyNum];
        UIView *psView = [[UIView alloc] init];
        
        [self.contentView addSubview:psView];
        UILabel *ps = [[UILabel alloc] init];
        [ps setTextAlignment:NSTextAlignmentLeft];
        [ps setTextColor:JOBNAME_COLOR];
        [ps setText:@"家企业已入展"];
        [ps setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [psView addSubview:ps];
        
        date = [[UILabel alloc] init];
        [date setTextColor:COMPANY_COLOR];
        [date setTextAlignment:NSTextAlignmentLeft];
        [date setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
        [psView addSubview:date];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:BACKGROUND_COLOR];
        [self.contentView addSubview:line];
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(15);
          
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(60);
            
        }];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(logo.mas_right).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            
        }];
        [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name.mas_left);
            make.top.mas_greaterThanOrEqualTo(name.mas_bottom).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.bottom.equalTo(date.mas_top).offset(-12);
            
        }];
        [psView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(logo.mas_bottom).offset(10);
            make.centerX.equalTo(logo.mas_centerX);
            make.bottom.mas_greaterThanOrEqualTo(line.mas_top).offset(-5);
            
        }];
        [companyNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(psView.mas_left);
            make.top.equalTo(psView.mas_top);
            make.right.equalTo(ps.mas_left);
            make.bottom.equalTo(psView.mas_bottom);
            
        }];
        
        
        [ps mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(companyNum.mas_right);
            make.top.equalTo(psView.mas_top);
            make.right.equalTo(psView.mas_right);
            make.bottom.equalTo(psView.mas_bottom);
            
        }];
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name.mas_left);
            
            make.right.equalTo(name.mas_right);
            
            make.centerY.equalTo(psView.mas_centerY);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right);
            make.height.mas_equalTo(5);
        }];
        
        
    }
    
    return self;
}

- (void)setModel:(NET_recruitModel *)model{
 
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEUPLOAD,model.NET_logo]];
    [logo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon_deauflt"]];
    
    // 创建一个富文本
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:model.NET_Name];
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    if ([model.NET_Statu isEqualToString:@"1"]) {
        attch.image = [UIImage imageNamed:@"icon_jobIng"];
    }
    else if ([model.NET_Statu isEqualToString:@"3"]){
        attch.image = [UIImage imageNamed:@"icon_end"];
    }
    else{
        
    }
    // 设置图片大小
    attch.bounds = CGRectMake(0, -2, 40, 15);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri appendAttributedString:string];
    
    // 用label的attributedText属性来使用富文本
    name.attributedText = attri;
 
    [companyNum setText:model.NET_companyNum];
    [date setText:model.NET_Dete];
    
    UIButton *lastBut;
    for (UIView *bbq in labelView.subviews) {
        [bbq removeFromSuperview];
    }
    for (NSInteger i=0; i<model.NET_label.count; i++) {
        
        
        UIButton *labelBut = [[UIButton alloc] init];
        [labelBut setTitle:[model.NET_label objectAtIndex:i] forState:UIControlStateNormal];
        [labelBut.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
        labelBut.layer.borderWidth = 0.5;
        labelBut.layer.borderColor = COMPANY_COLOR.CGColor;
        [labelBut setTitleColor:COMPANY_COLOR forState:UIControlStateNormal];
        labelBut.layer.cornerRadius = 3;
       
        labelBut.layer.masksToBounds = YES;
        [labelView addSubview:labelBut];
        
        if (lastBut != nil) {
            [labelBut mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastBut.mas_right).offset(10);
                make.centerY.equalTo(lastBut.mas_centerY);
                make.height.mas_equalTo(17);
              
            }];
        }
        else{
            [labelBut mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(labelView.mas_left);
                make.height.mas_equalTo(17);
                make.top.equalTo(labelView.mas_top);
                make.bottom.equalTo(labelView.mas_bottom);
                
            }];
        }
        
        lastBut = labelBut;
    }
    
    
    
}

- (void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    
}


@end
