import 'package:flutter/material.dart';
import 'package:red_blackboard/data/services/seat_geek.dart';
import 'package:red_blackboard/domain/models/internet_connection_content.dart';
import 'package:red_blackboard/domain/models/social_event_serializer.dart';
import 'package:red_blackboard/ui/pages/content/public_offers/widgets/event_card.dart';

// Clase SocialEventScreen
//  - Extiende a la clase StatefulWidget
//  - Se encarga crear la vista del Servicio Web de Eventos Sociales
class SocialEventsScreen extends StatefulWidget {
  const SocialEventsScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

// Clase _State
// - Extiende de InternetConnectionContent
class _State extends State<SocialEventsScreen> with InternetConnectionContent {
  late SeatGeekService service;
  late Future<List<SocialEvent>> futureEvents;

  @override
  void initState() {
    super.initState();
  }

  // build ejecuta la función isConnected del paquete InternetConnectionContent
  // De ese modo determinará que contenido mostrar a partir de la conexión a Internet
  @override
  Widget build(BuildContext context) {
    return isConnected();
  }

  // En caso de existir conexión a Internet, mostrará a mainWidget
  @override
  Widget mainWidget() {
    service = SeatGeekService();
    futureEvents = service.listarDatos();
    return FutureBuilder<List<SocialEvent>>(
      future: futureEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              SocialEvent social_event = items[index];
              Performers performers = social_event.performers;
              Venue venue = social_event.venue;
              return EventCard(
                title: social_event.title,
                picUrl: performers.image,
                url: social_event.url,
                date: procesarTiempo(social_event.datetime_utc.toString()),
                place: venue.display_location,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  String procesarTiempo(String datetime) {
    List<String> time = datetime.split('T');
    List<String> fecha = time[0].split('-');
    String res = '';
    if (fecha[1] == '01') {
      res += 'Enero ';
    } else if (fecha[1] == '02') {
      res += 'Febrero ';
    } else if (fecha[1] == '03') {
      res += 'Marzo ';
    } else if (fecha[1] == '04') {
      res += 'Abril ';
    } else if (fecha[1] == '05') {
      res += 'Mayo ';
    } else if (fecha[1] == '06') {
      res += 'Junio ';
    } else if (fecha[1] == '07') {
      res += 'Julio ';
    } else if (fecha[1] == '08') {
      res += 'Agosto ';
    } else if (fecha[1] == '09') {
      res += 'Septiembre ';
    } else if (fecha[1] == '10') {
      res += 'Octubre ';
    } else if (fecha[1] == '11') {
      res += 'Noviembre ';
    } else if (fecha[1] == '12') {
      res += 'Diciembre ';
    } else {
      res += 'Mes';
    }
    res += '${fecha[2]}, ${fecha[0]} - ${time[1]}';
    return res;
  }

  // En caso de no existir conexión a Internet, mostrará a noneConnectionWidget

}
