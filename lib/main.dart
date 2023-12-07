import 'package:cted/screens/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:animated_text_kit/animated_text_kit.dart';

//===================================================
import 'screens/programSchedulePage.dart';
import 'screens/mainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _themeData(),
        home: LoginPage());
  }
}

_themeData() {
  return ThemeData(
      scaffoldBackgroundColor: Color(0xFFf6f7f9),
      appBarTheme: AppBarTheme(
        elevation: 1,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 19, fontWeight: FontWeight.w600),
        foregroundColor: Colors.black,
      ));
}
