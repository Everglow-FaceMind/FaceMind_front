// import 'package:camera/camera.dart';
import 'package:camera/camera.dart';
import 'package:facemind/global_bindings.dart';
import 'package:facemind/utils/user_store.dart';
import 'package:facemind/view/home/camera_screen.dart';
import 'package:facemind/view/home/home_view.dart';
import 'package:facemind/view/splash.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

late List<CameraDescription> _cameras = [];

Future<void> main() async {
  /// 한국어 포맷
  await initializeDateFormatting('ko_KR');

  /// GetX에서 전역으로 UserStore 접근
  final UserStore userStore = UserStore();
  Get.lazyPut(() => userStore, fenix: true);

  // 카메라
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 기본 언어를 한국어로 설정
      locale: Locale('ko', 'KR'),
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      //임시임
      // home: HomeView(),
      home: CameraScreen(),
      initialBinding: GlobalBindings(),
    );
  }
}
