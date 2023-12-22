import 'package:cted/Controller/userDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribedProgramsDeleteDialog extends StatelessWidget {
  SubscribedProgramsDeleteDialog({required this.programName});
  String programName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //dialog 텍스트 부분
            Text(
              "Do you want to delete ${programName}?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //delete 버튼
                TextButton(
                  onPressed: () async {
                    await Get.find<UserDataController>()
                        .deleteSubscribedProgram(programName: programName);
                    Get.back();
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: Text(
                    'delete',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                SizedBox(width: 40),
                //cancel버튼
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 5, horizontal: 15)),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: Text(
                    'cancel',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
