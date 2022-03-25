//
//  FlutterCameraView.h
//  sw_camera
//
//  Created by SleepWalker on 2022/3/22.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@interface FlutterCameraView : NSObject<FlutterPlatformView>

- (instancetype _Nullable )initWithWithFrame:(CGRect)frame
                  viewIdentifier:(int64_t)viewId
                       arguments:(id _Nullable)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*_Nullable)messenger;

@end
