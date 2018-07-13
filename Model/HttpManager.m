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

+(void)postDataWithUrl:(NSString *)urlString andParameters:(NSDictionary *)parameters success:(successBlock)success fail:(failBlock)fail {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    // NSString *urlStr = [NSString stringWithFormat:@"%@%@",HOST,path];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail( task, error);
    }];
}




@end
