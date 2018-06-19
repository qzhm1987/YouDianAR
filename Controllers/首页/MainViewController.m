//
//  MainViewController.m
//  YouDian_AR
//
//  Created by youdian on 2018/5/18.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "MainViewController.h"
#import "QView.h"





@interface MainViewController ()



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   // self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = @"AR首页";
    [self addMainUI];
}

-(void)addMainUI{
    WS(weakSelf)
    CGFloat tabBar_H = [AppDel isIphoneX]?85:49;
    CGFloat width = (SCREEN_WIDTH-75)/3;
    for (NSInteger i = 0; i<self.functionArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = THEME_COLOR;
        button.layer.cornerRadius = 10.0f;
        button.tag = 10+i;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [button setTitle:self.functionArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        NSInteger row = (self.functionArray.count-1)/3 +1;
        float height =  SCREEN_HEIGHT-(70*(row-1)+50+UP_OFFSET+tabBar_H); //50*row+30*(row -1)+35
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view).offset(25/2.0+i%3*(width+25));
            make.size.mas_equalTo(CGSizeMake(width, 50));
            make.top.equalTo(weakSelf.view).offset(height+i/3*70);
        }];
    }
}

-(void)btnClick:(UIButton*)button{
    switch (button.tag) {
        case 10:
            [self goViewController:@"MyCardViewController"];
            break;
        case 11:
            [self goViewController:@"HUDViewController"];
            break;
        case 14:
            [self goViewController:@"NNTestViewController"];
            break;
            
        default:
            break;
    }
    
}

-(void)goViewController:(NSString *)viewController{
    UIViewController * vc = [NSClassFromString(viewController) new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark GET

-(NSArray *)functionArray{
    if (!_functionArray) {
        _functionArray = @[@"我的名片",@"HUD测试",@"iOS动画",@"进度条",@"图片验证码"];
    }
    return _functionArray;
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
