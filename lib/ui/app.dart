import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackboard_public/domain/services/internet_connection_binding.dart';
import 'package:blackboard_public/domain/use_cases/controllers/authentication.dart';
import 'package:blackboard_public/domain/use_cases/controllers/ui.dart';
import 'package:blackboard_public/ui/pages/authentication/auth_page.dart';
import 'package:blackboard_public/ui/pages/content/content_page.dart';
import 'package:blackboard_public/ui/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _stateManagementInit();
    return GetMaterialApp(
      // Inyección de Binding de Internet Connection
      initialBinding: InternetConnectionBinding(),
      title: 'Blackboard Public',
      // Quitamos el banner DEBUG
      debugShowCheckedModeBanner: false,
      // Establecemos el tema claro
      theme: MyTheme.ligthTheme,
      // Establecemos el tema oscuro
      darkTheme: MyTheme.darkTheme,
      // Por defecto tomara la seleccion del sistema
      themeMode: ThemeMode.system,
      home: const AuthenticationPage(),
      // We add the two possible routes
      routes: {
        '/auth': (context) => const AuthenticationPage(),
        '/content': (context) => ContentPage(),
      },
    );
  }

  Future<void> _stateManagementInit() async {
    // Dependency Injection
    Get.put(UIController());
    AuthController authController = Get.put(AuthController());
    // Watching auth state changes
    // State management: listening for changes on using the reactive var

    //Obtener tema de SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic theme = prefs.getString("theme");
    var test = prefs.getString("asd");
    print(theme);

    if (theme != null) {
      if (theme == "dark") {
        Get.changeThemeMode(ThemeMode.dark);
      } else {
        Get.changeThemeMode(ThemeMode.light);
      }
    }

    ever(authController.reactiveAuth, (bool authenticated) {
      // Using Get.off so we can't go back when auth changes
      // This navigation triggers automatically when auth state changes on the app state
      if (authenticated) {
        Get.offNamed('/content');
      } else {
        Get.offNamed('/auth');
      }
    });
  }
}
