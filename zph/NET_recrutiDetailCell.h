//
//  NET_recrutiDetailCell.h
//  zph
//
//  Created by 李龙 on 2016/12/27.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NET_recrutiDetaildelegate <NSObject>

- (void)updateDetail:(BOOL )isOpen;

@end

@interface NET_recrutiDetailCell : UITableViewCell

@property (strong, nonatomic) NSString *detailText;
@property (nonatomic) BOOL isOpen;

@property (nonatomic,strong) id<NET_recrutiDetaildelegate>delegate;

@property (nonatomic, copy) void(^updateBlock)();

@end
