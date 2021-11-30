import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/offer_card.dart';

class UsersOffersScreen extends StatefulWidget {
  // UsersOffersScreen empty constructor
  const UsersOffersScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<UsersOffersScreen> {
  final items = List<String>.generate(20, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    final controller = Controller(); // creando un objeto de tipo controller
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            PostCard(
              title: 'Mariana Diaz',
              content:
                  'Estoy muy emocionada, me dieron el ascenso para celebrar los invito a mi casa esta noche.',
              picUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPufXYXpGXbbx4deXcNgZVh-zudUpWJgqZhw&usqp=CAU', // foto de persona en la vista social
              onChat: () => {},
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.exposure_neg_1,
                    color: primaryColor,
                  ),
                  onPressed: () => controller.decrement(),
                ),
                IconButton(
                  icon: Icon(
                    Icons.exposure_plus_1_outlined,
                    color: primaryColor,
                  ),
                  onPressed: () => controller.increment(),
                ),
                Obx(() => Text("      ${controller.count.value}")),
              ],
            ),
          ],
        );
      },
    );
  }
}

class Controller extends GetxController {
  var count = 0.obs;
  void increment() {
    count.value += 1;
  }

  void decrement() {
    if (count.toInt() > 0) {
      count.value -= 1;
    }
  }
}
//'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200'