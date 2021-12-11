import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// Clase InternetConectionController
//  - Extiende a GetxController
//  - Determinará si existe conexión a internet y de qué tipo es
class InternetConnectionController extends GetxController {
  // Tipo de conexión = 0: No internet, 1: WiFi, 2: Mobile
  RxInt connectionType = 0.obs;
  // Instancia de Connectivity
  final Connectivity _connectivity = Connectivity();
  // Stream para mantener en escucha los cambios en la conexión
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    GetConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  // Método GetConnectionType()
  //  - Retorna un futuro
  //  - Es asincrono
  //  - Busca determinar si existe conexión a internet
  //  - Si existe, determina qué tipo de conexión es
  Future<void> GetConnectionType() async {
    var connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      print(e);
    }
    return _updateState(connectivityResult);
  }

  // Método _updateState
  //  - Recibe un valor de tipo ConnectivityResult
  //  - Determina si la conexión es Wifi, Mobile o Inexistente.
  //  - Define 1 si es Wifi, 2 si es Mobile, 0 si es Inexistente.
  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        update();
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        update();
        break;
      default:
        Get.snackbar(
            'Error de Red', 'Falló al obtener el estado de conexión de red.');
        break;
    }
  }

  @override
  void onClose() {
    // Cierra el canal de escucha de conexión al cerrar la app
    _streamSubscription.cancel();
  }
}
