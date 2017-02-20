//
//  ChatViewController.h
//  zph
//
//  Created by 李龙 on 2017/1/5.
//  Copyright © 2017年 李龙. All rights reserved.
//

//聊天页面
#import "EaseMessageViewController.h"

@interface ChatViewController : EaseMessageViewController
@property(nonatomic, strong) NSString *topTitle;//title
@property(nonatomic, strong) NSString *address;//公司地址
@property(nonatomic, strong) NSString *phone;//公司电话

@end
