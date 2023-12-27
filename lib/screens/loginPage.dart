import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cted/Controller/programsDataController.dart';
//hide 키워드를 사용하면 적힌 클래스를 제외한 클래스만 사용이 가능하다. 라이브러리간의 충돌을 막기 위함임.(firebase_ui_auth랑 firebase_auth)
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:cted/screens/mainPage.dart';
import 'package:cted/Controller/userDataController.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainPage();
          } else {
            //로그인된 유저 정보가 없으면 로그인 창을 띄운다.
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(top: 70),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'CTED',
                              textAlign: TextAlign.center,
                              textStyle: TextStyle(
                                  fontSize: 100,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                              speed: const Duration(milliseconds: 500),
                            ),
                          ],
                          totalRepeatCount: 2,
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                          child: Text(
                        "Crossfit Training Every Day",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      )),
                      height: 20,
                      width: double.infinity,
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: SignInScreen(
                          providers: providers,
                          actions: [
                            AuthStateChangeAction<SignedIn>(
                                (context, state) {}),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
