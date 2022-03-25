//
//  SWCameraStreamHandler.h
//  sw_camera
//
//  Created by SleepWalker on 2022/3/23.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWCameraStreamHandler : NSObject<FlutterStreamHandler>

@property (nonatomic, strong,nullable) FlutterEventSink eventSink;

@end

NS_ASSUME_NONNULL_END
