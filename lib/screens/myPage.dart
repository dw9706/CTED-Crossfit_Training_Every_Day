import 'package:cted/screens/accountPage.dart';
import 'package:cted/screens/recordsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  MyPage({super.key});
  final user = FirebaseAuth.instance.currentUser;
  List<String> myPageList = ['Account', 'Records'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: myPageList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(myPageList[index],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                    IconButton(
                        onPressed: () {
                          Get.to(() => [AccountPage(), RecordPage()][index]);
                        },
                        iconSize: 16,
                        icon: Icon(Icons.arrow_forward_ios_outlined))
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                //모서리를 둥글게 하기 위해 사용
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4.0,
            ),
          );
        });
  }
}
