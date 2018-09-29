//
//  ARScanViewController.m
//  YouDian_AR
//
//  Created by youdian on 2018/5/18.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "ARScanViewController.h"
#import "HttpManager.h"

@interface ARScanViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *photoPicker;
@end

@implementation ARScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"AR扫描";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"选择照片" forState:UIControlStateNormal];
    button.backgroundColor = THEME_COLOR;
    [button addTarget:self action:@selector(photoClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)photoClick:(UIButton *)button{
    _photoPicker = [[UIImagePickerController alloc] init];
    // 设置代理
    _photoPicker.delegate = self;
    WS(weakSelf)
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"选取图片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self->_photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置进入相机时使用前置或后置摄像头
        // weakSelf.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        [self presentViewController:weakSelf.photoPicker animated:YES completion:^{}];
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.photoPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        // weakSelf.imagePickerController.mediaTypes = @[(NSString*)kUTTypeMovie];
        [self presentViewController:weakSelf.photoPicker animated:YES completion:^{}];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cameraAction];
    [alertController addAction:photoAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}



#pragma mark - UIImagePickerControllerDelegate
// 完成图片的选取后调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 选取完图片后跳转回原控制器
    //  [picker dismissViewControllerAnimated:YES completion:nil];
    /* 此处参数 info 是一个字典，下面是字典中的键值 （从相机获取的图片和相册获取的图片时，两者的info值不尽相同）
     * UIImagePickerControllerMediaType; // 媒体类型
     * UIImagePickerControllerOriginalImage; // 原始图片
     * UIImagePickerControllerEditedImage; // 裁剪后图片
     * UIImagePickerControllerCropRect; // 图片裁剪区域（CGRect）
     * UIImagePickerControllerMediaURL; // 媒体的URL
     * UIImagePickerControllerReferenceURL // 原件的URL
     * UIImagePickerControllerMediaMetadata // 当数据来源是相机时，此值才有效
     */
    if (picker==_photoPicker) {
        UIImage *imageOrigin = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self uploadImageToServer:imageOrigin];
        
        
      
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
// 取消选取调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)uploadImageToServer:(UIImage*)image{
    WS(weakSelf)
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    NSString *urlStr = @"https://sapi.zhyell.com/api/qiniu/up";
    NSDictionary *parameters = @{@"type":@"1"};
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
        DLog(@"Res = %@",responseObject);
        NSString *data = responseObject[@"data"];
        [weakSelf uploadDataToPHPServiceWithImageUrl:data];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}



-(void)uploadDataToPHPServiceWithImageUrl:(NSString *)img{
    //NSString *type = @"dish";
   
    NSDictionary *dict = NSDictionaryOfVariableBindings(img);
    
    [HttpManager postDataWithUrl:@"https://zpi.zhyell.com/api/test/baidu_img" andParameters:dict success:^(id responseObject) {
        DLog(@"res = %@",responseObject);
        NSString *name = responseObject[@"data"][@"name"];
        DLog(@"name = %@",name);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
    
    
    
    
    
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
