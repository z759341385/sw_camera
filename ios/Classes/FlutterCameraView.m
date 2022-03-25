//
//  FlutterCameraView.m
//  sw_camera
//
//  Created by SleepWalker on 2022/3/22.
//

#import "FlutterCameraView.h"
#import "SWCameraUtil.h"

@interface FlutterCameraView()

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,assign) int64_t _viewId;

@property (nonatomic,strong) SWCameraUtil* util;

@end
@implementation FlutterCameraView

- (SWCameraUtil *)util {
    if(!_util) {
        _util = [SWCameraUtil shareInstance];
    }
    return _util;
}

- (nonnull UIView *)view {
    return self.contentView;
}

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger
{
    self = [super init];
    if(self) {
        double width = [args[@"width"] doubleValue];
        double height = [args[@"height"] doubleValue];
        frame = CGRectMake(0, 0, width,height);
        if (frame.size.width==0) {
            frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
        [self.util createPrewPlayer:frame];
        self.contentView = [[UIView alloc] initWithFrame:frame];
        self.contentView.backgroundColor = [UIColor blackColor];
        [self.contentView.layer addSublayer:self.util.previewLayer];
        [self.util finishCreated];
        self._viewId = viewId;
    }
    return self;
}


@end
