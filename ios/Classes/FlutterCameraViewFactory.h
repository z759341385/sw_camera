//
//  FlutterCameraViewFactory.h
//  sw_camera
//
//  Created by SleepWalker on 2022/3/22.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
NS_ASSUME_NONNULL_BEGIN

@interface FlutterCameraViewFactory : NSObject<FlutterPlatformViewFactory>

-(instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messager;

@end

NS_ASSUME_NONNULL_END
