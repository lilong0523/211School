//
//  NET_recrutiDetailCell.m
//  zph
//
//  Created by 李龙 on 2016/12/27.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "NET_recrutiDetailCell.h"

@implementation NET_recrutiDetailCell
{
    UILabel *detail;
    UIButton *moreBut;
    UIView *mainView;
    NSInteger numberLine;
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
        detail = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width-40, 20)];
        
        [detail setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [detail setTextAlignment:NSTextAlignmentLeft];
        detail.numberOfLines = 0;
        [detail setTextColor:COMPANYINT_COLOR];
        [self.contentView addSubview:detail];
        moreBut = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, CGRectGetMaxY(detail.frame)+10, 80, 30)];
        
        [moreBut setTitle:@"查看更多" forState:UIControlStateNormal];
        [moreBut setTitle:@"收起" forState:UIControlStateSelected];
        [moreBut.titleLabel setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [moreBut.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [moreBut setTitleColor:COMPANYINT_COLOR forState:UIControlStateNormal];
        moreBut.selected = NO;
        [moreBut setImage:[UIImage imageNamed:@"icon_arrowDown-1"] forState:UIControlStateNormal];
        [moreBut setImage:[UIImage imageNamed:@"icon_upArrow"] forState:UIControlStateSelected];
        [moreBut setImageEdgeInsets:UIEdgeInsetsMake(0, moreBut.frame.size.width - moreBut.imageView.frame.origin.x - moreBut.imageView.frame.size.width, 0, 0)];
        
        [moreBut setTitleEdgeInsets:UIEdgeInsetsMake(0, -(moreBut.frame.size.width - moreBut.imageView.frame.size.width )+5, 0, 0)];
        [moreBut addTarget:self action:@selector(moreButClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:moreBut];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(moreBut.frame)+10);
    }
    
    return self;
}

- (void)setDetailText:(NSString *)detailText{
    _detailText = detailText;
    NSLog(@"%@",_detailText);
    
    //计算html字符串高度
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[_detailText dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    
    [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, htmlString.length)];
    detail.attributedText = htmlString;
    CGSize textSize = [htmlString boundingRectWithSize:(CGSize){detail.frame.size.width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    if (_isOpen == YES) {
        
        
        detail.frame = CGRectMake(20, 10, textSize.width, textSize.height);
        moreBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, CGRectGetMaxY(detail.frame)+10, 80, 30);
    }
    else{
        
        
        if (textSize.height<120) {
            moreBut.hidden = YES;
            detail.frame = CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width-40, textSize.height);
            moreBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, CGRectGetMaxY(detail.frame)+10, 80, 0);
        }
        else{
            detail.frame = CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width-40, 120);
            moreBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, CGRectGetMaxY(detail.frame)+10, 80, 30);
        }
        
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(moreBut.frame)+10);
    
}


/**
 查看更多点击
 */
- (void)moreButClick:(UIButton *)but{
    but.selected = !but.selected;
    
    if ([self.delegate respondsToSelector:@selector(updateDetail:)]) {
        if (but.selected == YES) {
            [self.delegate updateDetail:YES];
        }
        else{
            [self.delegate updateDetail:NO];
        }
        
    }
}

- (void)setIsOpen:(BOOL)isOpen{
    _isOpen = isOpen;
    moreBut.selected = _isOpen;
}


@end
