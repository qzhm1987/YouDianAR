//
//  AppDelegate+AR.m
//  YouDian_AR
//
//  Created by youdian on 2018/5/18.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "AppDelegate+AR.h"

@implementation AppDelegate (AR)


-(BOOL)isIphoneX {
    float width= [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    return (width==375.0f&&height==812.0f);
}
@end
