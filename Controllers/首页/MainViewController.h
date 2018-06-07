//
//  MainViewController.h
//  YouDian_AR
//
//  Created by youdian on 2018/5/18.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^successBlock)(id responseObject);
typedef void(^failBlock)(NSURLSessionDataTask *  task,NSError * error);


@interface MainViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>




@property (strong, nonatomic)NSArray *functionArray;
@end
