import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_blackboard/domain/use_cases/controllers/location.dart';
import 'widgets/location_card.dart';

class LocationScreen extends StatefulWidget {
  // UsersOffers empty constructor
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LocationScreen> {
  final items = List<String>.generate(8, (i) => "Item $i");
  final List<String> nombres = <String>[
    'Julio Mendoza',
    'Pedro Perez',
    'Teresa Alvarez',
    'Marcela Reyes'
  ];

  final List<double> distancia = <double>[5, 10, 8, 50];

  @override
  Widget build(BuildContext context) {
    final controller = Controller(); // creando un objeto de tipo controller
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          LocationCard(
            key: const Key("myLocationCard"),
            title: 'MI UBICACIÓN',
            lat: 11.004,
            long: -74.721323,
            onUpdate: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'CERCA DE MÍ',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          // ListView on remaining screen space
          ListView.builder(
            itemCount: nombres.length,
            itemBuilder: (context, index) {
              //index es la variable iteradora: puede ser [0,1,2,3...n], donde n es la posicion final la lista
              return Obx(() => LocationCard(
                    title: nombres[index],
                    lat: controller.latitud[index].value,
                    long: controller.longitud[index].value,
                    distance: controller.distancia[index].value,
                    onUpdate: () {
                      controller.updateLocation(index);
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
