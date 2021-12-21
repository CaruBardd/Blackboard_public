import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:blackboard_public/domain/models/social_event_serializer.dart';
import 'package:blackboard_public/domain/services/http_get_interface.dart';
import 'package:blackboard_public/domain/use_cases/controllers/internet_connection.dart';

// Clase SeatGeekService
//  - Implementar la Interfaz de HttpGetInterface
//  - Se encarga de ofrecer los servicios HTTP con la API de seatgeek
class SeatGeekService extends InternetConnectionController
    implements HttpGetInterface {
  // Atributos
  final String uname = 'MjQ4MjU1NTF8MTYzODkwODEwMC4wNzE1MjYz';
  final String pword =
      '3421778f98505ea28646b488b34b7fd3f296944702d624f7fe1101a9b28633c5';
  final String baseUrl = 'https://api.seatgeek.com/2';
  final InternetConnectionController _controller =
      Get.find<InternetConnectionController>();

  @override
  // Método listarPost()
  //  - Devuelve un Future<List<Post>>
  //  - Requiere un map
  //  - Realizar una petición de red tipo GET
  Future<List<SocialEvent>> listarDatos({Map? map}) async {
    // Al trabajar con http, pero la API solamente brinda curl, se usa herramienta
    // https://curlconverter.com/#dart
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));
    var uri = Uri.parse('$baseUrl/events');
    final response = await http.get(uri, headers: {'Authorization': authn});
    if (response.statusCode == 200) {
      // No usar compute() dentro de una clase o método. Es "Ilegal" (Respecto a Dart).
      // Es preciso listar la respuesta de GET de manera manual.
      var res = json.decode(response.body);
      final List<SocialEvent> social_event = [];
      for (var event in res['events']) {
        social_event.add(SocialEvent.fromJson(event));
      }
      return social_event;
    } else {
      throw Exception('Falló en obtener el listado');
    }
  }

  // Método pasarAListas()
  //  - Devuelve un Vector compuesto de SocialEvent
  //  - Requiere un String response.body como parámetro
  //  - Convierte a SocialEvent en una Lista y la devuelve
  List<SocialEvent> pasarAListas(String responseBody) {
    final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();
    return pasar.Map<SocialEvent>((json) => SocialEvent.fromJson(json))
        .toList();
  }
}
