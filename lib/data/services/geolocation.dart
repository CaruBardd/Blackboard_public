import 'package:geolocator/geolocator.dart';
import 'package:blackboard_public/domain/services/location.dart';

class GpsService implements LocationInterface {
  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}
