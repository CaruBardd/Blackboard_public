import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_blackboard/domain/use_cases/auth_management.dart';
import 'package:red_blackboard/domain/use_cases/controllers/authentication.dart';
import 'package:red_blackboard/domain/use_cases/controllers/internet_connection.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onViewSwitch;

  const LoginScreen({Key? key, required this.onViewSwitch}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  final networkController = Get.find<InternetConnectionController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/logo.png",
                  height: 250,
                  // width: 100,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
            child: Text(
              "Iniciar sesión",
              style: Theme.of(context)
                  .textTheme
                  .headline1, // texto o tipo de letra
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
            child: TextField(
              key: const Key("signInEmail"),
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Correo electrónico',
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 16),
            child: TextField(
              key: const Key("signInPassword"),
              controller: passwordController,
              obscureText: true, // ocultar contraseña
              obscuringCharacter: "*",
              decoration: const InputDecoration(
                border: OutlineInputBorder(), // borde
                labelText: 'Contraseña',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
                  child: ElevatedButton(
                    child: const Text("Login"), // boton de login
                    onPressed: () async {
                      if (networkController.connectionType != 0) {
                        var result = await AuthManagement.signIn(
                            email: emailController.text,
                            password: passwordController.text);
                        controller.authenticated = result;
                      } else {
                        Get.showSnackbar(
                          GetBar(
                            message: "No estas conectado a la red",
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
          TextButton(
            key: const Key("toSignUpButton"),
            child: const Text("Registrarse"),
            onPressed: widget.onViewSwitch,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
