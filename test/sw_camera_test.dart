import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sw_camera/sw_camera.dart';

void main() {
  const MethodChannel channel = MethodChannel('sw_camera');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SwCamera.platformVersion, '42');
  });
}
