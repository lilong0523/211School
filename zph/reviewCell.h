//
//  reviewCell.h
//  zph
//
//  Created by 李龙 on 2017/1/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

//综合评述cell
#import <UIKit/UIKit.h>

@interface reviewCell : UITableViewCell

@property(nonatomic, strong) NSMutableArray *imageArry;

- (CGFloat)getHeightCell;

@end
