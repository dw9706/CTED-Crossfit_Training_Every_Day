import 'package:cted/Controller/programsDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DayContentPage extends StatelessWidget {
  String programName = Get.arguments['programName'];
  String day = Get.arguments['day'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$programName'),
      ),
      body: FutureBuilder(
          future: Get.find<ProgramsDataController>()
              .getDayContent(programName: programName, day: day),
          builder: (context, snapshot) {
            //가져온 Day Content를 스트링으로 변환
            String content = snapshot.data.toString();
            //DayContent 부분
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      //Day 텍스트 부분
                      child: Text(day,
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w500)),
                    ),
                    Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Text(
                          content,
                          style: TextStyle(fontSize: 17),
                        )),
                  ],
                ),
                scrollDirection: Axis.vertical,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 20),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
