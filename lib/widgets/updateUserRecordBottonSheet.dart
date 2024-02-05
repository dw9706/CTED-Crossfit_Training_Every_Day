import 'package:cted/Controller/userDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserRecordBottomSheet extends StatefulWidget {
  UpdateUserRecordBottomSheet({required this.type, required this.typeData});
  int type;
  int typeData;
  @override
  State<UpdateUserRecordBottomSheet> createState() =>
      _UpdateUserRecordBottomSheetState();
}

class _UpdateUserRecordBottomSheetState
    extends State<UpdateUserRecordBottomSheet> {
  String tmpText = '';
  @override
  Widget build(BuildContext context) {
    String typeName = [
      'Squat',
      'Deadlift',
      'Overhead Press',
      'Clean',
      'Snatch',
      'Clean & Jerk'
    ][widget.type];
    final TextFieldController =
        TextEditingController(text: widget.typeData.toString());
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              typeName,
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: TextFieldController,
              onChanged: (value) {
                tmpText = value;
              },
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Update버튼
                GestureDetector(
                  onTap: () async {
                    int? updateRecord;
                    // 문자 입력시 오류 발생
                    try {
                      updateRecord = int.parse(tmpText);
                    } on FormatException {
                      if (tmpText != '') {
                        Get.snackbar("입력값 오류", "숫자를 입력하세요",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.white,
                            icon: Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                            ));
                        return;
                      }
                    }
                    if (updateRecord != null) {
                      await Get.find<UserDataController>().updateRecord(
                          type: typeName, changeRecord: updateRecord);
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.back();
                    } else {
                      Get.snackbar("입력값 오류", "값을 입력하세요",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                          icon: Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                          ));
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    child: Center(
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                //Update버튼과 Cancel버튼 사이 간격
                SizedBox(width: 50),
                //Cancel버튼
                GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Get.back();
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
