import 'package:cted/Controller/programsDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_html/flutter_html.dart';

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
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: HtmlWidget('''
                  ${content}
                  '''),
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
