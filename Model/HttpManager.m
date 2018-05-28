//
//  HttpManager.m
//  YouDian_AR
//
//  Created by youdian on 2018/5/25.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "HttpManager.h"
static HttpManager *http = nil;

@implementation HttpManager

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t one;
    dispatch_once(&one, ^{
        if (!http) {
            http = [super allocWithZone:zone];
        }
    });
    return http;
}

+(HttpManager *)requestManager{
    return [[self alloc]init];
}






@end
