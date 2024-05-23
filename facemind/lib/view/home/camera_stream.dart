// camera_stream.dart

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:facemind/view/home/camera_screen.dart';
import 'package:facemind/utils/global_colors.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

class Assets {
  static String userIcon = 'assets/icon/icon_user.png';
  static String cameraIcon = 'assets/icon/camera.png';
  static String flipCameraIcon = 'assets/icon/flip_camera.png';
}

class CameraView extends StatefulWidget {
  const CameraView({super.key});
  @override
  State<StatefulWidget> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  final List<img.Image> videoData = [];
  final List<img.Image> fullVideoData = [];

  bool isRecording = false;
  int progress = 0; // 촬영 진행 상태
  int value = 0; // 측정된 심박수

  Timer? timer;
  Uint8List? currentImage; // 현재 촬영된 이미지
  List<Uint8List> capturedImages = []; // 촬영 이미지 list

  int totalTime = 60; // second
  int frame = 30;

  double maxHeight = 0;
  double maxWidth = 0;
  double previewHeight = 0;
  double previewWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.whiteColor,
      appBar: AppBar(
        title: Text('심박수 측정하기'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.chevron_left, size: 20),
          color: GlobalColors.darkgrayColor,
        ),
        backgroundColor: GlobalColors.whiteColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          maxHeight = constraints.maxHeight;
          maxWidth = constraints.maxWidth;
          previewHeight = maxHeight / 1.8;
          previewWidth = previewHeight * 0.7;
          return Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center, // 좌우 정렬
                  children: [
                    const Spacer(),
                    Text(
                      isRecording
                          ? '측정 중...\n움직이거나 말하지 마세요'
                          : '얼굴을 가이드 선 영역에 맞추고\n촬영 버튼을 눌러 주세요!',
                      textAlign: TextAlign.center, // 텍스트 중앙 정렬
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: previewWidth,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: isRecording // false : change camera & True : 심박수
                            ? Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: GlobalColors.subBgColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    value.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: GlobalColors.darkgrayColor),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 80,
                                height: 80,
                                child: InkWell(
                                  onTap: () {},
                                  child: Image.asset(
                                    width: 60,
                                    Assets.flipCameraIcon,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      // 카메라 뷰
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: previewWidth,
                        height: previewHeight,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: CameraScreen(),
                            ),
                            Center(
                              child: Image.asset(
                                width: previewWidth - 20,
                                height: previewWidth - 20,
                                Assets.userIcon,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      // 녹화 버튼 & 진행 바
                      height: 80,
                      child: isRecording
                          ? Center(
                              child: SizedBox(
                                height: 40,
                                child: LinearProgressIndicator(
                                  minHeight: 80,
                                  value: progress / (frame * totalTime),
                                  backgroundColor: GlobalColors.lightgrayColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    GlobalColors.mainColor,
                                  ),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isRecording = true;
                                });
                                // startTimer();
                              },
                              child: Image.asset(
                                width: 60,
                                Assets.cameraIcon,
                              ),
                            ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              if (currentImage != null)
                Align(
                  alignment: Alignment.topRight,
                  child: Image.memory(
                    currentImage!,
                    width: 40,
                    height: 80,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                )
            ],
          );
        }),
      ),
    );
  }
}
