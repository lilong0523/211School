//
//  companyIntroductCell.h
//  zph
//
//  Created by 李龙 on 2016/12/25.
//  Copyright © 2016年 李龙. All rights reserved.
//

//公司介绍cell
#import <UIKit/UIKit.h>



@protocol companyIntroductdelegate <NSObject>

- (void)updateDetail:(BOOL )isOpen;

@end

@interface companyIntroductCell : UITableViewCell

@property (strong, nonatomic) NSString *detailText;

@property (nonatomic) CGFloat cellHeight;
@property (nonatomic) BOOL isOpen;

@property (nonatomic,strong) id<companyIntroductdelegate>delegate;

@property (nonatomic, copy) void(^updateBlock)();

@end
