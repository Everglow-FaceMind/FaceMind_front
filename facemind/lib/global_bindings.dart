import 'package:facemind/scan_controller.dart';
import 'package:get/instance_manager.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanController>(() => ScanController());
  }
}
