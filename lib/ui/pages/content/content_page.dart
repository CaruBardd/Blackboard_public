import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_blackboard/domain/use_cases/controllers/authentication.dart';
import 'package:red_blackboard/domain/use_cases/controllers/ui.dart';
import 'package:red_blackboard/ui/pages/content/location/location_screen.dart';
import 'package:red_blackboard/ui/pages/content/public_offers/public_offers_screen.dart';
import 'package:red_blackboard/ui/pages/content/states/states_screen.dart';
import 'package:red_blackboard/ui/pages/content/users_offers/users_offers_screen.dart';
import 'package:red_blackboard/ui/widgets/appbar.dart';

import 'chat/chat_screen.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

// View content
  Widget _getScreen(int index) {
    switch (index) {
      case 1:
        return const UsersOffersScreen();
      case 2:
        return const PublicOffersScreen();
      case 3:
        return const LocationScreen();
      case 4:
        return const ChatScreen();
      default:
        return const StatesScreen();
    }
  }

  // We create a Scaffold that is used for all the content pages
  // We only define one AppBar, and one scaffold.
  @override
  Widget build(BuildContext context) {
    // Dependency injection: State management controller
    final UIController controller = Get.find<UIController>();
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: CustomAppBar(
        picUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhhe-nFgc-p3C6hrqE8gC4nb-LTQYHsqN_hvvXwRF6Gak1WlXXnv1XXk4p85L2i65qIK0&usqp=CAU', // foto del usuario principal que aparece en la parte superior 
        tile: const Text("Red Blackboard Public"), // red de amigos para ver estados
        context: context,
        onSignOff: () {
          authController.authenticated = false;
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Obx(() => _getScreen(controller.reactiveScreenIndex.value)),
          ),
        ),
      ),
      // Content screen navbar
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.lightbulb_outline_rounded, // icono estados
                  key: Key("statesSection"),
                ),
                label: 'Estados',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.group_outlined, // icono social
                  key: Key("socialSection"),
                ),
                label: 'Social',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.public_outlined, // icono verificado
                  key: Key("offersSection"),
                ),
                label: 'Verificado',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.place_outlined, // icono ubicacion
                  key: Key("locationSection"),
                ),
                label: 'Ubicación',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat_bubble_outline, //icono de mensaje
                  key: Key("chatSection"),
                ),
                label: 'Mensajes',
              ),
            ],
            currentIndex: controller.screenIndex,
            onTap: (index) {
              controller.screenIndex = index;
            },
          )),
    );
  }
}
