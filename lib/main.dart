import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pay_flow/app_widget.dart';

void main() async {
  var logger = Logger();
  logger.d("Logger is working!");
  Logger.level = Level.debug;

  WidgetsFlutterBinding.ensureInitialized(); // Add this
  runApp(AppFirebase());
}

class AppFirebase extends StatelessWidget {
  AppFirebase({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors

        if (snapshot.hasError) {
          return const Material(
            child: Center(
              child: Text(
                "Não foi possível inicializar o firebase",
                textDirection: TextDirection.ltr,
              ),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          debugPrint('-------------> Firebase Connectado <-------------');
          return const AppWidget();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
