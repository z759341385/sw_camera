//
//  FlutterCameraViewFactory.m
//  sw_camera
//
//  Created by SleepWalker on 2022/3/22.
//

#import "FlutterCameraViewFactory.h"
#import "FlutterCameraView.h"

@implementation FlutterCameraViewFactory
{
    NSObject<FlutterBinaryMessenger>*_messenger;
}
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager{
    self = [super init];
    if (self) {
        _messenger = messager;
    }
    return self;
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec
{
    return  [[FlutterJSONMessageCodec alloc]init];
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    FlutterCameraView *cameraView = [[FlutterCameraView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return  cameraView;
}

@end
