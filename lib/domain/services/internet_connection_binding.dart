import 'package:get/get.dart';
import 'package:blackboard_public/domain/use_cases/controllers/internet_connection.dart';

class InternetConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InternetConnectionController>(
        () => InternetConnectionController());
  }
}
