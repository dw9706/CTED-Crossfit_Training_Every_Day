import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cted/Controller/userDataController.dart';
import 'package:cted/screens/addDayBottomSheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../widgets/addDayButton.dart';

class ProgramSchedulePage extends StatefulWidget {
  @override
  State<ProgramSchedulePage> createState() => _ProgramSchedulePageState();
}

class _ProgramSchedulePageState extends State<ProgramSchedulePage> {
  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          title: Text(Get.arguments['programName']),
          actions: [
            //오른쪽 상단에 있는 DatePicker
            IconButton(
                icon: Icon(Icons.calendar_month),
                onPressed: () async {
                  final selectedDateInDatePicker = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 1, 1),
                      lastDate: DateTime.now().add(Duration(days: 1500)),
                      builder: (context, child) {
                        return Theme(
                            data: Theme.of(context).copyWith(
                                colorScheme:
                                    ColorScheme.light(primary: Colors.black)),
                            child: child!);
                      });
                  if (selectedDateInDatePicker != null) {
                    setState(() {
                      _selectedDate = selectedDateInDatePicker;
                    });
                  }
                })
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // "October 2023 add버튼 있는라인"
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMM().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                AddDayButton(
                    label: '+ Add Day',
                    onTap: () {
                      //+Add Day버튼을 Tap하면 Bottomsheet이 올라온다.
                      Get.bottomSheet(
                              AddDayBottomSheet(
                                  programName: Get.arguments['programName'],
                                  date: _selectedDate),
                              backgroundColor: Colors.white)
                          .then((value) {
                        setState(() {});
                      });
                    })
              ],
            ),
          ),
          //Calendar Timeline 있는 라인
          Container(
            child: CalendarTimeline(
              initialDate: _selectedDate,
              firstDate: DateTime(2023, 1, 1),
              lastDate: DateTime.now().add(Duration(days: 1500)),
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                  print(_selectedDate);
                });
              },
              leftMargin: 100,
              monthColor: Colors.grey,
              dayColor: Colors.grey,
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Color(0xffaf9969),
              dotsColor: Color(0xFF333A47),
              locale: 'en_ISO',
            ),
          ),
          //Day들 있는 곳
          Expanded(
            child: FutureBuilder<List<String>>(
                future: Get.find<UserDataController>().getScheduleDays(
                    programName: Get.arguments['programName'],
                    selectedDate: _selectedDate),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.hasData);
                    print(snapshot.data);
                    return GetBuilder<UserDataController>(
                      builder: (controller) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              //각각 Day 카드
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      //Day카드 삭제 아이콘
                                      Container(
                                        alignment: Alignment.topRight,
                                        margin:
                                            EdgeInsets.only(top: 5, right: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            //Program 지우는 dialog창 띄우기
                                            print("delete program?");
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      //Day카드 Day텍스트
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          snapshot.data![index],
                                          style: TextStyle(
                                              height: 1,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 30),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 100,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              );
                            }),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    if (snapshot.error.runtimeType == StateError) {
                      //등록한 데이가 없어서 StateError 나면....
                      return Center(child: Text("No training days"));
                    } else {
                      return Center(child: Text("Sorry, there is a problem"));
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}

TextStyle get subHeadingStyle {
  return TextStyle(fontWeight: FontWeight.bold, fontSize: 30);
}
