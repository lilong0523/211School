//
//  AlertViewY.h
//  Alert
//
//  Created by DreamOnes on 17/1/9.
//  Copyright © 2017年 DreamOnes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertViewY : UIView
{
    NSString *_topTitleStr;
    NSString*_contentStr;
    NSString*_PromptStr;
    NSString*_AgreeButtonStr;
    UIView *_subView;
    UIView *_backView;
    
}
-(id)initWithFrame:(CGRect)frame withTopTitleStr:(NSString *)ToptitleStr withContentStr:(NSString *)contentStr withPromptStr:(NSString *)PromptStr WithAgreeButtonStr:(NSString *)agreeButtonStr;
-(void)show;

@end
