//
//  SWCameraUtil.h
//  sw_camera
//
//  Created by SleepWalker on 2022/3/23.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SWCameraStreamHandler.h"
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^TakePicture)(FlutterStandardTypedData *image);

@interface SWCameraUtil : NSObject<FlutterStreamHandler>

@property(nonatomic,strong)AVCaptureDevice *device;

@property(nonatomic,strong)AVCaptureDeviceInput *input;

@property (nonatomic,strong)AVCapturePhotoOutput *imageOutPut;

@property(nonatomic,strong)AVCaptureSession *session;

@property(nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) SWCameraStreamHandler* streamHandler;

@property (nonatomic,copy) TakePicture takePictureBlock;

+ (instancetype)shareInstance;

/// 初始化
- (void)createPrewPlayer:(CGRect)frame;

/// 拍照
- (void)takePicture;
- (void)takePicture:(TakePicture)result;

/// 关闭相机
- (void)closeCamera;

/// 打开相机
- (void)activeCamera;

/// 设置相机质量
- (void)setCameraPrewQulity:(int)qulity;

/// 转换摄像头
- (void)changeCameraDirection;

- (void)finishCreated;

@property (nonatomic,assign) CGRect previewRect;

- (void)turnOnLight;

- (void)turnOffLight;

@end


NS_ASSUME_NONNULL_END
