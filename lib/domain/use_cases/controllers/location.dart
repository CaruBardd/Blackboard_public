import 'package:get/get.dart';

class Controller extends GetxController {
  List<RxDouble> latitud = <RxDouble>[
    1111.0.obs,
    1111.0.obs,
    1111.0.obs,
    1111.0.obs
  ];
  List<RxDouble> longitud = <RxDouble>[
    11111111.0.obs,
    11111111.0.obs,
    11111111.0.obs,
    11111111.0.obs
  ];
  List<RxDouble> distancia = <RxDouble>[5.0.obs, 5.0.obs, 5.0.obs, 5.0.obs];

  void updateLocation(int index) {
    latitud[index].value += 10000;
    longitud[index].value = longitud[index].value - 10000000;
    distancia[index].value += 22;
  }
}
