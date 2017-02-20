//
//  JobExperienceCell.h
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

//工作经验cell
#import <UIKit/UIKit.h>

@interface JobExperienceCell : UITableViewCell
@property (nonatomic, strong) NSMutableDictionary *model;

- (CGFloat)getHeightCell;

@end
