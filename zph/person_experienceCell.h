//
//  person_experienceCell.h
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

//个人中心工作经验cell
#import <UIKit/UIKit.h>

@interface person_experienceCell : UITableViewCell
@property (nonatomic, strong) NSMutableDictionary *model;

@property (nonatomic, copy) void(^editBlock)();

@end
