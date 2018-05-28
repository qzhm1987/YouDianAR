//
//  MyCardViewController.m
//  YouDian_AR
//
//  Created by youdian on 2018/5/25.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "MyCardViewController.h"

@interface MyCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UIScrollView *scrollView;
@property (assign, nonatomic)NSInteger content_height;
@property (strong, nonatomic)UIImageView *headImage;
@property (nonatomic ,copy) NSString *headUrl;
@property (strong, nonatomic)UIImageView *themeImage;
@property (nonatomic ,copy) NSString *themeUrl;
@property (nonatomic ,assign) NSInteger selectTag;
@property (strong, nonatomic)UITextField *nameTextField;
@property (strong, nonatomic)UITextField *jobTextField;
@property (strong, nonatomic)UITextField *comTextField;
@property (strong, nonatomic)UITextField *addressTextField;
@property (strong, nonatomic)UITextField *phoneTextField;
@property (strong, nonatomic)UITextField *emailTextField;
@property (strong, nonatomic)UITextField *urlTextField;
@property (strong, nonatomic)UITextField *wxTextField;
@property (strong, nonatomic)UITextField *qqTextField;
@property (strong, nonatomic)UIView *productView;
@property (strong, nonatomic)NSMutableArray *productArray;
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UIImageView *proImgView;


@end

@implementation MyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的名片";
    [self addCardScrollView];
    [self addScrollViewSubViews];
    
    // Do any additional setup after loading the view.
}

-(void)addCardScrollView {
    _scrollView = [[UIScrollView alloc]init];
    _content_height = 5.0f;
    _scrollView.showsHorizontalScrollIndicator= NO;
    _scrollView.showsVerticalScrollIndicator= NO;
    _scrollView.contentSize = CGSizeZero;
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
        make.top.equalTo(weakSelf.scrollView).offset(5);
        make.left.equalTo(weakSelf.scrollView).offset(20);
        make.size.mas_equalTo(CGSizeMake(120, 35));
        self.content_height += 35.0f;
    }];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    imgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imgView.layer.cornerRadius = 5.0f;
    imgView.layer.borderWidth = 0.5f;
    imgView.tag = 40;
    imgView.userInteractionEnabled = YES;
    _headImage =  imgView;
    [_scrollView addSubview:imgView];
    _content_height += 120.0f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [imgView addGestureRecognizer:tap];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upLabel.mas_bottom).offset(0);
        make.left.equalTo(upLabel);
        make.size.mas_equalTo(CGSizeMake(120, 120));
        
    }];
    UILabel *upTheme = [self addLabelWithText:@"上传主题图"];
    [_scrollView addSubview:upTheme];
    _content_height += 35.0f;
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
    [_scrollView addSubview:themeView];
    _content_height += 150;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [themeView addGestureRecognizer:tap1];
    [themeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upTheme.mas_bottom).offset(0);
        make.left.equalTo(upLabel);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 150));
        
    }];
    NSArray *array = @[@"展示名称",@"展示职位",@"企业名称",@"办公地址",@"联系号码",@"邮箱",@"网址",@"微信"];
    NSArray *placeArray = @[@"请输入展示名称",@"请输入展示职位",@"请输入企业名称(0-20个汉字)",@"请输入详细地址(0-20个汉字)",@"请输入联系人电话",@"请输入有效邮箱",@"请输入有效网址",@"请输入微信号码"];
    for (int i = 0; i<array.count; i++) {
        UILabel *forLabel = [self addLabelWithText:array[i]];
        [self.scrollView addSubview:forLabel];
        _content_height += 35;
        [forLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.left.equalTo(upLabel);
            make.top.equalTo(themeView.mas_bottom).offset(i*85);
            
        }];
        UITextField *forTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        forTextField.borderStyle = UITextBorderStyleRoundedRect;
        forTextField.placeholder = placeArray[i];
        _content_height += 50;
        forTextField.tag = 20+i;
        [self.scrollView addSubview:forTextField];
        [forTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(forLabel.mas_bottom).offset(0);
            make.left.equalTo(upLabel);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 50));
        }];
    }
    _wxTextField = (UITextField*)[self.view viewWithTag:27];
    
    UILabel *upProLabel = [self addLabelWithText:@"上传产品图"];
    [_scrollView addSubview:upProLabel];
    _content_height += 35;
    [upProLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.wxTextField.mas_bottom).offset(0);
        make.size.left.equalTo(upLabel);
    }];
    
    
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, _content_height, SCREEN_WIDTH, 165) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     _tableView.rowHeight = 155;
     _content_height += 165;
    [_scrollView addSubview:_tableView];
    [_tableView registerClass:[ARTableViewCell class] forCellReuseIdentifier:@"proCell"];
    
    
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"继续添加+" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    _content_height +=40;
    addBtn.layer.cornerRadius = 5.0f;
    addBtn.layer.borderWidth = 0.5f;
    [addBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.scrollView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.scrollView);
        make.top.equalTo(weakSelf.tableView.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    UIButton *summitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [summitBtn setTitle:@"提交" forState:UIControlStateNormal];
    summitBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    _content_height +=80;
    summitBtn.backgroundColor = RGBA(254.0f, 168.0f, 0, 1.0f);
    [summitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    summitBtn.layer.cornerRadius = 8.0f;
    [summitBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:summitBtn];
    [summitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.scrollView);
        make.top.equalTo(addBtn.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 50));
    }];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _content_height+50);
}
-(void)btnClick:(UIButton *)button{
    
}
-(void)tap:(UIGestureRecognizer*)tapGesture{
    
}

#pragma UITableViewDelegate&&DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ARTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"proCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
