//
//  MBProgressHUD+Extension.h
//  MBProgressHUD-Extension
//
//  Created by yanwu wei on 2017/4/6.
//  Copyright © 2017年 Ivan. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Extension)

+ (void)showTip:(NSString *)tip;

+ (MBProgressHUD *)showActivity;

/** 自动消失：文字和图片(放到指定view中) */
+ (void)showTipAutoHide:(NSString *)tip icon:(NSString *)icon inView:(UIView *)view;

/** 手动消失：菊花和文字(放到指定view中) */
+ (MBProgressHUD *)showActivityIndicatorWithTip:(NSString *)tip inView:(UIView *)view;

/** 手动隐藏HUD */
+ (void)hideHUD;

/** 手动隐藏HUD(HUD在指定view中) */
+ (void)hideHUDInView:(UIView *)view;


@end
