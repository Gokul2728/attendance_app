import 'dart:developer';
import 'package:attendance/Auth/login.dart';
import 'package:attendance/Common/security.dart';
import 'package:attendance/Pages/home.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'Auth/Firebase/fire_options.dart';
import 'Utils/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Attendance());
}

class Attendance extends StatelessWidget {
  const Attendance({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(colorScheme: ColorScheme.light(primary: mainColor)),
      color: mainColor,
      title: 'Attendance',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const HomePage(),
    );
  }
}
  // const secretKey = 'qwertyuiopasdfghjklzxcvbnm07nq12';

  // const dbUser = 'myUsername';
  // const dbPassword = 'myPassword';
  // const dbHost = '127.0.0.1';

  // final encryptedUser = encryptCredential(dbUser, secretKey);
  // final encryptedPassword = encryptCredential(dbPassword, secretKey);
  // final encryptedHost = encryptCredential(dbHost, secretKey);

  // final decryptedUser = decryptCredential(encryptedUser, secretKey);
  // final decryptedPassword = decryptCredential(encryptedPassword, secretKey);
  // final decryptedHost = decryptCredential(encryptedHost, secretKey);

  // print('Encrypted Username: $encryptedUser');
  // print('Encrypted Password: $encryptedPassword');
  // print('Encrypted Host: $encryptedHost');

  // log('Decrypted Username: $decryptedUser');
  // log('Decrypted Password: $decryptedPassword');
  // log('Decrypted Host: $decryptedHost');