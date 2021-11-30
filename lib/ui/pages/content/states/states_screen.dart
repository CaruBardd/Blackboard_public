import 'package:flutter/material.dart';
import 'widgets/state_card.dart';

class StatesScreen extends StatefulWidget {
  // StatesScreen empty constructor
  const StatesScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<StatesScreen> {
  final items = List<String>.generate(20, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return GridView.count(
  primary: false,
  padding: const EdgeInsets.all(20),
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  crossAxisCount: 2,
  children: <Widget>[
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Mi estado \n\n El evento se realizará el miércoles  a las 4:00 p.m."),
      
      color: Colors.cyan[300],
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Pedro Perez\n\n La ponencia de mintic fue muy buena"),
      color: Colors.cyan[300],
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text('Tereza Alvarez\n\n No vemos en la conferencia de  Flutter'),
      color: Colors.cyan[300],
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text('Marcela Reyes\n\n Hoy el evento salió bien he cerrado un negocio '),
      color: Colors.cyan[300],
    ),
    
    
  ],
);

  }
}


