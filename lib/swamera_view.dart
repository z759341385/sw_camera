import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SWCameraView extends StatefulWidget {
  double? width;
  double? height;
  SWCameraView({Key? key, this.width, this.height}) : super(key: key);

  @override
  State<SWCameraView> createState() => _SWCameraViewState();
}

class _SWCameraViewState extends State<SWCameraView> {
  static const EventChannel _eventChannel = EventChannel('sw_camera_event');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: UiKitView(
        viewType: "com.flutter.swcamera",
        creationParams: {'width': widget.width, 'height': widget.height},
        creationParamsCodec: JSONMessageCodec(),
        onPlatformViewCreated: (result) {
          print('install camera success $result');
        },
      ),
    );
  }
}
