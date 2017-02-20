//
//  ConferenceCell.h
//  zph
//
//  Created by 李龙 on 2017/1/21.
//  Copyright © 2017年 李龙. All rights reserved.
//

//职位块
#import <UIKit/UIKit.h>
#import "ConferenceModel.h"

@interface ConferenceCell : UICollectionViewCell

@property (strong, nonatomic) ConferenceModel *model;
@property (strong, nonatomic) NSString *backImage;

@end
