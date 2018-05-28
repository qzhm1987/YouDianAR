//
//  HttpManager.h
//  YouDian_AR
//
//  Created by youdian on 2018/5/25.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id responseObject);
typedef void(^failBlock)(NSURLSessionDataTask *  task,NSError * error);


@interface HttpManager : NSObject

/**
 单利句柄
 @ param
 @ return
 */
+(HttpManager*)requestManager;

@end
