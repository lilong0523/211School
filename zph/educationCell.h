//
//  educationCell.h
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

//教育背景cell
#import <UIKit/UIKit.h>

@interface educationCell : UITableViewCell

@property (nonatomic, strong) NSMutableDictionary *model;

- (CGFloat)getHeightCell;

@end
