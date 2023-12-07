import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FirebaseAuth.instance.signOut();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue
        ),
        width: 100,
        height: 100,
        child: Center(
          child: Text("logout"),
        ),
      ),

    );
  }
}
