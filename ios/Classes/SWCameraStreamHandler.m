//
//  SWCameraStreamHandler.m
//  sw_camera
//
//  Created by SleepWalker on 2022/3/23.
//

#import "SWCameraStreamHandler.h"

@implementation SWCameraStreamHandler

- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
    self.eventSink = eventSink;
    return nil;
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
    self.eventSink = nil;
    return nil;
}

@end
