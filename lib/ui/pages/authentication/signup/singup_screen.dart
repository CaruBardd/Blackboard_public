import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackboard_public/domain/use_cases/auth_management.dart';
import 'package:blackboard_public/domain/use_cases/controllers/authentication.dart';
import 'package:blackboard_public/domain/use_cases/controllers/internet_connection.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onViewSwitch;

  const SignUpScreen({Key? key, required this.onViewSwitch}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  final networkController = Get.find<InternetConnectionController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Text(
              "Crear cuenta",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextField(
              key: const Key("signUpName"),
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: TextField(
              key: const Key("signUpEmail"),
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Correo electrónico',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: TextField(
              key: const Key("signUpPassword"),
              controller: passwordController,
              obscureText: true,
              obscuringCharacter: "*",
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contraseña',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      var result = await AuthManagement.signUp(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text);
                      controller.authenticated = result;
                    },
                    child: const Text("Registrarse"),
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: widget.onViewSwitch,
            child: const Text("Entrar"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
