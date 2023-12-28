import 'package:cted/Controller/userDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribeButton extends StatelessWidget {
  SubscribeButton({required this.onPressed, required this.programName});
  final onPressed;
  String programName;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Get.find<UserDataController>()
            .checkThisProgramSubcribed(programName: programName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return TextButton(
                  onPressed: () {},
                  child: Text(
                    'you already subscribed',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey)));
            } else {
              return TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'subscribe',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black)));
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
