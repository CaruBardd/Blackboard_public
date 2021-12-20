import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_blackboard/domain/models/internet_connection_content.dart';
//import 'package:red_blackboard/domain/models/location_database.dart';
import 'package:red_blackboard/domain/use_cases/controllers/location.dart';
//import 'package:red_blackboard/domain/use_cases/controllers/location_controller.dart';
import 'widgets/location_card.dart';

final databaseRef = FirebaseDatabase.instance.reference();

class LocationScreen extends StatefulWidget {
  // UsersOffers empty constructor
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LocationScreen> with InternetConnectionContent {
  //var locationController = Get.put(LocationController());
  //late Future<List<Location>> futureLocations;
  var _controller = Get.put(Controller());
  var _context;
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
    //locationController.start();
  }

  @override
  void dispose() {
    //locationController.stop();
    super.dispose();
  }

  /*Widget _list() {
    return Obx(() {
      if (locationController.locations.length > 0) {
        return GetX<LocationController>(builder: (builderController) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: locationController.locations.length,
              itemBuilder: (_context, index) {
                var element = locationController.locations[index];
                return LocationCard(
                    title: element.user,
                    lat: element.latitud,
                    long: element.longitud);
              });
        });
      } else {
        return Center(
          child: Container(
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
                child: Icon(Icons.location_disabled_outlined),
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
  }*/

  @override
  Widget build(BuildContext context) {
    _context = context;
    return isConnected();
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
              lat: 11.004,
              long: -74.721,
              onUpdate: () => {} //locationController.shareLocation(10, -3.43),
              ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'CERCA DE MÍ',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          //_list()
          // ListView on remaining screen space
          ListView.builder(
            itemCount: nombres.length,
            itemBuilder: (context, index) {
              //index es la variable iteradora: puede ser [0,1,2,3...n], donde n es la posicion final la lista
              return Obx(() => LocationCard(
                    title: nombres[index],
                    lat: _controller.latitud[index].value,
                    long: _controller.longitud[index].value,
                    distance: _controller.distancia[index].value,
                    onUpdate: () {
                      _controller.updateLocation(index);
                    },
                  ));
            },
            // Avoid scrollable inside scrollable
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}
