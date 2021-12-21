import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  // Observables
  final location = Rx<Position?>(null);

  final RxDouble latitude = 0.1.obs;
  final RxDouble longitude = 0.1.obs;
}
