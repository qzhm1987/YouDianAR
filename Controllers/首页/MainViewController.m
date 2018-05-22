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
@property (strong, nonatomic)UIImageView *headImage;
@property (strong, nonatomic)UITextField *wxTextField;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = @"AR首页";
    [self addScrollView];
    [self addScrollViewSubViews];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)addScrollView {
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.contentSize = CGSizeZero;
    _content_height = 5.0f;
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
    UIImageView *productImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    productImgView.layer.cornerRadius = 5.0f;
    productImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    productImgView.layer.borderWidth = 0.5f;
    [_scrollView addSubview:productImgView];
    _content_height += 150;
    [ productImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upProLabel.mas_bottom).offset(0);
        make.left.equalTo(upLabel);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 150));
    }];
    
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
        make.top.equalTo(productImgView.mas_bottom).offset(10);
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://m.hao123.com"]];
}
-(void)tap:(UITapGestureRecognizer *)tapGesture{
    // 创建UIImagePickerController实例
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    // 设置代理
    imagePickerController.delegate = self;
    // 是否允许编辑（默认为NO）
    imagePickerController.allowsEditing = YES;
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cacelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        DLog(@"选择相册tag = %ld",tapGesture.view.tag);
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DLog(@"选择相机tag = %ld",tapGesture.view.tag);
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置进入相机时使用前置或后置摄像头
        // imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
       
        
    }];
    
    [actionSheet addAction:photoAction];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [actionSheet addAction:cameraAction];
    }
     [actionSheet addAction:cacelAction];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
// 完成图片的选取后调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 选取完图片后跳转回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    /* 此处参数 info 是一个字典，下面是字典中的键值 （从相机获取的图片和相册获取的图片时，两者的info值不尽相同）
     * UIImagePickerControllerMediaType; // 媒体类型
     * UIImagePickerControllerOriginalImage; // 原始图片
     * UIImagePickerControllerEditedImage; // 裁剪后图片
     * UIImagePickerControllerCropRect; // 图片裁剪区域（CGRect）
     * UIImagePickerControllerMediaURL; // 媒体的URL
     * UIImagePickerControllerReferenceURL // 原件的URL
     * UIImagePickerControllerMediaMetadata // 当数据来源是相机时，此值才有效
     */
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _headImage.image = image;
    [self uploadImageToServer:image];

    
    
    
}

// 取消选取调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)uploadImageToServer:(UIImage*)image{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    NSString *urlStr = @"https://sapi.zhyell.com/api/qiniu/up";
    NSDictionary *parameters;
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData= UIImageJPEGRepresentation(image, 0.5f);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        NSString *name =@"img";
        [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"res = %@",responseObject);
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}


-(void)requestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)parameters completion:(successBlock)success failure:(failBlock)fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail( task, error);
    }];

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
