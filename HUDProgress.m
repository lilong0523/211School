//
//  HUDProgress.m
//  Traffic
//
//  Created by 李龙 on 2016/12/13.
//  Copyright © 2016年 z.b. All rights reserved.
//

#import "HUDProgress.h"
__strong static HUDProgress *sharedDialogUtil = nil;
@implementation HUDProgress

static MBProgressHUD *HUD;
- (id)init
{
    self = [super init];
    if (self) {
        // do something
    }
    return self;
}

+ (HUDProgress *) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^ {
        sharedDialogUtil = [[self alloc] init];
    });
    return sharedDialogUtil;
}

+ (void)showHDWithString:(NSString *)string coverView:(UIView *)coverFrom{
    HUD = [MBProgressHUD showHUDAddedTo:coverFrom animated:YES];
    HUD.label.text = string;
    
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.backgroundColor = HUDBACK_COLOR;
}

+ (void)hideHDWithView:(UIView *)coverFrom{
    [MBProgressHUD hideHUDForView:coverFrom animated:YES];
}

+ (void)showHUD:(NSString *)msg {
    //    HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    //    HUD.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    //    HUD.label.textColor = [UIColor whiteColor];
    //    HUD.label.text = msg;
    //    HUD.mode = MBProgressHUDModeText;
    //    [HUD hideAnimated:YES afterDelay:1];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    hud.label.textColor = [UIColor whiteColor];
    hud.label.text = msg;
    
    [hud hideAnimated:YES afterDelay:1];
}
+ (void)hideHUD {
    [HUD hideAnimated:YES];
    [HUD removeFromSuperViewOnHide];
    HUD = nil;
}

@end
