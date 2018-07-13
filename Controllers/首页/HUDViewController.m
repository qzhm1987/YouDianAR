//
//  HUDViewController.m
//  YouDian_AR
//
//  Created by youdian on 2018/5/29.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "HUDViewController.h"
#import "MBProgressHUD+Extension.h"

@interface HUDViewController ()

@end

@implementation HUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [MBProgressHUD showActivityIndicatorWithTip:@"正在上传" inView:self.view];
    [self performSelector:@selector(hide) withObject:nil afterDelay:3];
    /*
     [SVProgressHUD showWithStatus:@"加载中"];
     [SVProgressHUD dismiss];
     //时间
     [SVProgressHUD setMinimumDismissTimeInterval:3];
     [SVProgressHUD showSuccessWithStatus:@"成功"];
     
     [SVProgressHUD showWithStatus:@"加载中"];
     [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
     [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
     
     
     [SVProgressHUD showImage:nil status:@"请输入正确的手机号"];
     [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
     [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
     
     
    [SVProgressHUD setMinimumDismissTimeInterval:3];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showInfoWithStatus:@"加载提示"];
       */
    
    // Do any additional setup after loading the view.
}

-(void)hide {
    [MBProgressHUD hideHUDInView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
