import 'package:flutter/material.dart';
import 'package:blackboard_public/domain/models/internet_connection_content.dart';

class StatesScreen extends StatefulWidget {
  // StatesScreen empty constructor
  const StatesScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<StatesScreen> with InternetConnectionContent {
  final items = List<String>.generate(20, (i) => "Item $i");
  final List<String> nombres = <String>[
    'Julio Mendoza',
    'Pedro Perez',
    'Teresa Alvarez',
    'Marcela Reyes',
    'Delia Pinto',
    'Jose Caceres'
  ];
  final List<String> estados = <String>[
    'El evento se realizará el miércoles a las 4:00 p.m.',
    'La ponencia de mintic fue muy buena',
    'No vemos en la conferencia de Flutter',
    'Hoy el evento salió bien he cerrado un negocio',
    'Adquiriendo nuevos conocimientos',
    'Super conectado para la conferencia de Misión Tic'
  ];

  @override
  Widget build(BuildContext context) {
    return isConnected();
  }

  @override
  Widget mainWidget() {
    return GridView.builder(
      itemCount: estados.length, // The length Of the array
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 200,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ), // The size of the grid box
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(8),
        child: Text(nombres[index] + "\n\n" + " \n\n" + estados[index]),
        color: Colors.cyan[300],
      ),
    );
  }
}
