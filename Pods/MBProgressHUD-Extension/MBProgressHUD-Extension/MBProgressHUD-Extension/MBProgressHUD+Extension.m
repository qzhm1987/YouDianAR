//
//  MBProgressHUD+Extension.m
//  MBProgressHUD-Extension
//
//  Created by yanwu wei on 2017/4/6.
//  Copyright © 2017年 Ivan. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

static const CGFloat kTime = 1.0f;
static const CGFloat kTitleFontSize = 15.f;

@implementation MBProgressHUD (Extension)


/** 自动消失：文字和图片(放到指定view中) */
+ (void)showTipAutoHide:(NSString *)tip icon:(NSString *)icon inView:(UIView *)view
{
    if (view == nil)
    {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // 设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 设置图片
    //    NSString *imgStr = [NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    
    hud.detailsLabel.text = tip;
    hud.detailsLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.minSize = CGSizeMake(90, 60);
    
    [hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
    [hud.bezelView setColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f]];
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 几秒之后再消失
    [hud hideAnimated:YES afterDelay:kTime];
}


/** 手动消失：菊花和文字(放到指定view中) */
+ (MBProgressHUD *)showActivityIndicatorWithTip:(NSString *)tip inView:(UIView *)view
{
    // 把包含在 MBProgressHUD 中的菊花设置为白色
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    
    if (view == nil)
    {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // 设置模式
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.detailsLabel.text = tip;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
    hud.minSize = CGSizeMake(90, 60);
    
    [hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
    [hud.bezelView setColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f]];

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}


+ (void)showTip:(NSString *)tip
{
    return [self showTipAutoHide:tip icon:nil inView:nil];
}


+ (MBProgressHUD *)showActivity
{
    return [self showActivityIndicatorWithTip:nil inView:nil];
}


/** 隐藏HUD(HUD在Window中) */
+ (void)hideHUD
{
    [self hideHUDInView:nil];
}


/** 隐藏HUD(HUD在指定view中) */
+ (void)hideHUDInView:(UIView *)view
{
    if (view == nil)
    {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:view animated:YES];
}


@end
