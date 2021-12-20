import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsController extends GetxController {
  final RxBool location = false.obs;
  final RxBool camera = false.obs;
  final RxBool contacts = false.obs;
  bool _onWaiting = false;

  requestPermissions(String option) async {
    if (_onWaiting == false) {
      _onWaiting = true;
      switch (option) {
        case 'location':
          if (await Permission.location.request().isGranted) {
            location.value = true;
            _onWaiting = false;
          } else {
            location.value = false;
            _onWaiting = false;
          }
          break;
        case 'camera':
          if (await Permission.camera.request().isGranted) {
            camera.value = true;
            _onWaiting = false;
          } else {
            camera.value = false;
            _onWaiting = false;
          }
          break;
        case 'contacts':
          if (await Permission.contacts.request().isGranted) {
            contacts.value = true;
            _onWaiting = false;
          } else {
            contacts.value = false;
            _onWaiting = false;
          }
          break;
        default:
          break;
      }
    }
  }

  verifySettings() {
    openAppSettings();
  }
}
