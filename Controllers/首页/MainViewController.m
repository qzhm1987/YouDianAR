//
//  MainViewController.m
//  YouDian_AR
//
//  Created by youdian on 2018/5/18.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (strong, nonatomic)UIScrollView *scrollView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"AR首页";
    [self addScrollView];
    [self addScrollViewSubViews];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)addScrollView {
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
  //  _scrollView.backgroundColor = [UIColor purpleColor];
    _scrollView.showsHorizontalScrollIndicator= NO;
    _scrollView.showsVerticalScrollIndicator= NO;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0,0, 0));
    }];
}
-(void)addScrollViewSubViews{
    WS(weakSelf)
    UILabel *upLabel = [self addLabelWithText:@"上传头像"];
    [_scrollView addSubview:upLabel];
    [upLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.scrollView).offset(15);
        make.left.equalTo(weakSelf.scrollView).offset(25);
        make.size.mas_equalTo(CGSizeMake(120, 35));
    }];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    imgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imgView.layer.cornerRadius = 5.0f;
    imgView.layer.borderWidth = 0.5f;
    imgView.tag = 40;
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [imgView addGestureRecognizer:tap];
    [_scrollView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upLabel.mas_bottom).offset(0);
        make.left.equalTo(upLabel);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    UILabel *upTheme = [self addLabelWithText:@"上传主题图"];
    [_scrollView addSubview:upTheme];
    [upTheme mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.mas_bottom).offset(0);
        make.size.left.equalTo(upLabel);
    }];
    UIImageView *themeView = [[UIImageView alloc]initWithFrame:CGRectZero];
    themeView.layer.cornerRadius = 5.0f;
    themeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    themeView.layer.borderWidth = 0.5f;
    themeView.tag = 41;
    themeView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [themeView addGestureRecognizer:tap1];
    [_scrollView addSubview:themeView];
    [themeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upTheme.mas_bottom).offset(0);
        make.centerX.equalTo(weakSelf.scrollView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-50, 150));
    }];
    
    UILabel *forLabel = [self addLabelWithText:@"展示名称"];
    [self.scrollView addSubview:forLabel];
    [forLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.equalTo(upLabel);
        make.top.equalTo(themeView.mas_bottom).offset(0);
    }];
    UITextField *forTextField = [[UITextField alloc]initWithFrame:CGRectZero];
    forTextField.borderStyle = UITextBorderStyleRoundedRect;
    forTextField.placeholder = @"请输入展示名称";
    [self.scrollView addSubview:forTextField];
    [forTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(forLabel.mas_bottom).offset(0);
        make.centerX.equalTo(weakSelf.scrollView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-50, 50));
    }];
}

-(void)tap:(UITapGestureRecognizer *)tapGesture{
    DLog(@"tag = %ld",tapGesture.view.tag);
    
}







-(UILabel *)addLabelWithText:(NSString *)text{
    UILabel *label = [UILabel new];
    label.text = [NSString stringWithFormat:@"*%@",text];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:16.0f];
    return label;
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
