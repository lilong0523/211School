//
//  ConferenceCell.m
//  zph
//
//  Created by 李龙 on 2017/1/21.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "ConferenceCell.h"

@implementation ConferenceCell
{
    UIImageView *backImageView;
    UIView *statusView;
    UILabel *statusLab;//面试状态
    UILabel *companyName;//公司名
    UIView *jobView;//工作view
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        backImageView = [[UIImageView alloc] init];
        backImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:backImageView];
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right);
        }];
        //左边图
        UIImageView *leftImage = [[UIImageView alloc] init];
        [leftImage setImage:[UIImage imageNamed:@"icon_Ellipse"]];
        [leftImage setContentMode:UIViewContentModeScaleAspectFit];
        [backImageView addSubview:leftImage];
        UIImageView *leftImageIn = [[UIImageView alloc] init];
        [leftImageIn setImage:[UIImage imageNamed:@"icon_students"]];
        [leftImageIn setContentMode:UIViewContentModeScaleAspectFit];
        [leftImage addSubview:leftImageIn];
        
        //分割线
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:[UIColor whiteColor]];
        [backImageView addSubview:line];
        
        //数字
        UILabel *number = [[UILabel alloc] init];
        [number setTextColor:[UIColor whiteColor]];
        [number setFont:[UIFont systemFontOfSize:13.0]];
        [number setText:@"1"];
        [backImageView addSubview:number];
        
        //右边人图
        UIImageView *rightImage = [[UIImageView alloc] init];
        [rightImage setImage:[UIImage imageNamed:@"icon_Ellipse"]];
        [rightImage setContentMode:UIViewContentModeScaleAspectFit];
        [backImageView addSubview:rightImage];
        UIImageView *rightImageIn = [[UIImageView alloc] init];
        [rightImageIn setImage:[UIImage imageNamed:@"icon_person"]];
        [rightImageIn setContentMode:UIViewContentModeScaleAspectFit];
        [rightImage addSubview:rightImageIn];
        
        //面试状态
        statusView = [[UIView alloc] init];
        [statusView setBackgroundColor:[UIColor whiteColor]];
        statusView.layer.masksToBounds = YES;
        [backImageView addSubview:statusView];
        statusLab = [[UILabel alloc] init];
        [statusLab setText:@""];
        [statusLab setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
        statusLab.textAlignment = NSTextAlignmentCenter;
        [statusView addSubview:statusLab];
        
        companyName = [[UILabel alloc] init];
        companyName.numberOfLines = 2;
        [companyName setText:@""];
        [companyName setFont:[UIFont systemFontOfSize:[myFont textFont:13.0]]];
        [companyName setTextColor:[UIColor whiteColor]];
        
        [backImageView addSubview:companyName];
        
        jobView = [[UIView alloc] init];
        [backImageView addSubview:jobView];
        
        UILabel *ps = [[UILabel alloc] init];
        [ps setFont:[UIFont systemFontOfSize:[myFont textFont:12.0]]];
        [ps setTextColor:[UIColor whiteColor]];
        [ps setText:@"点击申请视频面试"];
        [backImageView addSubview:ps];
        
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backImageView.mas_left).offset(5);
            make.top.equalTo(backImageView.mas_top).offset(5);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        [leftImageIn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(leftImage.mas_centerX);
            make.centerY.equalTo(leftImage.mas_centerY);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(25);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftImage.mas_right).offset(5);
            make.right.equalTo(rightImage.mas_left).offset(-5);
            make.centerY.equalTo(leftImage.mas_centerY);
            make.height.mas_equalTo(2);
        }];
        [number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftImage.mas_top);
            make.centerX.equalTo(line.mas_centerX);
            make.bottom.equalTo(line.mas_top).offset(-3);
        }];
        [statusView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(3);
            make.left.equalTo(line.mas_left).offset(10);
            make.right.equalTo(line.mas_right).offset(-10);
            make.centerX.equalTo(line.mas_centerX);
            make.bottom.equalTo(rightImage.mas_bottom);
        }];
        [statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(statusView.mas_top);
            make.left.equalTo(statusView.mas_left);
            make.right.equalTo(statusView.mas_right);
            make.centerX.equalTo(statusView.mas_centerX);
            make.bottom.equalTo(statusView.mas_bottom);
        }];
        [companyName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftImage.mas_bottom).offset(5);
            make.left.equalTo(leftImage.mas_left);
            make.right.equalTo(rightImage.mas_right);
            make.height.mas_equalTo(40);
        }];
        
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(backImageView.mas_right).offset(-5);
            make.top.equalTo(backImageView.mas_top).offset(5);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        [rightImageIn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(rightImage.mas_centerX);
            make.centerY.equalTo(rightImage.mas_centerY);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(25);
        }];
        [jobView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(companyName.mas_bottom).offset(5);
            make.left.equalTo(leftImage.mas_left);
            make.right.equalTo(rightImage.mas_right);
        }];
        [ps mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(jobView.mas_bottom).offset(5);
            make.left.equalTo(jobView.mas_left);
            make.right.equalTo(jobView.mas_right);
            make.bottom.equalTo(backImageView.mas_bottom).offset(-5);
        }];
        
    }
    return self;
}


- (void)setModel:(ConferenceModel *)model{
    [companyName setText:model.CompanyName];
    if ([model.status isEqualToString:@"1"]) {
        [statusLab setText:@"面试中"];
    }
    else{
        [statusLab setText:@"在线"];
    }
    [self layoutIfNeeded];
    for (UIView *bbq in jobView.subviews) {
        [bbq removeFromSuperview];
    }
    int h = 0;
    int w = 0;
    for (int i = 0; i<model.jobArry.count; i++) {
        UIView *jobSmallView = [[UIView alloc] initWithFrame:CGRectMake(w*(5+(jobView.frame.size.width-5)/2), h*30, (jobView.frame.size.width-5)/2, 20)];
        jobSmallView.layer.borderColor = [UIColor whiteColor].CGColor;
        jobSmallView.layer.cornerRadius = 8;
        jobSmallView.layer.masksToBounds = YES;
        jobSmallView.layer.borderWidth = 0.5;
        [jobView addSubview:jobSmallView];
        UILabel *job = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, jobSmallView.frame.size.width-10, jobSmallView.frame.size.height)];
        [job setTextAlignment:NSTextAlignmentCenter];
        [job setText:[[model.jobArry objectAtIndex:i] objectForKey:@"job_name"]];
        [job setFont:[UIFont systemFontOfSize:[myFont textFont:11.0]]];
        [job setTextColor:[UIColor whiteColor]];
        [jobSmallView addSubview:job];
        w++;
        if (w%2==0) {
            w = 0;
            h++;
        }
    }
}

- (void)setBackImage:(NSString *)backImage{
    [backImageView setImage:[UIImage imageNamed:backImage]];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    statusView.layer.cornerRadius = 8;
    
}


@end
