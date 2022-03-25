#import "SwCameraPlugin.h"
#import "FlutterCameraViewFactory.h"
#import "SWCameraUtil.h"
#import <Flutter/Flutter.h>

@interface SwCameraPlugin()

@end
@implementation SwCameraPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"sw_camera"
                                     binaryMessenger:[registrar messenger]];
    FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:@"sw_camera_event" binaryMessenger:[registrar messenger]];
    SwCameraPlugin* instance = [[SwCameraPlugin alloc] init];
    SWCameraUtil *util = [SWCameraUtil shareInstance];
    [eventChannel setStreamHandler:util.streamHandler];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar registerViewFactory:[[FlutterCameraViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.flutter.swcamera"];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if([@"sw_takepicture" isEqualToString:call.method]) {
        [[SWCameraUtil shareInstance] takePicture:^(FlutterStandardTypedData * _Nonnull image) {
            result(image);
        }];
    }else if([@"closeCamera" isEqualToString:call.method]) {
        [[SWCameraUtil shareInstance] closeCamera];
    }else if([@"activeCamera" isEqualToString:call.method]) {
        [[SWCameraUtil shareInstance] activeCamera];
    }else if([@"changeFace" isEqualToString:call.method]) {
        [[SWCameraUtil shareInstance] changeCameraDirection];
    }else if([@"setQuality" isEqualToString:call.method]) {
        [[SWCameraUtil shareInstance] setCameraPrewQulity:[call.arguments intValue]];
    }else if([@"turnOnLight" isEqualToString:call.method]) {
        [[SWCameraUtil shareInstance] turnOnLight];
    }else if([@"turnOffLight" isEqualToString:call.method]) {
        [[SWCameraUtil shareInstance] turnOffLight];
    }else {
        result(FlutterMethodNotImplemented);
    }
}

@end
