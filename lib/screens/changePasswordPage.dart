import 'package:cted/screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String passwordChange = '';
  String passwordChangeCheck = '';
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CTED - Crossfit Training Every Day",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '비밀번호 재설정',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Text("새 비밀번호"),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  passwordChange = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text("새 비밀번호 확인"),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  passwordChangeCheck = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      width: 100,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black),
                      child: Center(
                        child: Text(
                          '변경하기',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      if ((passwordChange == '') &&
                          (passwordChangeCheck == '')) {
                        Get.snackbar("경고", "새 비밀번호를 입력하세요",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white,
                            icon: Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                            ));
                      } else {
                        if (passwordChange == passwordChangeCheck) {
                          await user!.updatePassword(passwordChange).then((_) {
                            FirebaseAuth.instance.signOut();
                            Get.offAll(LoginPage());
                          });
                          print(passwordChange);
                        } else {
                          Get.snackbar("경고", "새 비밀번호가 서로 다릅니다",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white,
                              icon: Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red,
                              ));
                        }
                      }
                    },
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    child: Container(
                      width: 100,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black),
                      child: Center(
                        child: Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
