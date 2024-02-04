import 'package:cted/Controller/userDataController.dart';
import 'package:cted/screens/changePasswordPage.dart';
import 'package:cted/widgets/updateUserDataBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  void setBottomSheet({required String fieldName, required String fieldData}) {
    Get.bottomSheet(
            UpdateUserDataBottomSheet(
              fieldName: fieldName,
              fieldData: fieldData,
            ),
            backgroundColor: Colors.white)
        .then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Get.find<UserDataController>().getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "CTED - Crossfit Training Every Day",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Center(
                                  child: Row(
                                    children: [
                                      Text(snapshot.data![0]),
                                      IconButton(
                                          onPressed: () {
                                            setBottomSheet(
                                                fieldData: snapshot.data![0],
                                                fieldName: 'Name');
                                          },
                                          iconSize: 16,
                                          icon: Icon(Icons
                                              .arrow_forward_ios_outlined)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sex',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Center(
                                  child: Row(
                                    children: [
                                      Text(snapshot.data![1]),
                                      IconButton(
                                          onPressed: () {
                                            setBottomSheet(
                                                fieldData: snapshot.data![1],
                                                fieldName: 'Sex');
                                          },
                                          iconSize: 16,
                                          icon: Icon(Icons
                                              .arrow_forward_ios_outlined)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Country',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Center(
                                  child: Row(
                                    children: [
                                      Text(snapshot.data![2]),
                                      IconButton(
                                          onPressed: () {
                                            setBottomSheet(
                                                fieldData: snapshot.data![2],
                                                fieldName: 'Country');
                                          },
                                          iconSize: 16,
                                          icon: Icon(Icons
                                              .arrow_forward_ios_outlined)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
//모서리를 둥글게 하기 위해 사용
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 4.0,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Change Password',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            IconButton(
                                onPressed: () {
                                  Get.to(() => ChangePasswordPage());
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
                    )
                  ],
                ),
              ),
            );
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
