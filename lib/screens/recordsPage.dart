import 'package:cted/Controller/userDataController.dart';
import 'package:cted/widgets/updateUserRecordBottonSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  int squat = 0;
  int deadlift = 1;
  int overheadPress = 2;
  int clean = 3;
  int snatch = 4;
  int cleanJerk = 5;
  void setBottomSheet({required int type, required int typeData}) {
    Get.bottomSheet(UpdateUserRecordBottomSheet(type: type, typeData: typeData),
            backgroundColor: Colors.white)
        .then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Get.find<UserDataController>().getUserRecord(),
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
                            //squat
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Squat',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Center(
                                  child: Row(
                                    children: [
                                      Text(
                                          "${snapshot.data![squat].toString()}lb"),
                                      IconButton(
                                          onPressed: () {
                                            setBottomSheet(
                                                type: squat,
                                                typeData:
                                                    snapshot.data![squat]);
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
                            //deadlift
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Deadlift',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Center(
                                  child: Row(
                                    children: [
                                      Text(
                                          "${snapshot.data![deadlift].toString()}lb"),
                                      IconButton(
                                          onPressed: () {
                                            setBottomSheet(
                                                type: deadlift,
                                                typeData:
                                                    snapshot.data![deadlift]);
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
                            //overhead press
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Overhead Press',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Center(
                                  child: Row(
                                    children: [
                                      Text(
                                          "${snapshot.data![overheadPress].toString()}lb"),
                                      IconButton(
                                          onPressed: () {
                                            setBottomSheet(
                                                type: overheadPress,
                                                typeData: snapshot
                                                    .data![overheadPress]);
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
                            //clean
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Clean',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Center(
                                  child: Row(
                                    children: [
                                      Text(
                                          "${snapshot.data![clean].toString()}lb"),
                                      IconButton(
                                          onPressed: () {
                                            setBottomSheet(
                                                type: clean,
                                                typeData:
                                                    snapshot.data![clean]);
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
                            //snatch
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Snatch',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Center(
                                  child: Row(
                                    children: [
                                      Text(
                                          "${snapshot.data![snatch].toString()}lb"),
                                      IconButton(
                                          onPressed: () {
                                            setBottomSheet(
                                                type: snatch,
                                                typeData:
                                                    snapshot.data![snatch]);
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
                            //clean and jerk
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Clean & Jerk',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Center(
                                  child: Row(
                                    children: [
                                      Text(
                                          "${snapshot.data![cleanJerk].toString()}lb"),
                                      IconButton(
                                          onPressed: () {
                                            setBottomSheet(
                                                type: cleanJerk,
                                                typeData:
                                                    snapshot.data![cleanJerk]);
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
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                  title: Text(
                "CTED - Crossfit Training Every Day",
                style: TextStyle(fontSize: 18),
              )),
              body: Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
