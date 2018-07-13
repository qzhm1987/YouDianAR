//
//  NetWorkViewController.m
//  YouDian_AR
//
//  Created by youdian on 2018/7/3.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "NetWorkViewController.h"
#import "HttpManager.h"

@interface NetWorkViewController ()

@end

@implementation NetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网络请求";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *urlStr = @"https://ar.zhyell.com/api/admin/getInfo";
    NSString *sessionId = @"884d2069935843c437fd7e97f3b93816_f9e21578-1783-4245-8745-ed41078f24e3_e10adc3949ba59abbe56e057f20f883e";
    NSDictionary *parameters = NSDictionaryOfVariableBindings(sessionId);
    [HttpManager postDataWithUrl:urlStr andParameters:parameters success:^(id responseObject) {
        DLog(@"Res = %@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
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
