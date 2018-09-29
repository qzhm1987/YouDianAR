//
//  ARMainViewController.m
//  YouDian_AR
//
//  Created by youdian on 2018/6/26.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "ARMainViewController.h"
#import "HttpManager.h"
#import "MoreViewController.h"
#import "SetViewController.h"
#import "MyCardViewController.h"
#import "NetWorkViewController.h"


@interface ARMainViewController ()

@property (strong, nonatomic)NSArray *functionArray;
@end

@implementation ARMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    [self addARMainUI];
    
    // Do any additional setup after loading the view.
}



-(void)addARMainUI{
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
            [self goViewController:@"SetViewController"];
            break;
        case 12:
            [self netRequest];
            break;
        case 13:
             [self moreViewController];
            break;
        case 14:
            [self goViewController:@"ARScanViewController"];
            break;
        default:
            break;
    }
    
}


-(void)netRequest{
    NSString *urlStr = @"https://ar.zhyell.com/api/login/quick";
    NSString *sessionId = @"884d2069935843c437fd7e97f3b93816_f9e21578-1783-4245-8745-ed41078f24e3_e10adc3949ba59abbe56e057f20f883e";
    NSDictionary *parameters = NSDictionaryOfVariableBindings(sessionId);
    [HttpManager postDataWithUrl:urlStr andParameters:parameters success:^(id responseObject) {
        DLog(@"Res = %@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"错误error = %@",error.description);
    }];
}

-(void)moreViewController{
    MoreViewController *more = [MoreViewController new];
    
    [self.navigationController pushViewController:more animated:YES];
    
    
}
-(void)goViewController:(NSString *)viewController{
    UIViewController * vc = [NSClassFromString(viewController) new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSArray *)functionArray{
    if (!_functionArray) {
        _functionArray = @[@"我的名片",@"AR设置",@"网络请求",@"多页面",@"AR识别"];
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
