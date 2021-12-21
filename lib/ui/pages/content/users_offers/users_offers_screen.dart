import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackboard_public/domain/models/internet_connection_content.dart';
import 'package:blackboard_public/domain/use_cases/controllers/user_offers.dart';
import 'widgets/offer_card.dart';

class UsersOffersScreen extends StatefulWidget {
  // UsersOffersScreen empty constructor
  const UsersOffersScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<UsersOffersScreen> with InternetConnectionContent {
  final items = List<String>.generate(6, (i) => "Item $i");
  final List<String> usuario = <String>[
    'Julio Mendoza',
    'Pedro Perez',
    'Teresa Alvarez',
    'Marcela Reyes',
    'Delia Pinto',
    'Jose Caceres'
  ];
  final List<String> comentario = <String>[
    'Estoy feliz, la conferencia fue super buena',
    'Mañana tenemos ponencia',
    'Hola, quien tienes las memorias',
    'Trabajando en mi ponencia',
    'La conferencia estuvo regular',
    'El lunes hay conferencia?'
  ];

  @override
  Widget build(BuildContext context) {
    return isConnected();
  }

  @override
  Widget mainWidget() {
    final controller = Controller(); // creando un objeto de tipo controller
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            PostCard(
              title: usuario[index],
              content: comentario[index],
              picUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPufXYXpGXbbx4deXcNgZVh-zudUpWJgqZhw&usqp=CAU', // foto de persona en la vista social
              onChat: () => {},
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.favorite, // icono de like
                    color: Colors.red,
                  ),
                  onPressed: () => controller.increment(index, 1),
                ),
                Obx(() => Text("  ${controller.likes[index].value}")),
                IconButton(
                  icon: const Icon(
                    Icons.favorite, // icono de like
                    color: Colors.grey,
                  ),
                  onPressed: () => controller.increment(index, 2),
                ),
                Obx(() => Text("  ${controller.dislikes[index].value}")),
              ],
            ),
          ],
        );
      },
    );
  }
}

//'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200'