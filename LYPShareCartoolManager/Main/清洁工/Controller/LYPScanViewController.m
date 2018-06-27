//
//  LYPScanViewController.m
//  YPSharingCarton
//
//  Created by laiyp on 2017/12/21.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import "LYPScanViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
//#import <MAMapKit/MAMapKit.h>
//#import "LYPLoginVC.h"
//#import "LYPChoosePaperView.h"

#define RGBACOLOR(R,G,B,A) [UIColor colorWithRed:(R) / 255.0f green:(G) /255.0f blue:(B) / 255.0f alpha:(A)] // 自定义颜色
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define SCREENFITWIDTH  [UIScreen mainScreen].bounds.size.width / 375
#define SCREENFITHEIGHT [UIScreen mainScreen].bounds.size.height / 667

#define kMarin_Width 100
#define kMarin 30
@interface LYPScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) UIView *scanView;
@property (nonatomic, strong) UIImageView *scanImgView;
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *location;

@end

@implementation LYPScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutMaskView];
    [self setupTipTitleView];
    [self setupScanWindowView];
    if ([self xlAssetsCameraAuthority]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"此程序没有权限访问您的照片在\"设置-隐私-相机\"中开启后即可查看" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
    [self beginScanning];
//设置导航栏
    [self setUPNav];
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    获取定位
    [self startLocation];
    // 这是扫描的横线
    [self resumeAnimation];
    [self.session startRunning];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.session stopRunning];
    
}

//输入编号打开盒子
-(void)openCartonWithNumber
{
    
}

#pragma mark --Action
-(void)numberVCClick{

    NSLog(@"输入编号");
}
-(void)openLamlight:(UIButton *)sender{
   
    sender.selected = !sender.selected;
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) {
//            请求独立访问硬件设备
            [device lockForConfiguration:nil];
            if (sender.selected) {
                [device setTorchMode:AVCaptureTorchModeOn];
            }else{
                [device setTorchMode:AVCaptureTorchModeOff];
            }
//            请求解除独占访问硬件设备
            [device unlockForConfiguration];
        }
    }
}

-(void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightItemClick{
    
}

- (BOOL)xlAssetsCameraAuthority {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        // 无权限
        return YES;
    }
    return NO;
}
#pragma mark --UI
-(void)setUPNav{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNomalImage:@"navigation_back_normal" selectImage:@"" target:self action:@selector(leftItemClick)];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightItemClick) color:[UIColor whiteColor] highColor:[UIColor whiteColor] title:@"使用帮助" highTitle:@"使用帮助"];
}
#pragma mark - 添加遮罩
- (void)layoutMaskView {
    UIView *mask = [[UIView alloc] init];
    _maskView = mask;
    mask.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
    mask.layer.borderWidth = kMarin_Width;
    mask.bounds = CGRectMake(0, 0, self.view.width + kMarin_Width + kMarin, self.view.width + kMarin_Width + kMarin); // 100 30
    
    mask.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.5 + 64);
    mask.y = 64;
    [self.view addSubview:mask];
}

#pragma mark - 提示文本

- (void)setupTipTitleView {
    // 补充遮罩
    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, _maskView.y + _maskView.height, self.view.width, kMarin_Width + 50)];
    mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:mask];
    
//    输入编号开锁
    UIButton *numberBtn = [[UpAndLowerButtonPlace alloc]initWithFrame:CGRectMake(30, SCREENHEIGHT - 100, 120, 80)];
    [numberBtn setImage:[UIImage imageNamed:@"manual_input"] forState:UIControlStateNormal];
    [numberBtn setImage:[UIImage imageNamed:@"manual_input_select"] forState:UIControlStateHighlighted];
    [numberBtn setTitle:@"输入编号开锁" forState:UIControlStateNormal];
    [numberBtn addTarget:self action:@selector(numberVCClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:numberBtn];
    
//    打开手电灯
    UIButton *lamplightBtn = [[UpAndLowerButtonPlace alloc]initWithFrame:CGRectMake(SCREENWIDTH - 150, SCREENHEIGHT - 100, 120, 80)];
    [lamplightBtn setTitle:@"打开手电灯" forState:UIControlStateNormal];
    [lamplightBtn setImage:[UIImage imageNamed:@"lamplight_open"] forState:UIControlStateNormal];
    [lamplightBtn addTarget:self action:@selector(openLamlight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lamplightBtn];
    
}


#pragma mark - 扫描区域
- (void)setupScanWindowView {
    CGFloat scanWindowH = self.view.width - kMarin * 2;
    CGFloat scanWindowW = self.view.width - kMarin * 2;
    _scanView = [[UIView alloc] initWithFrame:CGRectMake(kMarin, kMarin_Width + 64, scanWindowW, scanWindowH)];
    _scanView.clipsToBounds = YES;
    [self.view addSubview:_scanView];
    
    _scanImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_huadong"]];
    _scanImgView.contentMode = UIViewContentModeScaleAspectFit;
    CGFloat buttonWH = 18;
    UIButton *topLeft = [[UIButton alloc] initWithFrame:CGRectMake(4, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"jiao_zs"] forState:UIControlStateNormal];
    [_scanView addSubview:topLeft];
    
    UIButton *topRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWindowW - buttonWH - 4, 0, buttonWH, buttonWH)];
    [topRight setImage:[UIImage imageNamed:@"jiao_ys"] forState:UIControlStateNormal];
    [_scanView addSubview:topRight];
    
    UIButton *bottomLeft = [[UIButton alloc] initWithFrame:CGRectMake(topLeft.x, scanWindowH - buttonWH - 9, buttonWH, buttonWH)];
    [bottomLeft setImage:[UIImage imageNamed:@"jiao_zx"] forState:UIControlStateNormal];
    [_scanView addSubview:bottomLeft];
    
    UIButton *bottomRight = [[UIButton alloc] initWithFrame:CGRectMake(topRight.x, bottomLeft.y, buttonWH, buttonWH)];
    [bottomRight setImage:[UIImage imageNamed:@"jiao_yx"] forState:UIControlStateNormal];
    [_scanView addSubview:bottomRight];
}

#pragma mark - 开始动画
- (void)beginScanning {
    // 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) return;
    
    // 创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // 设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 设置有效扫描区域
    CGRect scanCrop = [self getScanCrop:_scanView.bounds readerViewBounds:self.view.frame];
    output.rectOfInterest = scanCrop;
    // 初始化链接对象
    _session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:input]) {
        [_session addInput:input];
    }
    if ([_session canAddOutput:output]) {
        [_session addOutput:output];
    }
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    
    [self.view.layer insertSublayer:layer atIndex:0];
    // 开始捕获
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects.count > 0) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        NSLog(@"metadataObject.stringValue == %@", metadataObject.stringValue);
//        扫码成功之后跳转页面
        
        if ([StringEXtension isBlankString:metadataObject.stringValue]) {
            [SVStatusHUD showWithStatus:@"扫码出错啦，请重试!"];
        }else
        {
            NSString *lon = [NSString stringWithFormat:@"%f",self.location.coordinate.longitude];
            NSString *lat = [NSString stringWithFormat:@"%f",self.location.coordinate.latitude];
            
            if ([StringEXtension isBlankString:lon]) {
                [SVStatusHUD showWithStatus:@"位置获取失败，请设置允许app获取位置"];
                return;
            }
            LYPNetWorkTool *networkTool = [[LYPNetWorkTool alloc]init];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:metadataObject.stringValue,@"devicesn",lon,@"lon",lat,@"lat", nil];
            [networkTool SetLocationWithDic:dic success:^(id responseData, NSInteger responseCode) {
                [SVStatusHUD showWithStatus:@"校准成功"];
            } failure:^(id responseData, NSInteger responseCode) {
                [SVStatusHUD showWithStatus:@"校准失败，重新校准"];
            }];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        NSLog(@"metadataObject.stringValue ---- %@", metadataObject.stringValue);
    }
}
#pragma mark - 获取扫描区域的比例关系
- (CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds {
    CGFloat x, y, width, height;
    x = (CGRectGetHeight(readerViewBounds) - CGRectGetHeight(rect)) / 2 / CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds) - CGRectGetWidth(rect)) / 2 /CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect) / CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect) / CGRectGetWidth(readerViewBounds);
    return CGRectMake(x, y, width, height);
}
//请求出纸
-(void)takePaperWithDIc:(NSDictionary *)parames{

}
#pragma mark - 恢复动画

- (void)resumeAnimation {
    CAAnimation *anim = [_scanImgView.layer animationForKey:@"translationAnimation"];
    if (anim) {
        // 将动画的时间偏移量作为暂停时的时间点
        CFTimeInterval pauseTime = _scanImgView.layer.timeOffset;
        // 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        // 要把偏移时间清零
        [_scanImgView.layer setTimeOffset:0.0];
        // 设置图层的开始动画时间
        [_scanImgView.layer setBeginTime:beginTime];
        [_scanImgView.layer setSpeed:1.0];
    } else {
        CGFloat scanNetImageViewH = 100 * SCREENFITHEIGHT;
        CGFloat scanWindowH = self.view.width - kMarin * 2;
        CGFloat scanNetImageViewW = _scanView.width - (25 * 2 * SCREENFITWIDTH);
        _scanImgView.frame = CGRectMake(25 * SCREENFITWIDTH, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
        CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
        scanNetAnimation.keyPath = @"transform.translation.y";
        scanNetAnimation.byValue = @(scanWindowH);
        scanNetAnimation.duration = 1.0;
        scanNetAnimation.repeatCount = MAXFLOAT;
        [_scanImgView.layer addAnimation:scanNetAnimation forKey:@"translationAnimation"];
        [_scanView addSubview:_scanImgView];
    }
}

-(BOOL)isLocationServiceOpen {
    if ([ CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    } else
        return YES;
}
//开始定位
- (void)startLocation {
    if ([self isLocationServiceOpen]) {
        if ([CLLocationManager locationServicesEnabled]) {
            //        CLog(@"--------开始定位");
            self.locationManager = [[CLLocationManager alloc]init];
            self.locationManager.delegate = self;
            //控制定位精度,越高耗电量越
            self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            // 总是授权
            [self.locationManager requestAlwaysAuthorization];
            self.locationManager.distanceFilter = 10.0f;
            [self.locationManager requestAlwaysAuthorization];
            [self.locationManager startUpdatingLocation];
        }
    }else{
        
        UIAlertController *alertVc = [UIAlertController alertSureWithMessage:@"请允许\"共享纸盒\"获取您的位置" AndTitle:@"" sureblock:^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                //此处可以做一下版本适配，至于为何要做版本适配，大家应该很清楚
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVc animated:YES completion:nil];
    }
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}
//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *newLocation = locations[0];
    self.location = newLocation;
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}

@end
