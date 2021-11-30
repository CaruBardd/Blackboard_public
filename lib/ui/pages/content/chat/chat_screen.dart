import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  // UsersOffersScreen empty constructor
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ChatScreen> {
  final items = List<String>.generate(20, (i) => "Item $i");
  final List<String> nombres = <String>['Juan', 'Pedro', 'Carlos', 'Elder'];
  final List<String> estados = <String>['Estoy muy emocionado, me dieron el ascenso para celebrar los invito a mi casa esta noche.', 'Estoy muy emocionado ', 'Hola, cuando nos vemos', 'cuando es la conferencia'];
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return ListView.builder(
      itemCount: nombres.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Theme.of(context).colorScheme.primary,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: ListTile(
                  leading: const Icon(Icons.face),
                  title: Text(
                    nombres[index],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    estados[index],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}