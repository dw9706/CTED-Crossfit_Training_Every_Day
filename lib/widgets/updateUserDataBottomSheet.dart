import 'package:cted/Controller/userDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserDataBottomSheet extends StatefulWidget {
  UpdateUserDataBottomSheet({required this.fieldName, required this.fieldData});
  String fieldName;
  String fieldData;
  @override
  State<UpdateUserDataBottomSheet> createState() =>
      _UpdateUserDataBottomSheetState();
}

class _UpdateUserDataBottomSheetState extends State<UpdateUserDataBottomSheet> {
  String tmpText = '';
  @override
  Widget build(BuildContext context) {
    final TextFieldController = TextEditingController(text: widget.fieldData);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.fieldName,
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
                    String changeText = tmpText.trim();
                    if (changeText.length < 3) {
                      //Day를 정하지 않고 Update를 누르면 SnackBar나옴
                      Get.snackbar("필수 정보", "3자 이상 입력하세요",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                          icon: Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                          ));
                    } else {
                      await Get.find<UserDataController>()
                          .updateUserData(
                              fieldName: widget.fieldName.toLowerCase(),
                              fieldData: changeText)
                          .then((_) {
                        Get.back();
                      });
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
