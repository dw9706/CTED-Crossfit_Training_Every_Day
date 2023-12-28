import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  MyPage({super.key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Email: ${user!.email}',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Email: ${user!.email}',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
