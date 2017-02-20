//
//  AlertView.h
//  Alert
//
//  Created by DreamOnes on 17/1/9.
//  Copyright © 2017年 DreamOnes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView
{
    NSString *_topTitleStr;
    NSString*_contentStr;
    NSString*_PromptStr;
    NSString*_LoginButtonStr;
    NSString*_AppointmentButtonStr;
    UIView *_subView;
    UIView *_backView;
    BOOL  _isSuccessful;
}
@property (nonatomic, copy) void(^enterBlock)();


-(id)initWithFrame:(CGRect)frame withTopTitleStr:(NSString *)ToptitleStr withContentStr:(NSString *)contentStr withPromptStr:(NSString *)PromptStr WithLoginButtonStr:(NSString *)LoginButtonStr WithAppointmentButtonStr:(NSString*)AppointmentButtonStr;
-(void)show;

@end
