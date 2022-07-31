import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:email_project/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Paint.enableDithering = true;

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // SetupFlavors setupFlavors = SetupFlavors();
  // await setupFlavors.setup();
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.grey,
        backgroundColor: Colors.white,
        accentColor: Colors.white
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: AnimatedSplashScreen(
      nextScreen:MyApp(), 
      splash: SizedBox(
        height: 200.0,
          child:Image.asset(
              'assets/images/Twilio.png',
              width: 200.0,
              height:200.0 ,
              fit:BoxFit.cover)),

      ),
      ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoginPage();
  }
}