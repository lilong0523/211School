//
//  baseInfoCell.h
//  zph
//
//  Created by 李龙 on 2017/1/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

//基本信息cell
#import <UIKit/UIKit.h>

@interface baseInfoCell : UITableViewCell


@property (nonatomic, strong) NSMutableDictionary *model;
- (CGFloat)getHeightCell;

@end
