//
//  BulletManager.m
//  CommentDemo
//
//  Created by feng jia on 16/2/20.
//  Copyright © 2016年 caishi. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"

@interface BulletManager()

@property (nonatomic, strong) NSMutableArray *tmpComments;
@property (nonatomic, strong) NSMutableArray *bulletQueue;

@property BOOL bStarted;
@property BOOL bStopAnimation;

@end

@implementation BulletManager
{
    NSString *currentType;
}
- (void)start {
    if (self.tmpComments.count == 0) {
        [self.tmpComments addObjectsFromArray:self.allComments];
    }
    self.bStarted = YES;
    self.bStopAnimation = NO;
    [self initBulletCommentView];
    
}

- (void)stop {
    self.bStopAnimation = YES;
    [self.bulletQueue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView *view = obj;
        [view stopAnimation];
        view = nil;
    }];
}

#pragma mark - Private
/**
 *  创建弹幕
 *
 *  @param comment    弹幕内容
 *  @param trajectory 弹道位置
 */
- (void)createBulletComment:(NSString *)comment trajectory:(Trajectory)trajectory type:(NSString *)type{
    if (self.bStopAnimation) {
        return;
    }
    //创建一个弹幕view
    BulletView *view = [[BulletView alloc] initWithContent:comment type:type];
    //设置运行轨迹
    view.trajectory = trajectory;
    __weak BulletView *weakBulletView = view;
    __weak BulletManager *myself = self;
    /**
     *  弹幕view的动画过程中的回调状态
     *  Start:创建弹幕在进入屏幕之前
     *  Enter:弹幕完全进入屏幕
     *  End:弹幕飞出屏幕后
     */
    view.moveBlock = ^(CommentMoveStatus status) {
        if (myself.bStopAnimation) {
            return ;
        }
        switch (status) {
            case Start:
                //弹幕开始……将view加入弹幕管理queue
                [self.bulletQueue addObject:weakBulletView];
                break;
            case Enter: {
                //弹幕完全进入屏幕，判断接下来是否还有内容，如果有则在该弹道轨迹对列中创建弹幕……
                NSString *comment = [myself nextComment];
                if (comment) {
                    [myself createBulletComment:comment trajectory:trajectory type:currentType];
                } else {
                    //说明到了评论的结尾了
                     [self.tmpComments addObjectsFromArray:self.allComments];
                    [myself createBulletComment:[myself nextComment] trajectory:trajectory type:currentType];
                }
                break;
            }
            case End: {
                //弹幕飞出屏幕后从弹幕管理queue中删除
                if ([myself.bulletQueue containsObject:weakBulletView]) {
                    [myself.bulletQueue removeObject:weakBulletView];
                }
                if (myself.bulletQueue.count == 0) {
                    //说明屏幕上已经没有弹幕评论了，循环开始
//                    [myself start];
                }
                break;
            }
            default:
                break;
        }
    };
    //弹幕生成后，传到viewcontroller进行页面展示
    if (self.generateBulletBlock) {
        self.generateBulletBlock(view);
    }
}
/**
 *  初始化弹幕
 */
- (void)initBulletCommentView {
    //初始化三条弹幕轨迹
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@(0), @(1), @(2),@(3)]];
    for (int i = 4; i > 0; i--) {
        NSString *comment = [NSString stringWithFormat:@"%@前,%@",[[self.tmpComments firstObject] objectForKey:@"diff"],[[self.tmpComments firstObject] objectForKey:@"content"]];
        currentType = [[self.tmpComments firstObject] objectForKey:@"log_type"];
        if (comment) {
            [self.tmpComments removeObjectAtIndex:0];
            //随机生成弹道创建弹幕进行展示（弹幕的随机飞入效果）
            NSInteger index = arc4random()%arr.count;
            Trajectory trajectory = [[arr objectAtIndex:index] intValue];
            [arr removeObjectAtIndex:index];
            [self createBulletComment:comment trajectory:trajectory type:currentType];
        } else {
            //当弹幕小于三个，则跳出
            break;
        }
    }
}

- (NSString *)nextComment {
    NSString *comment =  [NSString stringWithFormat:@"%@前,%@",[[self.tmpComments firstObject] objectForKey:@"diff"],[[self.tmpComments firstObject] objectForKey:@"content"]];
    
    if (self.tmpComments.count>0) {
        currentType = [[self.tmpComments firstObject] objectForKey:@"log_type"];
        [self.tmpComments removeObjectAtIndex:0];
        return comment;
    }
    else{
        return nil;
    }
    
}


#pragma mark - Getter


- (void)setAllComments:(NSMutableArray *)allComments{
    if (_allComments == nil) {
        _allComments = [[NSMutableArray alloc] initWithArray:allComments];
    }
}



- (NSMutableArray *)tmpComments {
    if (!_tmpComments) {
        _tmpComments = [NSMutableArray array];
    }
    return _tmpComments;
}

- (NSMutableArray *)bulletQueue {
    if (!_bulletQueue) {
        _bulletQueue = [NSMutableArray array];
    }
    return _bulletQueue;
}

@end
