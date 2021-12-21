import 'package:blackboard_public/domain/use_cases/controllers/my_location_widget_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackboard_public/domain/models/internet_connection_content.dart';
import 'package:blackboard_public/domain/models/location_mode.dart';
import 'package:blackboard_public/domain/models/record.dart';
import 'package:blackboard_public/domain/use_cases/controllers/firestore_controller.dart';
import 'package:blackboard_public/domain/use_cases/controllers/location.dart';
import 'package:blackboard_public/domain/use_cases/controllers/location_management.dart';
import 'widgets/location_card.dart';
import 'package:url_launcher/url_launcher.dart';

final databaseRef = FirebaseDatabase.instance.reference();

class LocationScreen extends StatefulWidget {
  // UsersOffers empty constructor
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LocationScreen> with InternetConnectionContent {
  var _locationController = Get.put(FirebaseController());
  late Future<List<LocationModel>> futureLocations;
  late LocationController gpsController;
  late LocationManager manager;
  late MyLocationWidgetController widgetController =
      Get.put(MyLocationWidgetController());
  var _context;
  bool _myUserLeftWidget = false;
  final items = List<String>.generate(8, (i) => "Item $i");
  final List<String> nombres = <String>[
    'Julio Mendoza',
    'Pedro Perez',
    'Teresa Alvarez',
    'Marcela Reyes'
  ];

  final List<double> distancia = <double>[5, 10, 8, 50];

  @override
  void initState() {
    super.initState();
    _locationController.suscribeUpdates();
    gpsController = Get.put(LocationController());
    widgetController = Get.put(MyLocationWidgetController());
    manager = LocationManager();
  }

  @override
  void dispose() {
    _locationController.unsuscribeUpdates();
    widgetController.setValue();
    super.dispose();
  }

  Widget _list() {
    return Obx(() {
      if (_locationController.entries.length > 0) {
        return GetX<FirebaseController>(builder: (builderController) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _locationController.entries.length,
              itemBuilder: (_context, index) {
                var element = _locationController.entries[index];
                return LocationCard(
                    title: element.user,
                    latitudeWidget: Text(
                      '${element.latitud}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    longitudeWidget: Text(
                      '${element.longitud}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    topLeftWidget:
                        otherUsersTopLeft(element.latitud, element.longitud));
              });
        });
      } else {
        return Center(
          child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.location_disabled_outlined,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text('No tienes amigos cerca.'),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  )
                ],
              )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return isConnected();
  }

  IconButton otherUsersTopLeft(double latitud, double longitud) {
    return IconButton(
        icon: const Icon(Icons.near_me_outlined),
        color: Theme.of(context).colorScheme.primary,
        onPressed: () => launch(
            'https://www.google.com/maps/search/?api=1&query=${latitud.toString()},${longitud.toString()}'));
  }

  Widget myUserTopLeft() {
    return Obx(() {
      if (widgetController.getValue() == false) {
        return IconButton(
            onPressed: (() {
              _locationController.addEntry(
                  gpsController.latitude, gpsController.longitude);
              Get.snackbar('Compartiendo ubicación',
                  'Ahora tu ubicación es visible para los demás usuarios.');
              widgetController.toogleValue();
            }),
            icon: const Icon(Icons.my_location_outlined),
            color: Theme.of(context).colorScheme.primary);
      } else {
        return IconButton(
            onPressed: (() {
              _locationController.deleteEntry();
              Get.snackbar('Ubicación removida',
                  'Tu ubicación ya no es visible para los demás usuarios.');
              widgetController.toogleValue();
            }),
            icon: const Icon(Icons.location_disabled_outlined),
            color: Theme.of(context).colorScheme.primary);
      }
    });
  }

  @override
  Widget mainWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          LocationCard(
            key: const Key("myLocationCard"),
            title: 'MI UBICACIÓN',
            latitudeWidget: Obx(() {
              return Text(
                '${gpsController.latitude.value}',
                style: Theme.of(context).textTheme.bodyText1,
              );
            }),
            longitudeWidget: Obx(() {
              return Text(
                '${gpsController.longitude.value}',
                style: Theme.of(context).textTheme.bodyText1,
              );
            }),
            onUpdate: () async {
              gpsController.location.value = null;
              final position = await manager.getCurrentLocation();
              gpsController.location.value = position;
              gpsController.latitude.value = position.latitude;
              gpsController.longitude.value = position.longitude;
              Get.snackbar('Ubicación actualizada',
                  'Latitud ${position.latitude} - Longitud: ${position.longitude}');
              _locationController.updateEntry(
                  position.latitude, position.longitude);
            },
            topLeftWidget: myUserTopLeft(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'CERCA DE MÍ',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          _list()
        ],
      ),
    );
  }
}
