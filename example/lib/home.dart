import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sw_camera/sw_camera.dart';
import 'package:sw_camera/sw_camera_model.dart';
import 'package:sw_camera/swamera_view.dart';

import 'new_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Uint8List _data;
  List images = [];
  int finish = 1;

  int light = 1;

  getFile() async {
    ui.decodeImageFromList(_data, (result) {
      images.add(result);
      setState(() {
        finish = 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SWCameraView(
            width: 300,
            height: 400,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.blueAccent,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '跳转',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                onTap: () async {
                  Future.delayed(Duration(microseconds: 500), () {
                    SwCamera.closeCamera;
                  });
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return NewPage(
                      images: images,
                    );
                  })).then((value) {
                    Future.delayed(Duration(milliseconds: 500), () {
                      SwCamera.activeCamera;
                    });
                  });
                },
              ),
              InkWell(
                child: Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.blueAccent,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '转换摄像头',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                onTap: () async {
                  SwCamera.changeCameraFace;
                },
              ),
              InkWell(
                child: Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.blueAccent,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '闪光灯',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                onTap: () async {
                  if (light == 1) {
                    SwCamera.turnOnLight;
                    setState(() {
                      light = 2;
                    });
                  } else {
                    SwCamera.turnOffLight;
                    setState(() {
                      light = 1;
                    });
                  }
                },
              ),
              InkWell(
                child: Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.blueAccent,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '拍照',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                onTap: () async {
                  Uint8List bytes = await SwCamera.takePicture;
                  images.add(bytes);
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('设置图像质量'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 50,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                InkWell(
                  child: Text(
                    'low',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    SwCamera.setQuality(qulity: SWCameraQuality.low);
                  },
                ),
                InkWell(
                  child: Text(
                    'frame960x540',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    SwCamera.setQuality(
                      qulity: SWCameraQuality.frame960x540,
                    );
                  },
                ),
                InkWell(
                  child: Text(
                    'high',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    SwCamera.setQuality(qulity: SWCameraQuality.high);
                  },
                ),
                InkWell(
                  child: Text(
                    'frame1280x720',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    SwCamera.setQuality(qulity: SWCameraQuality.frame1280x720);
                  },
                ),
                InkWell(
                  child: Text(
                    'frame3840x2160',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    SwCamera.setQuality(qulity: SWCameraQuality.frame3840x2160);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
