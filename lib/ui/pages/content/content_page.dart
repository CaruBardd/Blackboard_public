import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:red_blackboard/domain/models/internet_connection_content.dart';
import 'package:red_blackboard/domain/use_cases/auth_management.dart';
import 'package:red_blackboard/domain/use_cases/controllers/authentication.dart';
import 'package:red_blackboard/domain/use_cases/controllers/permissions_controller.dart';
import 'package:red_blackboard/domain/use_cases/controllers/ui.dart';
import 'package:red_blackboard/ui/pages/content/location/location_screen.dart';
import 'package:red_blackboard/ui/pages/content/public_offers/social_events_screen.dart';
import 'package:red_blackboard/ui/pages/content/states/states_screen.dart';
import 'package:red_blackboard/ui/pages/content/users_offers/users_offers_screen.dart';
import 'package:red_blackboard/ui/widgets/appbar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat/chat_screen.dart';

class ContentPage extends StatelessWidget with InternetConnectionContent {
  ContentPage({Key? key}) : super(key: key);
  var _permissions = Get.put(PermissionsController());
  var _context;

// View content
  Widget _getScreen(int index) {
    switch (index) {
      case 1:
        return const UsersOffersScreen();
      case 2:
        return const SocialEventsScreen();
      case 3:
        return Obx(() {
          _permissions.requestPermissions('location');
          if (_permissions.location.value) {
            return LocationScreen();
          } else {
            return _solicitarPermisos(_context);
          }
        });
      case 4:
        return const ChatScreen();
      default:
        return const StatesScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return isConnected();
  }

  Widget _solicitarPermisos(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
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
                    child: Text(
                        'No haz concedido los permisos suficientes para realizar esta acción, por favor verificar'),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  )
                ],
              ),
              Row(
                children: const [
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
              Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: Text(
                          'Revisar permisos',
                          style: GoogleFonts.openSans(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: (() => openAppSettings()),
                      ),
                    )
                  ])
            ]),
      ),
    );
  }

  // We create a Scaffold that is used for all the content pages
  // We only define one AppBar, and one scaffold.

  @override
  Widget mainWidget() {
    // Dependency injection: State management controller
    final UIController controller = Get.find<UIController>();
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: CustomAppBar(
        picUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhhe-nFgc-p3C6hrqE8gC4nb-LTQYHsqN_hvvXwRF6Gak1WlXXnv1XXk4p85L2i65qIK0&usqp=CAU', // foto del usuario principal que aparece en la parte superior
        tile: const Text(
            "Red Blackboard Public"), // red de amigos para ver estados
        context: _context,
        onSignOff: () async {
          var result = await AuthManagement.signOut();
          print(result);
          if (result) {
            authController.authenticated = false;
          }
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

  @override
  Widget noneConnectionWidget() {
    // Dependency injection: State management controller
    final UIController controller = Get.find<UIController>();
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: DisconnectedAppBar(
        tile: const Text(
            "Red Blackboard Public"), // red de amigos para ver estados
        context: _context,
        onSignOff: () {
          Get.showSnackbar(const GetSnackBar(
            message:
                'Debe estar conectado a Internet para realizar esta acción.',
            duration: Duration(seconds: 2),
          ));
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
