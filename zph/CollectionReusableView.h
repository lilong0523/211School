//
//  CollectionReusableView.h
//  zph
//
//  Created by 李龙 on 2017/1/8.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextfield2.h"

@interface CollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) BaseTextfield2 *searchText;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) NSMutableArray *danMuArry;

@property (nonatomic, strong) NSMutableDictionary *model;
@property (nonatomic, copy) void(^SearchBlock)();

@end
