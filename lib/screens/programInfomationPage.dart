import 'package:cted/Controller/programsDataController.dart';
import 'package:cted/screens/mainPage.dart';
import 'package:cted/widgets/subcribeProgramDialog.dart';
import 'package:cted/widgets/subscribeButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgramInformationPage extends StatefulWidget {
  ProgramInformationPage({super.key});

  @override
  State<ProgramInformationPage> createState() => _ProgramInformationPageState();
}

class _ProgramInformationPageState extends State<ProgramInformationPage> {
  final String programName = Get.arguments['programName'];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Get.find<ProgramsDataController>()
            .getProgramInformation(programName: programName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String author = snapshot.data!['author'];
            String followers = snapshot.data!['followers'].toString();
            String numberOfDays = snapshot.data!['numberOfDays'].toString();
            String level = snapshot.data!['level'];
            String equipment = snapshot.data!['equipment'];
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "CTED - Crossfit Training Every Day",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //프로그램 이름
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          programName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      ),
                      //Author
                      Container(
                          child: Text(
                            'Author',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                          margin: EdgeInsets.only(left: 20, right: 15)),
                      //Author 상자
                      Container(
                        margin:
                            EdgeInsets.only(left: 15, bottom: 15, right: 15),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '$author',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                      //Total Days
                      Container(
                          child: Text(
                            'Total Days',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                          margin: EdgeInsets.only(left: 20, right: 15)),
                      //Total Days 상자
                      Container(
                          margin:
                              EdgeInsets.only(left: 15, bottom: 15, right: 15),
                          padding: EdgeInsets.all(5),
                          child: Text(numberOfDays,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)))),
                      //Followers
                      Container(
                          child: Text(
                            'Followers',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                          margin: EdgeInsets.only(left: 20, right: 15)),
                      //Followers 상자
                      Container(
                          margin:
                              EdgeInsets.only(left: 15, bottom: 15, right: 15),
                          padding: EdgeInsets.all(5),
                          child: Text(followers,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)))),
                      //Level
                      Container(
                          child: Text(
                            'Level',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                          margin: EdgeInsets.only(left: 20, right: 15)),
                      //Level 상자
                      Container(
                          margin:
                              EdgeInsets.only(left: 15, bottom: 15, right: 15),
                          padding: EdgeInsets.all(5),
                          child: Text(level,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)))),
                      //Equipment
                      Container(
                          child: Text(
                            'Equipment',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                          margin: EdgeInsets.only(left: 20, right: 15)),
                      //Equipment 상자
                      Container(
                          margin:
                              EdgeInsets.only(left: 15, bottom: 15, right: 15),
                          padding: EdgeInsets.all(5),
                          child: Container(
                            child: Text(equipment,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)))),
                      //구독버튼
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 15, right: 15, bottom: 30),
                        // subcribe 버튼
                        child: SubscribeButton(
                          programName: programName,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return SubcribeProgramDialog(
                                      programName: programName);
                                }).then((_) {
                              setState(() {});
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ));
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
