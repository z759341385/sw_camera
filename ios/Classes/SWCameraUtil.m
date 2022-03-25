//
//  SWCameraUtil.m
//  sw_camera
//
//  Created by SleepWalker on 2022/3/23.
//

#import "SWCameraUtil.h"


@interface SWCameraUtil()<AVCapturePhotoCaptureDelegate,FlutterStreamHandler>

@property(nonatomic,strong) CALayer *previewSuperViewLayer;

@property(nonatomic,strong) CALayer *cPreviewLayer;

@end

static SWCameraUtil *util = nil;

@implementation SWCameraUtil

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    if(util == nil) {
        dispatch_once(&onceToken, ^{
            
            util = [[SWCameraUtil alloc] init];
            SWCameraStreamHandler *streamHandler = [[SWCameraStreamHandler alloc] init];
            util.streamHandler =  streamHandler;
        });
    }
    return  util;
}

- (void)finishCreated {
    self.previewSuperViewLayer = self.previewLayer.superlayer;
}

- (void)createPrewPlayer:(CGRect)frame {
    
    /// session
    self.session = [[AVCaptureSession alloc] init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPreset3840x2160]) {
        [self.session setSessionPreset:AVCaptureSessionPreset3840x2160];
    }
    
    /// input
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    /// out
    self.imageOutPut = [[AVCapturePhotoOutput alloc]init];
    if ([self.session canAddOutput:self.imageOutPut]) {
        [self.session addOutput:self.imageOutPut];
    }
    
    /// prew
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.cPreviewLayer = self.previewLayer;
    
    /// run
    [self.session startRunning];
}

- (void)setCameraPrewQulity:(int)qulity {
    switch (qulity) {
        case 1:
        {
            [self.session setSessionPreset:AVCaptureSessionPresetLow];
        }
            break;
        case 2:
        {
            [self.session setSessionPreset:AVCaptureSessionPresetiFrame960x540];
            
        }
            break;
        case 3:
        {
            [self.session setSessionPreset:AVCaptureSessionPresetHigh];
            
        }
            break;
        case 4:
        {
            [self.session setSessionPreset:AVCaptureSessionPresetiFrame1280x720];
        }
            break;
        case 5:
        {
            [self.session setSessionPreset:AVCaptureSessionPreset3840x2160];
        }
            break;
            
        default:
            break;
    }
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ) return device;
    return nil;
}

- (void)changeCameraDirection
{
   
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount <= 1) return;
    AVCaptureDevice *newCamera = nil;
    AVCaptureDeviceInput *newInput = nil;
    AVCaptureDevicePosition position = [[self.input device] position];
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.5;
    animation.type = @"oglFlixp";
    if (position == AVCaptureDevicePositionFront) {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
        animation.subtype = kCATransitionFromLeft;
    }else{
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
        animation.subtype = kCATransitionFromRight;
    }
    [self.previewLayer addAnimation:animation forKey:nil];
    newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
    if (newInput != nil) {
        [self.session beginConfiguration];
        [self.session removeInput:self.input];
        if ([self.session canAddInput:newInput]) {
            [self.session addInput:newInput];
            self.input = newInput;
        } else {
            [self.session addInput:self.input];
        }
        [self.session commitConfiguration];
    }
}

- (void)takePicture:(TakePicture)result
{
    self.takePictureBlock = result;
    [self takePicture];
}

- (void)takePicture {
    
    AVCaptureConnection * videoConnection = [self.imageOutPut connectionWithMediaType:AVMediaTypeVideo];
    if (videoConnection ==  nil) {
        return;
    }
    AVCapturePhotoSettings *set = [AVCapturePhotoSettings photoSettings];
    [self.imageOutPut capturePhotoWithSettings:set delegate:self];
}

#pragma mark --AVCapturePhotoCaptureDelegate


-(void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError  API_AVAILABLE(ios(11.0))*)error {
    if (!error) {
        NSData *imageData = [photo fileDataRepresentation];
        UIImage *image = [UIImage imageWithData:imageData];
        FlutterStandardTypedData *data =  [FlutterStandardTypedData typedDataWithBytes:imageData];
//        self.streamHandler.eventSink(data);
        if(self.takePictureBlock) {
            self.takePictureBlock(data);
        }
    }else {

    }
}

- (void)turnOnLight
{
    if ([self.device hasTorch] && [self.device hasFlash]){
        [self.device lockForConfiguration:nil];
        [self.device setTorchMode:AVCaptureTorchModeOn];
        [self.device unlockForConfiguration];
    }else {
        NSLog(@"设备不存在闪光灯");
    }
}

- (void)turnOffLight
{
    if ([self.device hasTorch] && [self.device hasFlash]){
        [self.device lockForConfiguration:nil];
        [self.device setTorchMode:AVCaptureTorchModeOff];
        [self.device unlockForConfiguration];
    }else {
        NSLog(@"设备不存在闪光灯");
    }
}
  
- (void)closeCamera {
    if(self.session) {
        [self.session stopRunning];
    }
    [self.previewLayer removeFromSuperlayer];
}

- (void)activeCamera {
    if(self.session) {
        [self.session startRunning];
    }
    [self.previewSuperViewLayer addSublayer:self.previewLayer];
}

- (void)dealloc
{
    
}

#pragma mark --FlutterStreamHandler

- (FlutterError *)onCancelWithArguments:(id)arguments
{
    self.streamHandler.eventSink = nil;
    return  nil;
}
- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events
{
    self.streamHandler.eventSink = events;
    return nil;
}


@end
