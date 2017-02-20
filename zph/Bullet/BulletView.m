//
//  BulletView.m
//  CommentDemo
//
//  Created by feng jia on 16/2/20.
//  Copyright © 2016年 caishi. All rights reserved.
//

#import "BulletView.h"

#define mWidth [UIScreen mainScreen].bounds.size.width
#define mHeight [UIScreen mainScreen].bounds.size.height
#define mDuration   5
#define Padding  5

#define PhotoHeight 23

@interface BulletView ()

@property BOOL bDealloc;
@end

@implementation BulletView

- (void)dealloc {
    [self stopAnimation];
    self.moveBlock = nil;
}

- (instancetype)initWithContent:(NSString *)content type:(NSString *)type{
    if (self == [super init]) {
        self.userInteractionEnabled = NO;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:13]
                                     };
        float width = [content sizeWithAttributes:attributes].width;
        self.bounds = CGRectMake(0, 0, width + Padding*4+PhotoHeight, 30);
        self.layer.cornerRadius = 15;
        self.lbComment = [UILabel new];
        self.lbComment.frame = CGRectMake(Padding*2+PhotoHeight, 0, (width), 30);
        self.lbComment.backgroundColor = [UIColor clearColor];
        self.lbComment.text = content;
        self.lbComment.font = [UIFont systemFontOfSize:13];
        self.lbComment.textColor = [UIColor whiteColor];
        
        self.photo.frame = CGRectMake(Padding, 3.5, PhotoHeight, PhotoHeight);
        self.photo.layer.cornerRadius = PhotoHeight/2;
        self.photo.layer.masksToBounds = YES;
        if ([type isEqualToString:@"IN"]) {
            self.photo.image = [UIImage imageNamed:@"椭圆-1"];
            UIImageView *imageIN = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.photo.frame.size.width-10, self.photo.frame.size.height-10)];
            [imageIN setContentMode:UIViewContentModeScaleAspectFit];
            [imageIN setImage:[UIImage imageNamed:@"人"]];
            [self.photo addSubview:imageIN];
        }
        else if ([type isEqualToString:@"RESUME"]){
            self.photo.image = [UIImage imageNamed:@"椭圆3"];
            UIImageView *imageIN = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.photo.frame.size.width-10, self.photo.frame.size.height-10)];
            [imageIN setContentMode:UIViewContentModeScaleAspectFit];
            [imageIN setImage:[UIImage imageNamed:@"icon_resume"]];
            [self.photo addSubview:imageIN];
        }
        else{
            self.photo.image = [UIImage imageNamed:@"椭圆-2"];
            UIImageView *imageIN = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.photo.frame.size.width-10, self.photo.frame.size.height-10)];
            [imageIN setContentMode:UIViewContentModeScaleAspectFit];
            [imageIN setImage:[UIImage imageNamed:@"摄像头"]];
            [self.photo addSubview:imageIN];
        }
        
        [self.photo setBackgroundColor:[UIColor orangeColor]];
        
        [self addSubview:self.lbComment];
    }
    return self;
}

- (void)startAnimation {
    
    //根据定义的duration计算速度以及完全进入屏幕的时间
    CGFloat wholeWidth = CGRectGetWidth(self.frame) + mWidth + 50;
    CGFloat speed = wholeWidth/mDuration;
    CGFloat dur = (CGRectGetWidth(self.frame) + 50)/speed;
    
    
    __block CGRect frame = self.frame;
    if (self.moveBlock) {
        //弹幕开始进入屏幕
        self.moveBlock(Start);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(dur * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //避免重复，通过变量判断是否已经释放了资源，释放后，不在进行操作
        if (self.bDealloc) {
            return;
        }
        //dur时间后弹幕完全进入屏幕
        if (self.moveBlock) {
            self.moveBlock(Enter);
        }
    });
    
    //弹幕完全离开屏幕
    [UIView animateWithDuration:mDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x = -CGRectGetWidth(frame);
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (self.moveBlock) {
            self.moveBlock(End);
        }
        [self removeFromSuperview];
    }];
}


- (void)stopAnimation {
    self.bDealloc = YES;
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}



- (UIImageView *)photo{
    if (!_photo) {
        _photo = [UIImageView new];
        _photo.clipsToBounds = NO;
        _photo.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_photo];
    }
    return _photo;
}

@end
