import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cted/UI/Widget/addProgramDayButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProgramSchedule extends StatefulWidget {
  const ProgramSchedule({super.key});

  @override
  State<ProgramSchedule> createState() => _ProgramScheduleState();
}

class _ProgramScheduleState extends State<ProgramSchedule> {
  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  DateTime _selectedDate = Get.arguments['date'];


   Future<List<String>> getDateProgramDay() async {//해당 날짜에 있는 프로그램 day가져오기
      print("ingetDate");
    String day =_selectedDate.toString().substring(0,10);
    print(day);
    var result = await firestore.collection('userData').doc(user!.uid).collection('programs').doc(Get.arguments['name']).get();
    List<String> tmp = List<String>.from(result[day] as List);
    tmp.sort();
    print(tmp);
    print("ffff");
    return tmp;
    //return result;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDateProgramDay();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          title: Text(Get.arguments['name']),
          actions: [
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
                                    ColorScheme.light(primary: Colors.green)),
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
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMM().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                AddProgramDayButton(
                    label: '+ Add Day',
                    onTap: () => Get.offNamed(
                            '/MainPage/ProgramSchdule/addProgramDayPage',
                            arguments: {
                              "name": Get.arguments["name"],
                              "date": _selectedDate
                            }))
              ],
            ),
          ), // "October 2023 add버튼 있는라인"
          Container(
            child: CalendarTimeline(
              initialDate: _selectedDate,
              firstDate: DateTime(2023, 1, 1),
              lastDate: DateTime.now().add(Duration(days: 1500)),
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                  print(_selectedDate);
                  //getDateProgramDay();
                });
              },
              leftMargin: 100,
              monthColor: Colors.grey,
              dayColor: Colors.grey,
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.green,
              dotsColor: Color(0xFF333A47),
              locale: 'en_ISO',
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: FutureBuilder<List<String>>(
                future:getDateProgramDay(),
                builder: (context,snapshot){
                  print("====");
                  print(snapshot.data);

                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: (){},
                          child: Container(
                            child: Row(
                              children: [
                                Text(snapshot.data![index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30
                                  ),),
                              ],
                            ),
                            height: 100,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                        );
                        }
                    );
                  } else if (snapshot.hasError){
                   if(snapshot.error.runtimeType == StateError){//등록한 데이가 없어서 StateError 나면....
                     return  Center(
                         child: Text("No training days")
                     );
                   } else {
                     return Center(
                         child: Text("Sorry, there is a problem")
                     );
                   }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                }
              ),
            ),
          )
          //DatePicker있는 라인
        ],
      ),
    );
  }
}

TextStyle get subHeadingStyle {
  return TextStyle(fontWeight: FontWeight.bold, fontSize: 30);
}
