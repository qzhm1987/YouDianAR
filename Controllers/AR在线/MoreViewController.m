//
//  MoreViewController.m
//  YouDian_AR
//
//  Created by youdian on 2018/7/13.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "MoreViewController.h"
#import "SetViewController.h"
#import "MyCardViewController.h"
#import "NetWorkViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    SetViewController *set = [SetViewController new];
    MyCardViewController *card = [MyCardViewController new];
    NetWorkViewController *net = [NetWorkViewController new];
    self.viewControllers = @[set,card,net];
    self.toolbarItems = @[@"最新",@"推荐",@"同城"];
    [MoreViewController bgSegementControllerWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
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
