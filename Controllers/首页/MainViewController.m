//
//  MainViewController.m
//  YouDian_AR
//
//  Created by youdian on 2018/5/18.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "MainViewController.h"
#import "QView.h"

#import <AMapLocationKit/AMapLocationKit.h>
//c44134d7349e4473f7b2a00f678b7b06



@interface MainViewController ()


@property (nonatomic, strong) AMapLocationManager *locationManager;
@end
@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   // self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = @"AR首页";
    [self addMainUI];
   
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    self.locationManager = [[AMapLocationManager alloc]init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =20;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 10;
  
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error){
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed){
                return;
            }
        }
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
    
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
        case 15:
            [self goViewController:@"ARMainViewController"];
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
        _functionArray = @[@"我的名片",@"HUD测试",@"iOS动画",@"进度条",@"图片验证码",@"AR在线"];
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
