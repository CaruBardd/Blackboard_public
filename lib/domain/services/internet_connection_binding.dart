import 'package:get/get.dart';
import 'package:red_blackboard/domain/use_cases/controllers/internet_connection.dart';

class InternetConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InternetConnectionController>(
        () => InternetConnectionController());
  }
}
