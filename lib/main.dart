import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:blackboard_public/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
// you can also assign this app to a FirebaseApp variable
// for example app = await FirebaseApp.initializeApp...

    await Firebase.initializeApp(
      // Replace with actual values
      options: const FirebaseOptions(
        apiKey: "AIzaSyAX_hbklUzB_n3gUckmD_I1tBMswMsZ5u8",
        appId: "1:391469083568:android:9b24856b52d6884187c475",
        messagingSenderId: "391469083568",
        projectId: "blackboard-6657d",
      ),
    );
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      // you can choose not to do anything here or either
      // In a case where you are assigning the initializer instance to a FirebaseApp variable, // do something like this:
      //
      //   app = Firebase.app('myApp');
      //
    } else {
      rethrow;
    }
  } catch (e) {
    rethrow;
  }

  runApp(const App());
}
