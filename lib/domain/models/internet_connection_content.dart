import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_blackboard/domain/use_cases/controllers/internet_connection.dart';

// Clase InternetConnectionContent
//  - Determina el contenido que será lanzado a partir de la conexión a internet.
class InternetConnectionContent {
  // Instancia el controlador de conexión a Internet
  final InternetConnectionController _controller =
      Get.find<InternetConnectionController>();

  // Utiliza un GetBuilder para construir a partir de la información obtenida del controlador
  Widget isConnected() {
    return GetBuilder<InternetConnectionController>(
      builder: (builder) => internetStatusContent(),
    );
  }

  // Revisa si la conexión a Internet es de tipo 1/2 (Wifi/Mobile)
  // En caso de serlo, devuelve a mainWidget()
  // En caso de que el tipo de conexión sea distinto de 1 o 2, devuelve noneConnectionWidget();
  Widget internetStatusContent() {
    if (_controller.connectionType == 1 || _controller.connectionType == 2) {
      return mainWidget();
    } else {
      return noneConnectionWidget();
    }
  }

  // Devuelve un texto
  // Al extender de esta clase, se debe usar @override
  // Contendrá el Widget que se mostrará en caso de existir conexión a Internet
  Widget mainWidget() {
    return const Text('Sobreescribir mainWidget');
  }

  // Devuelve un icono y un texto alusivos a la falta de conexión de red
  // Tiene valor por defecto, no obstante, se puede usar @override para mostrar contenido personalizado
  // Contendrá el Widget que se mostrará en caso de no existir conexión a Internet
  Widget noneConnectionWidget() {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 1,
            child: Icon(
              Icons.signal_wifi_off_outlined,
              color: Colors.black,
              size: 24,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Sin conexión a Internet',
              style: TextStyle(),
            ),
          ),
          Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }
}
